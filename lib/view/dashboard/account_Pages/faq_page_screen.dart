import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/expansion_tile.dart';
import 'package:flutter_driver/utils/text_styles.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
      appBarTitle: "FAQ's",
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ExpansionTileWidget(
                header: Text("Lorem ipsum dolor", style: titleTextStyle),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
                  )
                ]),
            const SizedBox(height: 10),
            ExpansionTileWidget(
                header: Text("Lorem ipsum dolor", style: titleTextStyle),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
                  )
                ]),
            const SizedBox(height: 10),
            ExpansionTileWidget(
                header: Text("Lorem ipsum dolor", style: titleTextStyle),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
                  )
                ]),
          ],
        ),
      ),
    );
    // return PageLayout_Curve(
    //   appHeading: "FAQ's",
    //   child: Column(
    //     children: [
    //       const SizedBox(height: 10),
    //       ExpansionTileWidget(
    //           header: Text("Lorem ipsum dolor", style: titleTextStyle),
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //               child: Text(
    //                   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
    //             )
    //           ]),
    //       const SizedBox(height: 10),
    //       ExpansionTileWidget(
    //           header: Text("Lorem ipsum dolor", style: titleTextStyle),
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //               child: Text(
    //                   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
    //             )
    //           ]),
    //       const SizedBox(height: 10),
    //       ExpansionTileWidget(
    //           header: Text("Lorem ipsum dolor", style: titleTextStyle),
    //           children: const [
    //             Padding(
    //               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //               child: Text(
    //                   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
    //             )
    //           ]),
    //     ],
    //   ),
    // );
  }
}
