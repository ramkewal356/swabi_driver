import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/model/driver_booking_model.dart';
import 'package:flutter_driver/model/get_issue_by_booking_id_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/custom_text_widget.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:flutter_driver/view_model/raiseIssue_view_model.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingDetailsOfDriver extends StatefulWidget {
  final String bookingId;
  final String driverId;

  const BookingDetailsOfDriver(
      {super.key, required this.bookingId, required this.driverId});

  @override
  State<BookingDetailsOfDriver> createState() => _BookingDetailsOfDriverState();
}

class _BookingDetailsOfDriverState extends State<BookingDetailsOfDriver> {
  List<TextEditingController> controller =
      List.generate(1, (index) => TextEditingController());

  bool btnHeading = false;

  String btn = "Start";
  bool btnEnable = false;
  String? dateFormat;
  String _timeZone = 'unknown';
  String formattedTodayDate = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getIssueBybookingId();
      },
    );

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
            bookingType: 'RENTAL_BOOKING');
  }

  Future<void> getTimezone() async {
    String timezone;

    try {
      timezone = await FlutterTimezone.getLocalTimezone();
      debugPrint('hgjhjhj.............$timezone');
      if (!mounted) return;

      setState(() {
        _timeZone = timezone;
      });
    } catch (e) {
      debugPrint('Could not get the local timezone');
    }
  }

  bool loading = false;
  DriverGetBookingDetailsData? bookingDetails, guestDetails;
  var bookingDetailsStatus;
  @override
  Widget build(BuildContext context) {
    setState(() {
      bookingDetailsStatus = context
          .watch<DriverGetBookingDetailsViewModel>()
          .DataList
          .data
          ?.data
          .bookingStatus;
    });
    setState(() {
      bookingDetails = (context
              .watch<DriverGetBookingDetailsViewModel>()
              .DataList
              .data
              ?.data ??
          "") as DriverGetBookingDetailsData?;
    });
    GetIssueByBookingIdModel? getIssueByBookingId =
        context.watch<RaiseissueViewModel>().getissueDetail.data;
    // guestDetails = context
    //     .watch<DriverGetBookingDetailsViewModel>()
    //     .DataList
    //     .data
    //     !.data
    //     .driverGetBookingDetailsGuest;

    // print(guestDetails.guestName);
    return CustomPagelayout(
      appBarTitle: 'Booking Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10)),
            // padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              minVerticalPadding: 8.0,
              visualDensity: const VisualDensity(horizontal: -2, vertical: 4),
              dense: true,
              leading: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10)),
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: (bookingDetails?.vehicle.images ?? []).isEmpty
                      ? Image.asset(
                          car3,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          (bookingDetails?.vehicle.images ?? []).isEmpty
                              ? 'https://static.vecteezy.com/system/resources/thumbnails/022/059/000/small/no-image-available-icon-vector.jpg'
                              : bookingDetails?.vehicle.images[0],
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              title: Text(
                bookingDetails?.vehicle.carName ?? '',
                style: pageHeadingTextStyle,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${bookingDetails?.kilometers} KM / ${bookingDetails?.totalRentTime} Hr | ${bookingDetails?.vehicle.fuelType}',
                    style: textTextStyle,
                  ),
                  Text(
                    '${bookingDetails?.vehicle.vehicleNumber} | ${bookingDetails?.vehicle.seats} Seats',
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
            //         child: (bookingDetails?.vehicle.images ?? []).isEmpty
            //             ? Image.asset(
            //                 car3,
            //                 fit: BoxFit.cover,
            //               )
            //             : Image.network(
            //                 (bookingDetails?.vehicle.images ?? []).isEmpty
            //                     ? 'https://static.vecteezy.com/system/resources/thumbnails/022/059/000/small/no-image-available-icon-vector.jpg'
            //                     : bookingDetails?.vehicle.images[0],
            //                 fit: BoxFit.fill,
            //               ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Expanded(
            //           child: Text(
            //             'gjhkjkjlkjklllllklklllkjkjjkjkjkhkjkljklkljkljll',
            //             style: pageHeadingTextStyle,
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             Text(
            //                 '${bookingDetails?.kilometers} KM / ${bookingDetails?.totalRentTime}Hr'),
            //             const SizedBox(height: 15, child: VerticalDivider()),
            //             Text(bookingDetails?.vehicle.fuelType ?? '')
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Text(
            //               '${bookingDetails?.vehicle.vehicleNumber}',
            //               style: textStyle,
            //             ),
            //             const SizedBox(
            //                 height: 15,
            //                 child: VerticalDivider(
            //                   color: Colors.black,
            //                   thickness: 1.5,
            //                 )),
            //             Text(
            //               '${bookingDetails?.vehicle.seats} Seats',
            //               style: textStyle,
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //     // Expanded(
            //     //   child: Column(
            //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //     crossAxisAlignment: CrossAxisAlignment.end,
            //     //     children: [
            //     //       // Text(
            //     //       //   "⭐ 4.8",
            //     //       //   style: GoogleFonts.lato(
            //     //       //       color: Colors.black,
            //     //       //       fontSize: 14,
            //     //       //       fontWeight: FontWeight.w700),
            //     //       // ),
            //     //       Text(
            //     //         'AED ${bookingDetails?.rentalCharge ?? ''}',
            //     //         style: const TextStyle(
            //     //             fontSize: 13, fontWeight: FontWeight.w600),
            //     //       )
            //     //     ],
            //     //   ),
            //     // )
            //   ],
            // ),
          ),
          containerItem(
              context,
              null,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 10),
                    child: Text(
                      'Booking ID : ${bookingDetails?.id}',
                      style: textTextStyle1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          'Status : ',
                          style: textTextStyle1,
                        ),
                        Text(
                          ' ${bookingDetails?.bookingStatus == 'ON_RUNNING' ? 'ONGOING' : bookingDetails?.bookingStatus}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                                  bookingDetails?.bookingStatus == 'CANCELLED'
                                      ? redColor
                                      : bookingDetails?.bookingStatus ==
                                              'ON_RUNNING'
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
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Text(
                            bookingDetails?.pickupLocation ?? 'N/A',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: textTextStyle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.calendar_month_outlined, size: 20),
                        Text(
                          '${bookingDetails?.date}',
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
                          '${bookingDetails?.pickupTime}',
                          style: textTextStyle1,
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Text(
              'Traveller Details',
              style: titleTextStyle,
            ),
          ),
          containerItem(
              context,
              null,
              Column(
                children: [
                  InfoRow(
                      label: 'Traveller Name',
                      value:
                          '${bookingDetails?.user.firstName} ${bookingDetails?.user.lastName}'),
                  const SizedBox(
                    height: 5,
                  ),
                  InfoRow(
                      label: 'Contact No',
                      value:
                          '+${bookingDetails?.user.countryCode} ${bookingDetails?.user.mobile}'),
                  const SizedBox(
                    height: 5,
                  ),
                  InfoRow(
                      label: 'Email', value: '${bookingDetails?.user.email}'),
                ],
              )),
          const Spacer(),
          (bookingDetailsStatus == "COMPLETED" ||
                  bookingDetailsStatus == "CANCELLED")
              ? const SizedBox.shrink()
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (getIssueByBookingId?.data ?? []).isEmpty
                            ? CustomButtonSmall(
                                width: 120,
                                height: 45,
                                btnHeading: 'Raise Issue',
                                onTap: () {
                                  context.push('/rideIssue', extra: {
                                    'bookingId': bookingDetails?.id ?? '',
                                    'bookingType': 'RENTAL_BOOKING'
                                  });
                                })
                            : CustomButtonSmall(
                                height: 45,
                                width: 120,
                                btnHeading: 'View Issue',
                                onTap: () {
                                  context.push("/getRaiseIssue");
                                }),
                        bookingDetailsStatus == "BOOKED" ||
                                bookingDetailsStatus == "ON_RUNNING"
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: CustomButtonSmall(
                                    height: 45,
                                    // loading:
                                    width: 120,
                                    btnHeading: bookingDetailsStatus == "BOOKED"
                                        ? "Start"
                                        : "Complete",
                                    isEnabled: formattedTodayDate ==
                                            bookingDetails?.date
                                        ? btnEnable = true
                                        : false,
                                    onTap: btnEnable != true
                                        ? null
                                        : () {
                                            if (bookingDetailsStatus ==
                                                "BOOKED") {
                                              showConfirmation(
                                                  context: context,
                                                  loading: Provider.of<
                                                              DriverOnRunningViewModel>(
                                                          context,
                                                          listen: false)
                                                      .loading,
                                                  title: 'Start',
                                                  onTap: () {
                                                    Provider.of<DriverOnRunningViewModel>(
                                                            context,
                                                            listen: false)
                                                        .fetchDriverStartRideViewModel(
                                                            {
                                                          "id": bookingDetails
                                                              ?.id
                                                              .toString(),
                                                          "bookingStatus":
                                                              "ON_RUNNING"
                                                        },
                                                            context,
                                                            bookingDetails?.id
                                                                    .toString() ??
                                                                '',
                                                            widget
                                                                .driverId).then(
                                                            (onValue) {
                                                      Provider.of<DriverGetBookingDetailsViewModel>(
                                                              context,
                                                              listen: false)
                                                          .updateBookingStatus(
                                                              "ON_RUNNING");
                                                    });
                                                  });
                                            } else {
                                              showConfirmation(
                                                  context: context,
                                                  loading: Provider.of<
                                                              DriverCompletedBookingViewModel>(
                                                          context,
                                                          listen: false)
                                                      .loading,
                                                  title: 'Complete',
                                                  onTap: () {
                                                    Provider.of<DriverCompletedBookingViewModel>(
                                                            context,
                                                            listen: false)
                                                        .fetchDriverBookingCompletedViewModel(
                                                            {
                                                          'id': bookingDetails
                                                              ?.id
                                                              .toString(),
                                                          'bookingStatus':
                                                              'COMPLETED'
                                                        },
                                                            context,
                                                            widget.driverId);
                                                  });
                                            }
                                          }),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                )
        ],
      ),
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
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              actionsPadding: const EdgeInsets.symmetric(vertical: 0),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Text(
                  'Are you sure you want to $title this booking?',
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class BookingContainer extends StatelessWidget {
  final String carName;
  final String carType;
  final String brand;
  final String fuelType;
  final String vehicleId;
  final String vehicleNo;
  final String carColor;
  final String seats;
  final String model;
  final String pickDate;
  final String pickTime;
  final String hour;
  final String id;
  final String kilometer;
  final String status;
  final String rentalCharge;
  final String bookingId;
  final String acceptBtnHeading;
  final String pessName;
  final String pickUPLocation;
  final String pessLastName;
  final String cancelledReason;
  final String pessEmail;
  final String cancelledBy;
  final String pessContact;
  final VoidCallback confirmTap;
  final VoidCallback cancelTap;
  final bool loader;

  const BookingContainer({
    super.key,
    required this.carName,
    required this.carType,
    required this.brand,
    required this.pickDate,
    required this.pickUPLocation,
    required this.pickTime,
    required this.hour,
    required this.acceptBtnHeading,
    required this.cancelledBy,
    required this.id,
    required this.kilometer,
    required this.status,
    required this.rentalCharge,
    required this.bookingId,
    required this.confirmTap,
    required this.cancelTap,
    required this.pessName,
    required this.pessLastName,
    required this.pessContact,
    required this.pessEmail,
    required this.fuelType,
    required this.vehicleId,
    required this.vehicleNo,
    required this.carColor,
    required this.seats,
    required this.model,
    required this.cancelledReason,
    this.loader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppDimension.getHeight(context) * .5,
      // width: AppDimension.getWidth(context) * .9,
      // padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              color: btnColor,
              // border: Border(bottom: BorderSide(color: greyColor)),
            ),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Booking Details",
                  style: GoogleFonts.lato(
                      color: background,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Vehicle Details",
                style: titleTextStyle,
              )),
          Container(
            // height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: naturalGreyColor.withOpacity(0.3)))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Car : ",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                carName,
                                maxLines: 3,
                                style: titleTextStyle,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Car Type : ",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                carType,
                                maxLines: 3,
                                style: titleTextStyle,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Brand : ",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              width: 110,
                              child: Text(
                                brand,
                                maxLines: 3,
                                style: titleTextStyle,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Fuel : ",
                                style: titleTextStyle,
                              ),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  fuelType,
                                  maxLines: 3,
                                  style: titleTextStyle,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Vehicle Id : ",
                                style: titleTextStyle,
                              ),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  vehicleId,
                                  maxLines: 3,
                                  style: titleTextStyle,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Color : ",
                                style: titleTextStyle,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  carColor,
                                  maxLines: 3,
                                  style: titleTextStyle,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Vehicle No : ",
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        vehicleNo,
                        maxLines: 3,
                        style: titleTextStyle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Model : ",
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        model,
                        maxLines: 3,
                        style: titleTextStyle,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Booking Details",
                style: titleTextStyle,
              )),

          ///3rd Container
          Container(
            // height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: naturalGreyColor.withOpacity(0.3)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Id : ",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                id,
                                maxLines: 3,
                                style: titleTextStyle,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Hour : ",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                hour,
                                maxLines: 3,
                                style: titleTextStyle,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Seats : ",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                seats,
                                maxLines: 3,
                                style: titleTextStyle,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Status : ",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                status,
                                maxLines: 3,
                                style: titleTextStyle,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Date : ",
                                style: titleTextStyle,
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  pickDate,
                                  maxLines: 3,
                                  style: titleTextStyle,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Time : ",
                                style: titleTextStyle,
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  pickTime,
                                  maxLines: 3,
                                  style: titleTextStyle,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Kilometer : ",
                                style: titleTextStyle,
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  kilometer,
                                  maxLines: 3,
                                  style: titleTextStyle,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Rental Charge : ",
                                style: titleTextStyle,
                              ),
                              SizedBox(
                                // width: 90,
                                child: Text(
                                  rentalCharge,
                                  maxLines: 3,
                                  style: titleTextStyle,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                cancelledBy.isNotEmpty
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Cancelled By : ",
                            style: titleTextStyle,
                          ),
                          SizedBox(
                            width: AppDimension.getWidth(context) * .58,
                            child: Text(
                              cancelledBy,
                              maxLines: 3,
                              style: titleTextStyle,
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 5),
                cancelledReason.isNotEmpty
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Cancel Reason : ",
                            style: titleTextStyle,
                          ),
                          SizedBox(
                            width: AppDimension.getWidth(context) * .58,
                            child: Text(
                              cancelledReason,
                              maxLines: 3,
                              style: titleTextStyle,
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "PickUp Location : ",
                      style: titleTextStyle,
                    ),
                    Expanded(
                      child: Text(
                        pickUPLocation,
                        maxLines: 3,
                        style: titleTextStyle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Booking ID : ",
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .58,
                      child: Text(
                        bookingId,
                        maxLines: 3,
                        style: titleTextStyle,
                      ),
                    )
                  ],
                ),

                // RichText(
                //     overflow: TextOverflow.ellipsis,
                //     text: TextSpan(children: [
                //       TextSpan(
                //         text: "Booking ID : ",
                //         style: titleTextStyle,
                //       ),
                //       TextSpan(
                //         text: bookingId,
                //         style: GoogleFonts.lato(
                //             color: greyColor,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w400
                //         ),
                //       ),
                //     ])),
              ],
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Passenger Details",
                style: titleTextStyle,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Passenger Name : ",
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "$pessName $pessLastName",
                        maxLines: 3,
                        style: titleTextStyle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Contact No : ",
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        pessContact,
                        maxLines: 3,
                        style: titleTextStyle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Email : ",
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        pessEmail,
                        maxLines: 3,
                        style: titleTextStyle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          status == "BOOKED" || status == "ON_RUNNING"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButtonSmall(
                          loading: loader,
                          width: AppDimension.getWidth(context) * .42,
                          btnHeading: acceptBtnHeading,
                          onTap: confirmTap),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}

class CancelContainerDialog extends StatelessWidget {
  final TextEditingController controllerCancel;
  final VoidCallback onTap;

  const CancelContainerDialog(
      {required this.controllerCancel, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          decoration: const BoxDecoration(
              color: background,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: AppDimension.getHeight(context) * .4,
          width: AppDimension.getWidth(context) * .7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 30,
                        width: 30,
                      ),
                      const CustomTextWidget(
                        content: "Cancel Booking",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textColor: background,
                      ),
                      Material(
                        color: btnColor,
                        child: InkWell(
                          onTap: () => context.pop(),
                          child: Container(
                              padding: const EdgeInsets.all(2),
                              height: 30,
                              width: 30,
                              child: const Icon(
                                Icons.close,
                                color: background,
                              )),
                        ),
                      ),
                    ],
                  )
                  // const Center(
                  //   child:
                  // ),
                  ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      content: "Reason for cancel booking",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textColor: greyColor,
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: AppDimension.getHeight(context) * .15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: curvePageColor)),
                      child: TextFormField(
                        maxLines: 5,
                        controller: controllerCancel,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButtonBig(btnHeading: "Submit", onTap: onTap)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
