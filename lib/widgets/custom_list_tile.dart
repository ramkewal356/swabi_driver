// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/core/utils/dimensions.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';

class CustomListTile extends StatelessWidget {
  final String img;
  final Color? iconColor;
  final bool disableColor;
  final String headingTitle;
  final bool headingTitleReq;
  final VoidCallback onTap;
  final String heading;
  const CustomListTile(
      {this.img = "",
      this.iconColor,
      this.disableColor = false,
      this.headingTitle = "",
      this.headingTitleReq = false,
      this.heading = "",
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingTitleReq
            ? Text(headingTitle, style: loginTextStyle)
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 5),
          child: Material(
            color:
                disableColor ? naturalGreyColor.withOpacity(0.2) : background,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    color: disableColor
                        ? naturalGreyColor.withOpacity(0.2)
                        : background,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: naturalGreyColor.withOpacity(0.3))),
                width: AppDimension.getWidth(context) * .9,
                child: Row(
                  children: [
                    Image.asset(
                      img,
                      height: 20,
                      color: iconColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        heading,
                        style: customListTileTextStyle,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
