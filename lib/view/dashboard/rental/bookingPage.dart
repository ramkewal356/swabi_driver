// import 'package:flutter/material.dart';
// import 'package:flutter_driver/model/driverBookingModel.dart';
// import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
// import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
// import 'package:flutter_driver/res/customAppBar.dart';
// import 'package:flutter_driver/utils/assets.dart';
// import 'package:flutter_driver/utils/color.dart';
// import 'package:flutter_driver/utils/dimensions.dart';
// import 'package:flutter_driver/utils/text_styles.dart';
// import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class BookingDetailsPage extends StatefulWidget {
//   final String userId;
//   const BookingDetailsPage({super.key, required this.userId});

//   @override
//   State<BookingDetailsPage> createState() => _BookingDetailsPageState();
// }

// class _BookingDetailsPageState extends State<BookingDetailsPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       Provider.of<DriverGetBookingListViewModel>(context, listen: false)
//           .fetchDriverGetBookingListViewModel({
//         "driverId": widget.userId,
//         "pageNumber": "0",
//         "pageSize": "10",
//         "bookingStatus": "BOOKED"
//       }, context);
//     });
//   }

//   ///Loader Condition single index of multiple container
//   int selectedIndex = -1;
//   bool loaderOntap = false;
//   List<Content> contentData = [];
//   @override
//   Widget build(BuildContext context) {
//     String status = context
//         .watch<DriverGetBookingDetailsViewModel>()
//         .DataList
//         .status
//         .toString();
//     String contentStatus = context
//         .watch<DriverGetBookingListViewModel>()
//         .DataList
//         .status
//         .toString();
//     if (contentStatus == "Status.completed") {
//       contentData = context
//               .watch<DriverGetBookingListViewModel>()
//               .DataList
//               .data
//               ?.data
//               .content ??
//           [];
//     }
//     print("${widget.userId}UserIDD");
//     print(contentData.length);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: const CustomAppBar(
//         heading: 'Booking Details',
//       ),
//       body: CommonPageLayout(
//         padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
//         onRefresh: () async {
//           await Provider.of<DriverGetBookingListViewModel>(context,
//                   listen: false)
//               .fetchDriverGetBookingListViewModel({
//             "driverId": widget.userId,
//             "pageNumber": "0",
//             "pageSize": "10",
//             "bookingStatus": "BOOKED"
//           }, context);
//         },
//         child: Container(
//           // color: background,
//           // height: AppDimension.getHeight(context)*.7,
//           child: contentStatus == "Status.completed"
//               ? contentData.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: contentData.length,
//                       itemBuilder: (context, index) {
//                         String vehicleData =
//                             contentData[index].vehicle.toString();
//                         debugPrint("${vehicleData}Vehicle Data");
//                         if (contentData[index].bookingStatus == "BOOKED") {
//                           return TransContainer(
//                             // carName: contentData[index].vehicle.carName?.toString() ?? "",
//                             carName: contentData[index]
//                                     .vehicle!
//                                     .carName
//                                     ?.toString() ??
//                                 "",
//                             carType:
//                                 contentData[index].carType.toString() ?? "",
//                             hour: contentData[index].totalRentTime.toString() ??
//                                 "",
//                             kilometers:
//                                 contentData[index].kilometers.toString() ?? "",
//                             pickDate: contentData[index].date.toString() ?? "",
//                             fuelType: contentData[index]
//                                     .vehicle!
//                                     .fuelType
//                                     .toString() ??
//                                 "",
//                             seat:
//                                 contentData[index].vehicle!.seats?.toString() ??
//                                     "",
//                             brand: contentData[index]
//                                     .vehicle!
//                                     .brandName
//                                     ?.toString() ??
//                                 "",
//                             carColor:
//                                 contentData[index].vehicle!.color?.toString() ??
//                                     "",
//                             paid: contentData[index].paidStatus == "false"
//                                 ? "No"
//                                 : "Yes",
//                             pickTime:
//                                 contentData[index].pickupTime.toString() ?? "",
//                             pickUpLocation:
//                                 contentData[index].pickupLocation.toString() ??
//                                     "",
//                             bookingStatus:
//                                 contentData[index].bookingStatus.toString() ??
//                                     "",
//                             totalPrice:
//                                 contentData[index].rentalCharge.toString() ??
//                                     "",
//                             bookingID:
//                                 contentData[index].rentalBookingId.toString() ??
//                                     "",
//                             loader: status == 'Status.loading' &&
//                                 loaderOntap &&
//                                 selectedIndex == index,
//                             onTap: () {
//                               setState(() {
//                                 selectedIndex = index;
//                                 loaderOntap = true;
//                               });
//                               Provider.of<DriverGetBookingDetailsViewModel>(
//                                       context,
//                                       listen: false)
//                                   .fetchDriverGetBookingDetailsViewModel({
//                                 "id": contentData[index].id.toString(),
//                               }, context, contentData[index].id.toString(),
//                                       (widget.userId ?? ""));
//                             },
//                           );
//                         } else {
//                           return Container();
//                         }
//                       },
//                     )
//                   : Center(
//                       child: Text(
//                       "No Booking",
//                       style: GoogleFonts.lato(
//                           fontSize: 15,
//                           color: redColor,
//                           fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.center,
//                     ))
//               : const Center(
//                   child: CircularProgressIndicator(
//                   color: Colors.green,
//                 )),
//         ),
//       ),
//     );
//   }
// }

// class TransContainer extends StatelessWidget {
//   final String carName;
//   final String carType;
//   final String pickTime;
//   final String pickDate;
//   final String bookingStatus;
//   final String hour;
//   final String seat;
//   final String bookingID;
//   final String carColor;
//   final String fuelType;
//   final String brand;
//   final String totalPrice;
//   final String paid;
//   final String kilometers;
//   final bool loader;
//   final String pickUpLocation;
//   final VoidCallback onTap;
//   const TransContainer(
//       {this.carName = "",
//       this.carType = "",
//       this.pickTime = "",
//       this.seat = "",
//       this.pickDate = "",
//       this.fuelType = "",
//       this.hour = "",
//       this.brand = "",
//       this.paid = "",
//       this.bookingID = "",
//       this.carColor = "",
//       this.bookingStatus = "",
//       this.totalPrice = "",
//       this.kilometers = "",
//       this.pickUpLocation = "",
//       required this.onTap,
//       this.loader = false,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Material(
//         elevation: 0,
//         color: background,
//         borderRadius: BorderRadius.circular(9),
//         child: InkWell(
//           // onTap: onTap,
//           borderRadius: BorderRadius.circular(9),
//           child: Container(
//             // height: AppDimension.getHeight(context)*.25,
//             // width: AppDimension.getWidth(context)*.9,
//             decoration: BoxDecoration(
//                 color: background,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
//             child: Column(
//               children: [
//                 ///First Line of Design
//                 Container(
//                     decoration: const BoxDecoration(
//                         border:
//                             Border(bottom: BorderSide(color: curvePageColor))),
//                     child: ListTile(
//                       // leading: SizedBox(
//                       //   width: 60,
//                       //   height: 60,
//                       //   child: ClipRRect(
//                       //       borderRadius: BorderRadius.circular(10),
//                       //       child: Image.asset(car,fit: BoxFit.cover,)),
//                       // ),
//                       title: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: AppDimension.getWidth(context) * .4,
//                                   child: Text(
//                                     "Car : $carName",
//                                     style: GoogleFonts.lato(
//                                         color: greyColor,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                     maxLines: 2,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 125,
//                                   child: Text(
//                                     "Date : $pickDate",
//                                     style: GoogleFonts.lato(
//                                         color: greyColor,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Seats : $seat",
//                                   style: GoogleFonts.lato(
//                                       color: greyColor,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 SizedBox(
//                                   width: 125,
//                                   child: Text(
//                                     "Timing : $pickTime",
//                                     style: GoogleFonts.lato(
//                                         color: greyColor,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Car Color : $carColor",
//                                   style: GoogleFonts.lato(
//                                       color: greyColor,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 SizedBox(
//                                   width: 125,
//                                   child: Text(
//                                     "Rent Hour : $hour Hr",
//                                     style: GoogleFonts.lato(
//                                         color: greyColor,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "CarType : $carType",
//                                   style: GoogleFonts.lato(
//                                       color: greyColor,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 SizedBox(
//                                   width: 125,
//                                   child: Text(
//                                     "Paid : $paid",
//                                     style: GoogleFonts.lato(
//                                         color: greyColor,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Brand : $brand",
//                                   style: GoogleFonts.lato(
//                                       color: greyColor,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 // SizedBox(
//                                 //   width: 125,
//                                 //   child: Text("Paid : $paid",style: GoogleFonts.lato(
//                                 //       color: greyColor,
//                                 //       fontSize: 14,
//                                 //       fontWeight: FontWeight.w600
//                                 //   ),),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),

//                 ///Second Line Design
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: const BoxDecoration(
//                       border:
//                           Border(bottom: BorderSide(color: curvePageColor))),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                     // leading: Container(
//                     //   width: 40,
//                     //   height: 40,
//                     //   child: ClipRRect(
//                     //       borderRadius: BorderRadius.circular(50),
//                     //       child: Image.asset(image,fit: BoxFit.cover,)),
//                     // ),
//                     title: Row(
//                       children: [
//                         SizedBox(
//                           width: 40,
//                           height: 40,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(fuel),
//                               )),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Fuel Type",
//                               style: GoogleFonts.lato(
//                                   color: greyColor,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               fuelType,
//                               style: GoogleFonts.lato(
//                                   color: greyColor,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     trailing: SizedBox(
//                       width: 170,
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                               width: 40,
//                               height: 40,
//                               child: Icon(Icons.calendar_month_rounded)
//                               // ClipRRect(
//                               //     borderRadius: BorderRadius.circular(50),
//                               //     child: Padding(
//                               //       padding: const EdgeInsets.all(12.0),
//                               //       child: Image.asset(dollar),
//                               //     )),
//                               ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Booking Status",
//                                 style: GoogleFonts.lato(
//                                     color: greyColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 bookingStatus,
//                                 style: GoogleFonts.lato(
//                                     color: greyColor,
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
//                 //   child: SizedBox(width: AppDimension.getWidth(context)*.9,
//                 //     child: RichText(
//                 //         overflow: TextOverflow.ellipsis,
//                 //         text: TextSpan(
//                 //             children: [
//                 //               TextSpan(
//                 //                 text: "Booking Id : ",style: titleTextStyle,
//                 //               ),
//                 //               TextSpan(
//                 //                 text: bookingID,style: loginTextStyle,
//                 //               ),
//                 //             ]
//                 //         )),
//                 //   ),
//                 // ),
//                 ///Second Line Design
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Kilometers : ",
//                                 style: titleTextStyle,
//                               ),
//                               // const SizedBox(height: 5),
//                               Text(
//                                 kilometers,
//                                 style: GoogleFonts.lato(
//                                     color: greyColor,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ],
//                           ),
//                           // RichText(
//                           //     text: TextSpan(
//                           //     children: [
//                           //       TextSpan(
//                           //         text: "",style: titleTextStyle,
//                           //       ),
//                           //       TextSpan(
//                           //         text: ,style: loginTextStyle,
//                           //       ),
//                           //     ]
//                           // )),
//                           const SizedBox(height: 10),
//                           // RichText(text: TextSpan(
//                           //     children: [
//                           //       TextSpan(
//                           //         text: "PickUp Location : ",style: titleTextStyle,
//                           //       ),
//                           //       TextSpan(
//                           //         text: "100",style: loginTextStyle,
//                           //       ),
//                           //     ]
//                           // )),
//                           // Text("Kilometers",style: titleTextStyle,),
//                           Text(
//                             "PickUp Location :",
//                             style: titleTextStyle,
//                           ),
//                           const SizedBox(height: 5),
//                           SizedBox(
//                             width: AppDimension.getWidth(context) * .3,
//                             child: Text(
//                               pickUpLocation.toUpperCase(),
//                               style: GoogleFonts.lato(
//                                   color: greyColor,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w700),
//                               maxLines: 2,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text("AED $totalPrice", style: appbarTextStyle),
//                           Text("Inclusive of GST", style: titleTextStyle),
//                           const SizedBox(height: 5),
//                           CustomButtonSmall(
//                             loading: loader,
//                             width: 120,
//                             btnHeading: "View Details",
//                             onTap: onTap,
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
