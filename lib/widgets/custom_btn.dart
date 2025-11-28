import 'package:flutter/material.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonSmall extends StatelessWidget {
  final String btnHeading;
  final VoidCallback? onTap; // Changed to nullable
  final double? width;
  final double? height;
  final bool loading;
  final Color? btncolor;
  final Color? textColor;
  final double? borderRadius;
  final bool isEnabled; // Added this line

  const CustomButtonSmall({
    super.key,
    required this.btnHeading,
    required this.onTap,
    this.loading = false,
    this.borderRadius,
    this.width,
    this.height,
    this.btncolor,
    this.textColor,
    this.isEnabled = true, // Added this line
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      color:
          isEnabled ? (btncolor ?? btnColor) : Colors.grey, // Changed this line
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
        onTap: (loading || !isEnabled) ? null : onTap, // Modified this line
        child: SizedBox(
          height: height ?? 55,
          width: width ?? MediaQuery.of(context).size.width * .5,
          child: Center(
            child: loading
                // ? const CircularProgressIndicator(color: background)
                ? const SpinKitWave(
                    size: 15,
                    duration: Duration(milliseconds: 500),
                    color: background,
                  )
                : Text(btnHeading,
                    style: GoogleFonts.poppins(
                        color: isEnabled
                            ? (textColor ?? Colors.white)
                            : Colors.black54, // Modified this line
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

class LoginSignUpBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String sideHeading;
  final String btnHeading;
  const LoginSignUpBtn(
      {super.key,
      required this.onTap,
      required this.sideHeading,
      required this.btnHeading});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          sideHeading,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(0, 0, 0, 0.5)),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            " $btnHeading",
            style: GoogleFonts.lato(
                fontWeight: FontWeight.w700, color: greenColor),
          ),
        ),
      ],
    );
  }
}
