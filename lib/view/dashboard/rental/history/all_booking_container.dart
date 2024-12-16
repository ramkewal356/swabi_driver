import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryDetailsContainer extends StatelessWidget {
  final String carName;
  final String date;
  final String bookingId;

  // final String rentalCharge;
  final String status;
  final List carImage;
  final String fuelType;
  final String seat;
  final VoidCallback? onTapContainer;
  final bool loader;
  const HistoryDetailsContainer(
      {super.key,
      this.onTapContainer,
      required this.carName,
      required this.date,
      required this.bookingId,
      // required this.rentalCharge,
      this.carImage = const [],
      required this.status,
      required this.fuelType,
      required this.loader,
      required this.seat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: background,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          // onTap: onTapContainer,
          child: Container(
            // height: AppDimension.getHeight(context)*.23,
            width: AppDimension.getWidth(context) * .9,
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: curvePageColor)),
            child: Column(
              children: [
                ///First Line of Design
                Container(
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: curvePageColor))),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: carImage.isEmpty
                                ? Image.asset(car3, fit: BoxFit.cover)
                                : Image.network(
                                    carImage[0],
                                    fit: BoxFit.fill,
                                  )),
                      ),
                      title: Text(
                        carName,
                        style: GoogleFonts.lato(
                            color: greyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    size: 18),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  date,
                                  style: GoogleFonts.lato(
                                      color: greyColor1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  'Seats : $seat',
                                  style: GoogleFonts.lato(
                                      color: greyColor1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Booking Id : $bookingId',
                                  style: textTextStyle1,
                                ),
                                const Spacer(),
                                Text(
                                  'Fuel Type : $fuelType',
                                  style: textTextStyle1,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // trailing: Column(
                      //   children: [
                      //     Text(
                      //       "Charges",
                      //       style: GoogleFonts.lato(
                      //           color: greyColor1,
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w700),
                      //     ),
                      //     const SizedBox(height: 5),
                      //     Text("AED $rentalCharge", style: titleTextStyle),
                      //   ],
                      // ),
                    )),

                // ///Second Line Design
                // Container(
                //   decoration: const BoxDecoration(
                //       border:
                //           Border(bottom: BorderSide(color: curvePageColor))),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: ListTile(
                //           dense: true,
                //           contentPadding:
                //               const EdgeInsets.symmetric(horizontal: 10),
                //           horizontalTitleGap: 5,
                //           leading: SizedBox(
                //             width: 40,
                //             height: 40,
                //             child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(50),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Image.asset(fuel),
                //                 )),
                //           ),
                //           title: Text(
                //             "Fuel Type",
                //             style: GoogleFonts.lato(
                //                 color: greyColor1,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w700),
                //           ),
                //           subtitle: Text(
                //             fuelType,
                //             style: GoogleFonts.lato(
                //                 color: greyColor,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w700),
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: ListTile(
                //           dense: true,
                //           contentPadding: const EdgeInsets.only(left: 50),
                //           horizontalTitleGap: 5,
                //           leading: SizedBox(
                //             width: 40,
                //             height: 40,
                //             child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(50),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Image.asset(seatIcon),
                //                 )),
                //           ),
                //           title: Text(
                //             "Seats",
                //             style: GoogleFonts.lato(
                //                 color: greyColor1,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w700),
                //           ),
                //           subtitle: Text(
                //             seat,
                //             style: GoogleFonts.lato(
                //                 color: greyColor,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w700),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                ///Second Line Design
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: status == "CANCELLED"
                                  ? redColor.withOpacity(.1)
                                  : status == "ONGOING"
                                      ? Colors.orange.withOpacity(0.1)
                                      : greenColor.withOpacity(.1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                status,
                                style: GoogleFonts.lato(
                                    color: status == "CANCELLED"
                                        ? redColor
                                        : status == "ONGOING"
                                            ? Colors.orange
                                            : greenColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      CustomButtonSmall(
                          loading: loader,
                          height: 40,
                          width: 120,
                          btnHeading: 'View Details',
                          onTap: onTapContainer)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
