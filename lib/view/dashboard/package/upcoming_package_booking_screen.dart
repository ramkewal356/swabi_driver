import 'package:flutter/material.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/view/dashboard/package/custom_package_view_screen.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UpcommingPackagebooking extends StatefulWidget {
  const UpcommingPackagebooking({super.key});

  @override
  State<UpcommingPackagebooking> createState() =>
      _UpcommingPackagebookingState();
}

class _UpcommingPackagebookingState extends State<UpcommingPackagebooking> {
  @override
  void initState() {
    super.initState();
    getUpcommingPackage();
  }

  void getUpcommingPackage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DriverPackageViewModel>().getPackageBookingList();
    });
  }

  int? indexValue;
  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
        appBarTitle: 'Upcoming Package Booking',
        onTap: () {
          context.go('/'); // ALWAYS go to dashboard
        },
        child: Consumer<DriverPackageViewModel>(
          builder: (context, viewData, child) {
            if (viewData.packageBookingList.status == Status.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
              ));
            } else if (viewData.packageBookingList.data == null ||
                (viewData.packageBookingList.data?.data ?? []).isEmpty) {
              return const Center(
                  child: Text(
                'No Data Found',
                style: TextStyle(color: redColor, fontWeight: FontWeight.w600),
              ));
            } else {
              return ListView.builder(
                itemCount: viewData.packageBookingList.data?.data?.length,
                itemBuilder: (context, index) {
                  var package = viewData.packageBookingList.data?.data?[index];
                  var activity =
                      package?.activityList
                      ?.map((e) => e.activityName)
                      .toList();

                  return CustomPackageViewPage(
                    driverAssignId: package?.driverAssignedId.toString() ?? '',
                    date: package?.date.toString() ?? '',
                    pickUpLocation: package?.pickupLocation ?? 'N/A',
                    activityName: activity?.join(',') ?? '',
                    dayStatus: package?.dayStatus.toString() ?? '',
                    pickupTime: package?.pickupTime ?? 'N/A',
                    loader: indexValue == index,
                    onTap: () {
                      setState(() {
                        indexValue = index;
                      });
                      context.push('/packageDetailPage', extra: {
                        "driverAssignedId":
                            package?.driverAssignedId.toString(),
                        "bookingId": package?.packageBookingId.toString()
                      }).then((onValue) {
                        getUpcommingPackage();
                        setState(() {
                          indexValue = null;
                        });
                      });
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
