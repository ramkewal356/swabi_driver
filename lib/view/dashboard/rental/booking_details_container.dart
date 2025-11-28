// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/assets.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailsContainer extends StatelessWidget {
  final String carName;
  final String date;
  final String bookingId;
  final String status;
  final List carImage;
  final String fuelType;
  final String seat;
  final VoidCallback? onTapContainer;
  final bool loader;

  const BookingDetailsContainer({
    super.key,
    this.onTapContainer,
    required this.carName,
    required this.date,
    required this.bookingId,
    required this.status,
    required this.carImage,
    required this.fuelType,
    required this.loader,
    required this.seat,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = status == "CANCELLED"
        ? Colors.red
        : status == "ONGOING"
            ? Colors.orange
            : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTapContainer,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(.9),
                  Colors.white.withOpacity(.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Row: Image + Info
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 70,
                              width: 70,
                              color: Colors.grey.shade200,
                              child: carImage.isEmpty
                                  ? Image.asset(car3, fit: BoxFit.cover)
                                  : Image.network(carImage[0],
                                      fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Car Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  carName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        size: 16, color: Colors.grey.shade700),
                                    const SizedBox(width: 6),
                                    Text(
                                      date,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(Icons.event_seat,
                                        size: 16, color: Colors.grey.shade700),
                                    const SizedBox(width: 6),
                                    Text(
                                      seat,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      "ID: $bookingId",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      fuelType,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Bottom row: Status + Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Status Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(.15),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.poppins(
                                color: statusColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          CustomButtonSmall(
                              height: 40,
                              width: 120,
                              loading: loader,
                              btnHeading: 'View Details',
                              onTap: onTapContainer)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
