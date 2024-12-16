import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driver_booking_model.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/custom_tab_bar.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/view/dashboard/rental/history/all_booking_container.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DriverHistoryManagment extends StatefulWidget {
  final String myID;

  const DriverHistoryManagment({super.key, required this.myID});

  @override
  State<DriverHistoryManagment> createState() => _DriverHistoryManagmentState();
}

class _DriverHistoryManagmentState extends State<DriverHistoryManagment>
    with SingleTickerProviderStateMixin {
  List<String> tabList = ['BOOKED', 'ONGOING', 'COMPLETED', 'CANCELLED'];
  TabController? _tabController;
  int initialIndex = 0;
  int currentPage = 0;
  bool isLoadingMore = false;
  bool lastPage = false; // Assuming true at the start
  final int pageSize = 10; // Set your page size
  final ScrollController _scrollController = ScrollController();
  List<Content> bookedHistory = [];
  String status = 'BOOKED';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabList.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getPackageBooking();
      },
    );
    _tabController?.addListener(() {
      initialIndex = _tabController?.index ?? 0;
      setState(() {
        currentPage = 0; // Reset pagination when tab changes
        bookedHistory.clear(); // Clear the history
        lastPage = false;
      });
      getPackageBooking();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list
        if (!isLoadingMore && !lastPage) {
          print('testing......');
          getPackageBooking();
        }
      }
    });
  }

  Future<void> getPackageBooking() async {
    if (isLoadingMore || lastPage) return;

    setState(() {
      isLoadingMore = true;
    });
    status = tabList[initialIndex] == 'ONGOING'
        ? "ON_RUNNING"
        : tabList[initialIndex];
    try {
      final response = await Provider.of<DriverGetBookingListViewModel>(context,
              listen: false)
          .fetchDriverGetBookingListViewModel({
        'driverId': widget.myID,
        'pageNumber': currentPage.toString(),
        'pageSize': pageSize.toString(),
        'bookingStatus': status,
      }, context);
      // Update history with new data
      final data = response?.data.content ?? [];

      print('Fetched data: $data');

      if (data.isNotEmpty) {
        setState(() {
          bookedHistory.addAll(data); // Append new data to the existing list
          currentPage++; // Increment page number
          lastPage = data.length < pageSize; // Check if this is the last page
        });
      } else {
        setState(() {
          lastPage = true; // No more data available
        });
      }
    } catch (e) {
      debugPrint('errror $e');
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  // List<Content> onRunningData = [];
  // List<Content> completedData = [];
  // List<Content> cancelledData = [];
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    String status = context
        .watch<DriverGetBookingDetailsViewModel>()
        .DataList
        .status
        .toString();
    return CustomPagelayout(
        appBarTitle: 'Rental Management',
        child: Customtabbar(
            controller: _tabController,
            tabs: tabList,
            viewchildren: List.generate(tabList.length, (index) {
              return Consumer<DriverGetBookingListViewModel>(
                builder: (context, viewModel, child) {
                  final response = viewModel.DataList;

                  if (response.status.toString() == "Status.loading") {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: greenColor,
                    ));
                  } else if (response.status.toString() == "Status.error") {
                    return const Center(
                        child: Text(
                      'No data found',
                      style: TextStyle(
                          color: redColor, fontWeight: FontWeight.w500),
                    ));
                  } else if (response.status.toString() == "Status.completed") {
                    final data = response.data?.data.content ?? [];

                    if (data.isEmpty && currentPage == 0) {
                      // return const Center(child: Text('No Data Available'));
                      return Center(
                          child: Container(
                              decoration: const BoxDecoration(),
                              child: Text(
                                'No data found',
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              )));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: bookedHistory.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == bookedHistory.length) {
                          return isLoadingMore
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink(); // Hide if not loading
                        }
                        final item = bookedHistory[index];
                        return HistoryDetailsContainer(
                          loader: status == "Status.loading" &&
                              selectedIndex == index,
                          onTapContainer: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            Provider.of<DriverGetBookingDetailsViewModel>(
                                    context,
                                    listen: false)
                                .fetchDriverGetBookingDetailsViewModel({
                              "id": item.id.toString(),
                            }, context, item.id.toString(), widget.myID).then(
                                    (value) {
                              getPackageBooking();
                            });
                          },
                          bookingId: item.id ?? '',
                          carImage: item.vehicle?.images ?? [],
                          seat: item.vehicle?.seats?.toString() ?? "",
                          fuelType: item.vehicle?.fuelType?.toString() ?? "",
                          carName: item.vehicle?.carName ?? "",
                          status: item.bookingStatus == 'ON_RUNNING'
                              ? 'ONGOING'
                              : item.bookingStatus.toString(),
                          date: item.date?.toString() ?? "",
                          // rentalCharge: item.rentalCharge?.toString() ?? "",
                        );
                      },
                    );
                  }

                  return const Center(child: Text('No data found'));
                },
              );
            })));
  }
}
