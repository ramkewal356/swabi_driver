import 'package:flutter/material.dart';
import 'package:flutter_driver/model/get_issue_by_booking_id_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_driver/view_model/raiseIssue_view_model.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Packagedetailpage extends StatefulWidget {
  final String bookingId;
  final String driverId;
  const Packagedetailpage(
      {super.key, required this.bookingId, required this.driverId});

  @override
  State<Packagedetailpage> createState() => _PackagedetailpageState();
}

class _PackagedetailpageState extends State<Packagedetailpage> {
  bool btn = false;
  String? dateFormat;
  String _timeZone = 'unknown';
  String formattedTodayDate = '';
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getIssueBybookingId();
      },
    );

    super.initState();
    getTimezone();
    final date = DateTime.now();
    setState(() {
      dateFormat = DateFormat('dd-MM-yyyy').format(date);
    });
    formattedTodayDate = dateFormat.toString();
  }

  Future<void> getIssueBybookingId() async {
    Provider.of<RaiseissueViewModel>(context, listen: false)
        .getIssueByBookingId(
            context: context,
            bookingId: widget.bookingId,
            userId: widget.driverId,
            bookingType: 'PACKAGE_BOOKING');
  }

  Future<void> getTimezone() async {
    String timezone;

    try {
      timezone = await FlutterTimezone.getLocalTimezone();
      print('hgjhjhj.............$timezone');
      if (!mounted) return;

      setState(() {
        _timeZone = timezone;
      });
    } catch (e) {
      print('Could not get the local timezone');
    }
  }

  @override
  Widget build(BuildContext context) {
    GetIssueByBookingIdModel? getIssueByBookingId =
        context.watch<RaiseissueViewModel>().getissueDetail.data;
    return CustomPagelayout(
      appBarTitle: 'Package Details',
      child:
          Consumer<DriverPackageViewModel>(builder: (context, viewData, child) {
        if (viewData.isLoading1) {
          return const Center(
              child: CircularProgressIndicator(
            color: greenColor,
          ));
        } else if (viewData.driverPackageDetailModel == null) {
          return const Center(
              child: Text(
            'No packages available',
            style: TextStyle(color: redColor, fontWeight: FontWeight.w600),
          ));
        } else {
          var package = viewData.driverPackageDetailModel?.data;
          print('daystatus......${package?.pickupLocation}');
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 120,
                    // constraints: const BoxConstraints(minHeight: 100, maxHeight: 150),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10)),
                    // padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      minVerticalPadding: 8.0,
                      visualDensity:
                          const VisualDensity(horizontal: -2, vertical: 4),
                      dense: true,
                      leading: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        width: 80,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: (package?.vehicle?.images ?? []).isEmpty
                              ? Image.asset(
                                  car3,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  (package?.vehicle?.images ?? []).isEmpty
                                      ? 'https://static.vecteezy.com/system/resources/thumbnails/022/059/000/small/no-image-available-icon-vector.jpg'
                                      : package?.vehicle?.images?[0] ?? '',
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      title: Text(
                        package?.vehicle?.carName ?? '',
                        style: pageHeadingTextStyle,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${package?.vehicle?.brandName} / ${package?.vehicle?.carType} | ${package?.vehicle?.fuelType}',
                            style: textTextStyle,
                          ),
                          Text(
                            '${package?.vehicle?.vehicleNumber} | ${package?.vehicle?.seats} Seats',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    // child: Row(
                    //   children: [
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(color: Colors.black12),
                    //           borderRadius: BorderRadius.circular(10)),
                    //       width: 80,
                    //       height: 80,
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: (package?.vehicle?.images ?? []).isEmpty
                    //             ? Image.asset(
                    //                 car3,
                    //                 fit: BoxFit.cover,
                    //               )
                    //             : Image.network(
                    //                 (package?.vehicle?.images ?? []).isEmpty
                    //                     ? 'https://static.vecteezy.com/system/resources/thumbnails/022/059/000/small/no-image-available-icon-vector.jpg'
                    //                     : package?.vehicle?.images?[0] ?? '',
                    //                 fit: BoxFit.fill,
                    //               ),
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //             child: Text(
                    //               package?.vehicle?.carName ?? '',
                    //               style: pageHeadingTextStyle,
                    //             ),
                    //           ),
                    //           Text(
                    //               '${package?.vehicle?.brandName} / ${package?.vehicle?.carType} | ${package?.vehicle?.fuelType}'),
                    //           // Flexible(
                    //           //   child: Row(
                    //           //     children: [
                    //           //       Text(
                    //           //         '${package?.vehicle?.brandName} / ${package?.vehicle?.carType}',
                    //           //         // maxLines: 1,
                    //           //         // overflow: TextOverflow.ellipsis,
                    //           //       ),
                    //           //       Text(' | '),
                    //           //       Text(
                    //           //         package?.vehicle?.fuelType ?? '',
                    //           //         maxLines: 1,
                    //           //         // overflow: TextOverflow.ellipsis,
                    //           //       )
                    //           //     ],
                    //           //   ),
                    //           // ),
                    //           Row(
                    //             children: [
                    //               Text(
                    //                 '${package?.vehicle?.vehicleNumber}',
                    //                 style: textStyle,
                    //               ),
                    //               const SizedBox(
                    //                   height: 15,
                    //                   child: VerticalDivider(
                    //                     color: Colors.black,
                    //                     thickness: 1.5,
                    //                   )),
                    //               Text(
                    //                 '${package?.vehicle?.seats} Seats',
                    //                 style: textStyle,
                    //               )
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),

                    //   ],
                    // ),
                  ),
                  containerItem(
                      context,
                      null,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(
                          //   height: 160,
                          //   child: VerticalDivider(
                          //     width: 3,
                          //     thickness: 3,
                          //     color: btnColor,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Package Booking ID : ${package?.packageBookingId}',
                              style: textTextStyle1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Status :  ',
                                  style: titleTextStyle,
                                ),
                                Text(
                                  '${package?.dayStatus}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: package?.dayStatus == 'PENDING'
                                          ? redColor
                                          : package?.dayStatus == 'ONGOING'
                                              ? Colors.orange
                                              : greenColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 115,
                            decoration: const BoxDecoration(
                                color: background,
                                border: Border(
                                    top: BorderSide(color: Colors.black26),
                                    right: BorderSide(color: Colors.black26),
                                    bottom: BorderSide(color: Colors.black26)),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 3),
                              child: Center(
                                  child: Text(
                                'Pick Up',
                                style: textTextStyle1,
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_outlined),
                                Flexible(
                                  child: Text(
                                    package?.pickupLocation ?? 'N/A',
                                    style: textTextStyle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.calendar_month_outlined,
                                  size: 20),
                              Text(
                                package?.date ?? 'N/A',
                                style: textTextStyle1,
                              ),
                              const SizedBox(
                                height: 15,
                                child: VerticalDivider(),
                              ),
                              const Icon(
                                Icons.timer_outlined,
                                size: 18,
                              ),
                              Text(
                                package?.pickupTime ?? 'N/A',
                                style: textTextStyle1,
                              ),
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Text(
                      'Customer Details',
                      style: titleTextStyle,
                    ),
                  ),
                  containerItem(
                      context,
                      null,
                      Column(
                        children: [
                          InfoRow(
                              label: 'Customer Name',
                              value:
                                  '${package?.user?.firstName} ${package?.user?.lastName}'),
                          const SizedBox(
                            height: 5,
                          ),
                          InfoRow(
                              label: 'Email', value: '${package?.user?.email}'),
                          const SizedBox(
                            height: 5,
                          ),
                          InfoRow(
                              label: 'Primary Contact',
                              value:
                                  '+${package?.user?.countryCode} ${package?.user?.mobile}'),
                          const SizedBox(
                            height: 5,
                          ),
                          package?.alternateMobile == ''
                              ? const SizedBox()
                              : InfoRow(
                                  label: 'Secondary Contact',
                                  value:
                                      '+${package?.alternateMobileCountryCode} ${package?.alternateMobile}'),
                        ],
                      )),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  //   child: Text(
                  //     'Traveller Contacts',
                  //     style: titleTextStyle,
                  //   ),
                  // ),
                  // containerItem(
                  //     context,
                  //     null,
                  //     Column(
                  //       children: [
                  //         InfoRow(
                  //             label: 'Primary Contact',
                  //             value:
                  //                 '+${package?.countryCode} ${package?.mobile}'),
                  //         const SizedBox(
                  //           height: 5,
                  //         ),

                  //       ],
                  //     )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Text(
                      'Activity Details',
                      style: titleTextStyle,
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: package?.activityList?.length,
                      itemBuilder: (context, index) {
                        var activity = package?.activityList?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: containerItem(
                            context,
                            null,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: btnColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Activity:${index + 1}',
                                    style: const TextStyle(
                                        color: background,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  '${activity?.activityName}',
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: greenColor,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InfoRow(
                                        label: 'Activity Hours',
                                        value: '${activity?.activityHours}'),
                                    InfoRow(
                                        label: 'Time To Visit ',
                                        value: '${activity?.bestTimeToVisit}'),
                                    InfoRow(
                                        label: 'Opening Time',
                                        value: '${activity?.startTime}'),
                                    InfoRow(
                                        label: 'Closing Time',
                                        value: '${activity?.endTime}'),
                                  ],
                                ),
                                InfoRow(
                                    label: 'Location',
                                    value: '${activity?.address}')
                                // textItem(
                                //     title: 'Location',
                                //     titleValue: '${activity?.address}')
                              ],
                            ),
                          ),
                        );
                      }),
                  (package?.dayStatus == 'COMPLETED' ||
                          package?.dayStatus == 'CANCELLED')
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (getIssueByBookingId?.data ?? []).isEmpty
                                  ? CustomButtonSmall(
                                      height: 40,
                                      width: 120,
                                      btnHeading: 'Raise Issue',
                                      onTap: () {
                                        context.push('/rideIssue', extra: {
                                          'bookingId':
                                              package?.packageBookingId ?? '',
                                          'bookingType': 'PACKAGE_BOOKING'
                                        });
                                      })
                                  : CustomButtonSmall(
                                      height: 40,
                                      width: 120,
                                      btnHeading: 'View Issue',
                                      onTap: () {
                                        context.push("/getRaiseIssue");
                                      }),
                              package?.dayStatus == 'PENDING'
                                  ? CustomButtonSmall(
                                      width: 170,
                                      height: 40,
                                      btnHeading: 'Activity Start',
                                      isEnabled:
                                          formattedTodayDate == package?.date
                                              ? btn = true
                                              : false,
                                      onTap: btn != true
                                          ? null
                                          : () {
                                              showConfirmation(
                                                  context: context,
                                                  loading: viewData.isLoading,
                                                  title: "Start",
                                                  onTap: () {
                                                    if (package
                                                            ?.pickupLocation ==
                                                        null) {
                                                      Utils.toastMessage(
                                                          'Pickup location is required to start the ride');
                                                    } else {
                                                      setState(() {
                                                        viewData.isLoading =
                                                            true;
                                                      });
                                                      viewData.activityStart(
                                                          context: context,
                                                          packageBookingId: package
                                                              ?.packageBookingId,
                                                          date: package?.date,
                                                          zoneId: _timeZone);
                                                      setState(() {
                                                        viewData.isLoading =
                                                            false;
                                                      });
                                                      if (!viewData.isLoading) {
                                                        Provider.of<DriverPackageViewModel>(
                                                                context,
                                                                listen: false)
                                                            .updateDayStatus(
                                                                'ONGOING');
                                                      }
                                                    }
                                                  });
                                            })
                                  : package?.dayStatus == 'ONGOING'
                                      ? CustomButtonSmall(
                                          width: 170,
                                          height: 40,
                                          btnHeading: 'Activity Complete',
                                          isEnabled: formattedTodayDate ==
                                                  package?.date
                                              ? btn = true
                                              : false,
                                          onTap: btn != true
                                              ? null
                                              : () {
                                                  showConfirmation(
                                                      context: context,
                                                      loading:
                                                          viewData.isLoading,
                                                      title: 'Complete',
                                                      onTap: () {
                                                        setState(() {
                                                          viewData.isLoading =
                                                              true;
                                                        });
                                                        Provider.of<DriverPackageViewModel>(
                                                                context,
                                                                listen: false)
                                                            .activityComplete(
                                                                context:
                                                                    context,
                                                                packageBookingId:
                                                                    package
                                                                        ?.packageBookingId,
                                                                date: package
                                                                    ?.date,
                                                                zoneId:
                                                                    _timeZone);
                                                        setState(() {
                                                          viewData.isLoading =
                                                              false;
                                                        });
                                                        if (!viewData
                                                            .isLoading) {
                                                          Provider.of<DriverPackageViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .updateDayStatus(
                                                                  'COMPLETED');
                                                          context.pop('update');
                                                        }
                                                      });
                                                })
                                      : Container()
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget containerItem(
    BuildContext context,
    double? height,
    Widget child,
  ) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: bgGreyColor, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  void showConfirmation(
      {required BuildContext context,
      required String title,
      required bool loading,
      required void Function()? onTap}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: background,
        isDismissible: false,
        // barrierDismissible:
        //     false, // Prevents closing the modal by tapping outside
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (BuildContext dialogContext) {
          return SingleChildScrollView(
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              titlePadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Confirmation',
                    style: TextStyle(
                        color: btnColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      alignment: Alignment.topRight,
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: btnColor,
                      )),
                ],
              ),
              backgroundColor: background,
              insetPadding: const EdgeInsets.all(10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              actionsPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Text(
                  'Are you sure you want to $title this activity?',
                  textAlign: TextAlign.center,
                  style: titleTextStyle,
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: btnColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Exit',
                      style: textTextStyle1,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButtonSmall(
                    width: double.infinity,
                    loading: loading,
                    height: 45,
                    btnHeading: 'Yes, $title',
                    onTap: onTap),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        });
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          // flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

textItem({required String title, required String titleValue}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$title :',
        style: titleTextStyle,
      ),
      const SizedBox(
        width: 5,
      ),
      Expanded(
        child: Text(
          titleValue,
          style: textStyle,
        ),
      )
    ],
  );
}

completedTextItem() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.green, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        ),
        Text(
          'Journey Completed',
          style: btnTextStyle,
        )
      ],
    ),
  );
}

ongoingTextItem() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        const Icon(
          Icons.car_rental_outlined,
          color: Colors.white,
        ),
        Text(
          'Journey Ongoing',
          style: btnTextStyle,
        )
      ],
    ),
  );
}

pendingTextItem() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.yellow, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        const Icon(
          Icons.access_time_outlined,
          color: Colors.white,
        ),
        Text(
          'Journey Pending',
          style: btnTextStyle,
        )
      ],
    ),
  );
}
// }
