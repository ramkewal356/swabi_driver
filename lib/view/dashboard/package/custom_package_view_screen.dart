// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';


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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.88),
            Colors.white.withOpacity(0.45),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.black.withOpacity(0.05),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  /// ---------- HEADER ----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#$driverAssignId",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month,
                              size: 18, color: Colors.black54),
                          const SizedBox(width: 5),
                          Text(
                            date,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// ---------- ACTIVITY ----------
                  Row(
                    children: [
                      const Icon(Icons.bolt_rounded,
                          color: greenColor, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          activityName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: greenColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// ---------- TIME ----------
                  Row(
                    children: [
                      const Icon(Icons.access_time_filled_rounded,
                          color: Colors.indigo, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        pickupTime,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// ---------- LOCATION ----------
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_rounded,
                          color: Colors.redAccent, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          pickUpLocation,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ---------- STATUS + BUTTON ----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Status pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _statusColor().withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: _statusColor().withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          dayStatus,
                          style: TextStyle(
                            color: _statusColor(),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),

                      /// View Details button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 45,
                        width: 140,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: buttonColor.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: loader ? null : onTap,
                          child: Center(
                            child: loader
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "View Details",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
