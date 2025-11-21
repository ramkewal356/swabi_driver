import 'package:flutter/material.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/view/dashboard/package/custom_package_view_screen.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HistoryPackagebooking extends StatefulWidget {
  const HistoryPackagebooking({super.key});

  @override
  State<HistoryPackagebooking> createState() => _HistoryPackagebookingState();
}

class _HistoryPackagebookingState extends State<HistoryPackagebooking> {
  @override
  void initState() {
    super.initState();
    getPackageHistoryList();
  }

  void getPackageHistoryList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DriverPackageViewModel>().getPackageBookingHistoryList();
    });
  }

  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<DriverPackageViewModel>(
      builder: (context, viewData, child) {
        if (viewData.packageHistoryList.status == Status.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: greenColor,
          ));
        } else if (viewData.packageHistoryList.data?.data == null ||
            (viewData.packageHistoryList.data?.data ?? []).isEmpty) {
          return const Center(
              child: Text(
            'No Data Found',
            style: TextStyle(color: redColor, fontWeight: FontWeight.w600),
          ));
        } else {
          return ListView.builder(
            itemCount: viewData.packageHistoryList.data?.data?.length,
            itemBuilder: (context, index) {
              var package = viewData.packageHistoryList.data?.data?[index];
              var activity =
                  package?.activityList?.map((e) => e.activityName).toList();
              return CustomPackageViewPage(
                driverAssignId: package?.driverAssignedId.toString() ?? '',
                date: package?.date.toString() ?? '',
                pickUpLocation: package?.pickupLocation ?? 'N/A',
                activityName: activity?.join(',') ?? '',
                dayStatus: package?.dayStatus.toString() ?? '',
                pickupTime: package?.pickupTime ?? 'N/A',
                loader: selectIndex == index,
                onTap: () {
                  setState(() {
                    selectIndex = index;
                  });
                  context.push('/packageDetailPage', extra: {
                    "driverAssignedId": package?.driverAssignedId.toString(),
                    "driverId": package?.driverId.toString()
                  }).then((onValue) {
                    getPackageHistoryList();
                    setState(() {
                      selectIndex = null;
                    });
                  });
                },
              );
            },
          );
        }
      },
    );
  }
}
