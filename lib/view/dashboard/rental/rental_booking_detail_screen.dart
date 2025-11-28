// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:flutter_driver/core/constants/assets.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:flutter_driver/view_model/raise_issue_view_model.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RentalBookingDetailScreen extends StatefulWidget {
  final String bookingId;

  const RentalBookingDetailScreen({super.key, required this.bookingId});

  @override
  State<RentalBookingDetailScreen> createState() =>
      _RentalBookingDetailScreenState();
}

class _RentalBookingDetailScreenState extends State<RentalBookingDetailScreen> {
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getRentalDetails();
        // getIssueBybookingId();
      },
    );

    getTimezone();
    final date = DateTime.now();
    setState(() {
      dateFormat = DateFormat('dd-MM-yyyy').format(date);
    });
    formattedTodayDate = dateFormat.toString();
  }

  void getRentalDetails() {
    context
        .read<DriverRentalBookingViewModel>()
        .getBookingDetailsApi(bookingId: widget.bookingId);
    getIssueBybookingId();
  }

  void getIssueBybookingId() async {
    context.read<RaiseIssueViewModel>().getIssueByBookingId(
        bookingId: widget.bookingId, bookingType: 'RENTAL_BOOKING');
  }

  Future<void> getTimezone() async {
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      final timezoneString = timezoneInfo.identifier;

      if (!mounted) return;

      setState(() {
        _timeZone = timezoneString;
        debugPrint('time zone $_timeZone');
      });
    } catch (e) {
      debugPrint('Could not get the local timezone');
    }
  }

  @override
  Widget build(BuildContext context) {
    var getIssueByBookingId =
        context.watch<RaiseIssueViewModel>().getIssueData.data;
    var bookingDetails = context
        .watch<DriverRentalBookingViewModel>()
        .bookingDetailsData
        .data
        ?.data;
    var actionStatus = context
        .watch<DriverRentalBookingViewModel>()
        .startAndCompleteResponse
        .status;
    var status =
        context.watch<DriverRentalBookingViewModel>().bookingDetailsData.status;
    return CustomPageLayout(
      appBarTitle: 'Booking Details',
      child: status == Status.loading
          ? Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10)),
                  // padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    minVerticalPadding: 8.0,
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: 4),
                    dense: true,
                    leading: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10)),
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: (bookingDetails?.vehicle?.images ?? []).isEmpty
                            ? Image.asset(
                                car3,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                bookingDetails?.vehicle?.images?[0] ?? '',
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    title: Text(
                      bookingDetails?.vehicle?.carName ?? '',
                      style: pageHeadingTextStyle,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${bookingDetails?.kilometers} KM / ${bookingDetails?.totalRentTime} Hr | ${bookingDetails?.vehicle?.fuelType}',
                          style: textTextStyle,
                        ),
                        Text(
                          '${bookingDetails?.vehicle?.vehicleNumber} | ${bookingDetails?.vehicle?.seats} Seats',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
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
                                    color: bookingDetails?.bookingStatus ==
                                            'CANCELLED'
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
                              const Icon(Icons.calendar_month_outlined,
                                  size: 20),
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
                                '${bookingDetails?.user?.firstName} ${bookingDetails?.user?.lastName}'),
                        const SizedBox(
                          height: 5,
                        ),
                        InfoRow(
                            label: 'Contact No',
                            value:
                                '+${bookingDetails?.user?.countryCode} ${bookingDetails?.user?.mobile}'),
                        const SizedBox(
                          height: 5,
                        ),
                        InfoRow(
                            label: 'Email',
                            value: '${bookingDetails?.user?.email}'),
                      ],
                    )),
                const Spacer(),
                (bookingDetails?.bookingStatus == "COMPLETED" ||
                        bookingDetails?.bookingStatus == "CANCELLED")
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             
                              CustomButtonSmall(
                                      width: 120,
                                      height: 45,
                                  btnHeading:
                                      getIssueByBookingId?.data?.isEmpty ?? true
                                          ? 'Raise Issue'
                                          : 'View Issue',
                                      onTap: () {
                                    if ((getIssueByBookingId?.data ?? [])
                                        .isEmpty) {
                                        context.push('/rideIssue', extra: {
                                          'bookingId':
                                              bookingDetails?.id.toString() ??
                                                  '',
                                          'bookingType': 'RENTAL_BOOKING',
                                          'vendorId': bookingDetails?.vendorId
                                                  .toString() ??
                                              ''
                                        }).then((onValue) {
                                          getRentalDetails();
                                      });
                                    } else {
                                      context.push("/getRaiseIssue");
                                    }
                                      }),
                                 
                              bookingDetails?.bookingStatus == "BOOKED" ||
                                      bookingDetails?.bookingStatus ==
                                          "ON_RUNNING"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: CustomButtonSmall(
                                          height: 45,
                                          loading:
                                              actionStatus == Status.loading,
                                          width: 120,
                                          btnHeading:
                                              bookingDetails?.bookingStatus ==
                                                      "BOOKED"
                                                  ? "Start"
                                                  : "Complete",
                                          isEnabled: formattedTodayDate ==
                                                  bookingDetails?.date
                                              ? btnEnable = true
                                              : false,
                                          onTap: btnEnable != true
                                              ? null
                                              : () {
                                                  if (bookingDetails
                                                          ?.bookingStatus ==
                                                      "BOOKED") {
                                                    showConfirmation(
                                                        context: context,
                                                        loading: false,
                                                        title: 'Start',
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  DriverRentalBookingViewModel>()
                                                              .startAndCompleteBookingApi(
                                                                  bookingId:
                                                                      bookingDetails
                                                                              ?.id
                                                                              .toString() ??
                                                                          '',
                                                                  bookingStatus:
                                                                      'ON_RUNNING')
                                                              .then((onValue) {
                                                            if (onValue?.status
                                                                    ?.httpCode ==
                                                                '200') {
                                                              context.pop();
                                                              getRentalDetails();
                                                            }
                                                          });
                                                        });
                                                  } else {
                                                    showConfirmation(
                                                        context: context,
                                                        loading: false,
                                                        title: 'Complete',
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  DriverRentalBookingViewModel>()
                                                              .startAndCompleteBookingApi(
                                                                  bookingId:
                                                                      bookingDetails
                                                                              ?.id
                                                                              .toString() ??
                                                                          '',
                                                                  bookingStatus:
                                                                      'COMPLETED')
                                                              .then((onValue) {
                                                            if (onValue?.status
                                                                    ?.httpCode ==
                                                                '200') {
                                                              context.pop();
                                                              getRentalDetails();
                                                            }
                                                          });
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

  const InfoRow({super.key, required this.label, required this.value});

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
