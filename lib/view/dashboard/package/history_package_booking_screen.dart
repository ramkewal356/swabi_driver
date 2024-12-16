import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DriverPackageViewModel>(context, listen: false)
          .getPackageBookingHistoryList(context: context);
    });
  }

  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<DriverPackageViewModel>(
      builder: (context, viewData, child) {
        if (viewData.isLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: greenColor,
          ));
        } else if (viewData.driverPackageBookingListModel?.data == null ||
            viewData.driverPackageBookingListModel!.data.isEmpty) {
          return const Center(
              child: Text(
            'No Data Found',
            style: TextStyle(color: redColor, fontWeight: FontWeight.w600),
          ));
        } else {
          return ListView.builder(
            itemCount: viewData.driverPackageBookingListModel!.data.length,
            itemBuilder: (context, index) {
              var package = viewData.driverPackageBookingListModel!.data[index];
              var activity =
                  package.activityList.map((e) => e.activityName).toList();
              return Custompackageviewpage(
                driverAssignId: package.driverAssignedId.toString(),
                date: package.date.toString(),
                pickUpLocation: package.pickupLocation ?? 'N/A',
                activityName: activity.join(','),
                daySatus: package.dayStatus.toString(),
                pickupTime: package.pickupTime ?? 'N/A',
                loader: viewData.isLoading1 && selectIndex == index,
                onTap: viewData.isLoading
                    ? null
                    : () async {
                        setState(() {
                          // viewData.isLoading = true;
                          selectIndex = index;
                        });
                        Provider.of<DriverPackageViewModel>(context,
                                listen: false)
                            .getPackageDetailList(
                                context: context,
                                driverAssignId: package.driverAssignedId);
                        // setState(() {
                        //   viewData.isLoading = false;
                        // });
                        if (viewData.isLoading1) {
                          print(
                              'object.........updated ${viewData.isLoading1}');
                          context.push('/packageDetailPage', extra: {
                            "bookingId": package.packageBookingId.toString(),
                            "driverId": package.driverId.toString()
                          }).then((onValue) {
                            print('object.........updated');
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<DriverPackageViewModel>(context,
                                      listen: false)
                                  .getPackageBookingHistoryList(
                                      context: context);
                            });
                          });
                        }
                      },
              );
            },
          );
        }
      },
    );
  }
}
