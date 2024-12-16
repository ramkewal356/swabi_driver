import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String content;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final int? maxline;
  const CustomTextWidget({
    super.key,
    required this.content,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: GoogleFonts.lato(
        fontWeight: fontWeight,
        color: textColor,
        fontSize: fontSize),
      overflow: TextOverflow.ellipsis,
      maxLines: maxline ?? 1,
      textAlign: TextAlign.start,
    );
  }
}

class CustomLogoTextWidget extends StatelessWidget {
  final String content;
  final double fontSize;
  final bool logo;
  final FontWeight fontWeight;
  final Color textColor;
  final int? maxline;
  const CustomLogoTextWidget({
    super.key,
    required this.content,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.logo = false,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        logo ? Container(
          margin: const EdgeInsets.only(right: 5),
          width: 5,
          height: fontSize,
          color: btnColor,
        ) : const SizedBox(),
        Text(content,
          style: GoogleFonts.lato(
            fontWeight: fontWeight,
            color: textColor,
            fontSize: fontSize),
          overflow: TextOverflow.ellipsis,
          maxLines: maxline ?? 1,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
