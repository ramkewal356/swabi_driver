
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  String noData;
   NoData({super.key, required this.noData});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        height: h*0.35,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Illustration.png",
              fit: BoxFit.contain,
              height: h*0.15,
              width: w,
            ),
            SizedBox(height: h*0.01,),
            const Text(
              "No Data Found",// AppLocale.noDataFound.getString(context),
              style: TextStyle(
                color: Color(0xff23282E),
                fontSize: 22,
                fontFamily: "popins",
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
              ),
            ),
            SizedBox(height: h*0.01,),

            Text(
              noData,
              style: const TextStyle(
                color: Color(0xff23282E),
                fontSize: 18,
                // fontFamily: latoBoldFont,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
