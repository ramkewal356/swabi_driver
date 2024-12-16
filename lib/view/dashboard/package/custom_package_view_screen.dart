import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';

class Custompackageviewpage extends StatefulWidget {
  final String driverAssignId;
  final String date;
  final String pickUpLocation;
  final String activityName;
  final String daySatus;
  final String pickupTime;
  final bool loader;
  final void Function()? onTap;
  const Custompackageviewpage(
      {super.key,
      required this.driverAssignId,
      required this.date,
      required this.pickUpLocation,
      required this.activityName,
      required this.daySatus,
      required this.loader,
      required this.pickupTime,
      required this.onTap});

  @override
  State<Custompackageviewpage> createState() => _CustompackageviewpageState();
}

class _CustompackageviewpageState extends State<Custompackageviewpage> {
  @override
  Widget build(BuildContext context) {
    print('loader.......${widget.loader}');
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          // color: bgGreyColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Driver Assign ID:${widget.driverAssignId}',
                style: textStyle,
              ),
              Text(
                'Date: ${widget.date}',
                style: textStyle,
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Activity Name:',
                style: titleTextStyle,
              ),
              Text(
                'PickupTime: ${widget.pickupTime}',
                style: titleTextStyle,
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
              Expanded(
                child: Text(
                  widget.activityName,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PickUp Location: ',
                style: textStyle,
              ),
              Expanded(
                child: Text(
                  widget.pickUpLocation,
                  style: textStyle,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          // Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: widget.daySatus == 'COMPLETED'
                        ? greenColor
                        : widget.daySatus == 'ONGOING'
                            ? Colors.orange
                            : widget.daySatus == 'PENDING'
                                ? redColor
                                : null,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    widget.daySatus,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              CustomButtonSmall(
                width: 120,
                height: 40,
                loading: widget.loader,
                btnHeading: "View Details",
                onTap: widget.onTap,
              ),
            ],
          )
        ],
      ),
    );
  }
}
