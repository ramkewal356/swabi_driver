import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonBig extends StatelessWidget {
  final String btnHeading;
  final VoidCallback onTap;
  final double? widht;
  final bool loading;
  const CustomButtonBig(
      {super.key,
      required this.btnHeading,
      this.loading = false,
      this.widht,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: btnColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: SizedBox(
          height: 50,
          width: widht ?? AppDimension.getWidth(context) * .95,
          child: Center(
              child: loading
                  // ? const CircularProgressIndicator(
                  //     color: background,
                  //   )
                  ? const SpinKitWave(
                      size: 15,
                      duration: Duration(milliseconds: 500),
                      color: background,
                    )
                  : Text(
                      btnHeading,
                      style: btnTextStyle,
                    )),
        ),
      ),
    );
  }
}

class CustomButtonLogout extends StatelessWidget {
  final String img;
  final String btnHeading;
  final VoidCallback onTap;
  const CustomButtonLogout(
      {super.key,
      required this.img,
      required this.btnHeading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: btnColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: AppDimension.getWidth(context) * .9,
          child: Row(
            children: [
              Image.asset(
                img,
                height: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                btnHeading,
                style: btnTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButtonSmall extends StatelessWidget {
  final String btnHeading;
  final VoidCallback? onTap; // Changed to nullable
  final double? width;
  final double? height;
  final bool loading;
  final Color? btncolor;
  final Color? textColor;
  final bool isEnabled; // Added this line

  const CustomButtonSmall({
    super.key,
    required this.btnHeading,
    required this.onTap,
    this.loading = false,
    this.width,
    this.height,
    this.btncolor,
    this.textColor,
    this.isEnabled = true, // Added this line
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color:
          isEnabled ? (btncolor ?? btnColor) : Colors.grey, // Changed this line
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
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
                    style: GoogleFonts.lato(
                        color: isEnabled
                            ? (textColor ?? Colors.white)
                            : Colors.black54, // Modified this line
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}

class Login_SignUpBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String sideHeading;
  final String btnHeading;
  const Login_SignUpBtn(
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
