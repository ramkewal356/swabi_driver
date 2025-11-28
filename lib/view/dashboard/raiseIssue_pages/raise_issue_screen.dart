import 'package:flutter/material.dart';

import 'package:flutter_driver/widgets/custom_page_layout.dart';

import 'package:flutter_driver/widgets/custom_tab_bar.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/view/dashboard/raiseIssue_pages/issue_container.dart';
import 'package:flutter_driver/view_model/raise_issue_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';

class RaiseIssueScreen extends StatefulWidget {
  const RaiseIssueScreen({super.key});

  @override
  State<RaiseIssueScreen> createState() => _RaiseIssueScreenState();
}

class _RaiseIssueScreenState extends State<RaiseIssueScreen>
    with SingleTickerProviderStateMixin {
  List<String> tabList = ['ALL', 'OPEN', 'INPROGRESS', 'RESOLVED'];
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();

  int intialIndex = 0;
  String status = 'ALL';
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabList.length, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRaiseIssue(isFilter: true);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onFilterChanged(int index) {
    setState(() {
      status = tabList[index] == 'INPROGRESS' ? "IN_PROGRESS" : tabList[index];
      debugPrint('rental status,,,,,, $status');
    });
    getRaiseIssue(isFilter: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      getRaiseIssue(isPagination: true);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void getRaiseIssue({bool isFilter = false, bool isPagination = false}) {
    context.read<RaiseIssueViewModel>().getRaiseIssueApi(
        issueStatus: status, isFilter: isFilter, isPagination: isPagination);
  }

  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      appBarTitle: 'Raised Issue',
      child: Customtabbar(
          controller: _tabController,
          onTap: _onFilterChanged,
          tabs: tabList,
          viewchildren: List.generate(tabList.length, (index) {
            return Consumer<RaiseIssueViewModel>(
              builder: (context, value, child) {
                if (value.raiseIssueList.status == Status.loading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: greenColor,
                  ));
                } else if (value.raiseIssueList.status == Status.completed) {
                  var response = value.raiseIssueList.data ?? [];
                  return (value.raiseIssueList.data ?? []).isEmpty
                      ? const Center(
                          child: Text(
                            'No data found',
                            style: TextStyle(
                                color: redColor, fontWeight: FontWeight.w600),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              response.length + (value.isLastPage ? 0 : 1),
                          itemBuilder: (context, index) {
                            var data = response[index];
                            if (index == response.length) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: greenColor,
                              ));
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: IssueContainer(
                                  issueId: data.issueId.toString(),
                                  bookingId: data.bookingId.toString(),
                                  userId: data.raisedById.toString(),
                                  status: data.issueStatus.toString(),
                                  issueDate: DateFormat('dd-MM-yyyy').format(
                                      data.createdDate ?? DateTime.now()),
                                  bookingType: data.bookingType.toString(),
                                  loader: selectIndex == index,
                                  onTap: () {
                                    setState(() {
                                      selectIndex = index;
                                    });
                                    context.push('/issueDetailsbyId', extra: {
                                      "issueId": data.issueId.toString()
                                    }).then((onValue) {
                                      getRaiseIssue(isFilter: true);
                                      setState(() {
                                        selectIndex = null;
                                      });
                                    });
                                  }),
                            );
                          });
                } else {
                  return Container();
                }
              },
            );
          })),
    );
  }
}
