import 'package:flutter/material.dart';
import 'package:flutter_driver/widgets/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';

// class Custompackageviewpage extends StatefulWidget {
//   final String driverAssignId;
//   final String date;
//   final String pickUpLocation;
//   final String activityName;
//   final String daySatus;
//   final String pickupTime;
//   final bool loader;
//   final void Function()? onTap;
//   const Custompackageviewpage(
//       {super.key,
//       required this.driverAssignId,
//       required this.date,
//       required this.pickUpLocation,
//       required this.activityName,
//       required this.daySatus,
//       required this.loader,
//       required this.pickupTime,
//       required this.onTap});

//   @override
//   State<Custompackageviewpage> createState() => _CustompackageviewpageState();
// }

// class _CustompackageviewpageState extends State<Custompackageviewpage> {
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black12),
//           // color: bgGreyColor,
//           borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Driver Assign ID:${widget.driverAssignId}',
//                 style: textStyle,
//               ),
//               Text(
//                 'Date: ${widget.date}',
//                 style: textStyle,
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Activity Name:',
//                 style: titleTextStyle,
//               ),
//               Text(
//                 'PickupTime: ${widget.pickupTime}',
//                 style: titleTextStyle,
//               )
//             ],
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Icon(
//                 Icons.check,
//                 color: Colors.green,
//               ),
//               Expanded(
//                 child: Text(
//                   widget.activityName,
//                   style: const TextStyle(color: Colors.green),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'PickUp Location: ',
//                 style: textStyle,
//               ),
//               Expanded(
//                 child: Text(
//                   widget.pickUpLocation,
//                   style: textStyle,
//                 ),
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           // Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 35,
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                     color: widget.daySatus == 'COMPLETED'
//                         ? greenColor
//                         : widget.daySatus == 'ONGOING'
//                             ? Colors.orange
//                             : widget.daySatus == 'PENDING'
//                                 ? redColor
//                                 : null,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Center(
//                   child: Text(
//                     widget.daySatus,
//                     style: const TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               CustomButtonSmall(
//                 width: 120,
//                 height: 40,
//                 loading: widget.loader,
//                 btnHeading: "View Details",
//                 onTap: widget.onTap,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class CustomPackageViewPage extends StatelessWidget {
  final String driverAssignId;
  final String date;
  final String pickUpLocation;
  final String activityName;
  final String dayStatus;
  final String pickupTime;
  final bool loader;
  final VoidCallback? onTap;

  const CustomPackageViewPage({
    super.key,
    required this.driverAssignId,
    required this.date,
    required this.pickUpLocation,
    required this.activityName,
    required this.dayStatus,
    required this.loader,
    required this.pickupTime,
    required this.onTap,
  });

  Color _statusColor() {
    switch (dayStatus) {
      case 'COMPLETED':
        return Colors.green;
      case 'ONGOING':
        return Colors.orange;
      case 'PENDING':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---- Header ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ID: $driverAssignId",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: textStyle.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ---- Activity Name ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Activity",
                  style: titleTextStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 18, color: Colors.indigo),
                    const SizedBox(width: 6),
                    Text(
                      pickupTime,
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    activityName,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ---- Location ----
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: Colors.redAccent),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    pickUpLocation,
                    style: textStyle.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ---- Status + Button ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: _statusColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dayStatus,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /// Custom Button
                CustomButtonSmall(
                  width: 130,
                  height: 42,
                  loading: loader,
                  btnHeading: "View Details",
                  onTap: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
