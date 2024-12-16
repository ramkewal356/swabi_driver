import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
        appBarTitle: 'Term & Condition',
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              // Text("TERMS AND CONDITIONS",
              //     style: pageHeadingTextStyle, textAlign: TextAlign.left),
              // const SizedBox(
              //   height: 10,
              // ),
              SizedBox(
                width: AppDimension.getHeight(context) * .9,
                child: Text(
                    "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et "
                    "massa mi. Aliquam in hendrerit urna. Pellentesque sit amet "
                    "sapien fringilla, mattis ligula consectetur, ultrices. Lorem "
                    "ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. "
                    "Aliquam in hendrerit urna. Pellentesque sit amet sapien "
                    "fringilla, mattis ligula consectetur, ultrices.",
                    style: termCondition,
                    textAlign: TextAlign.left),
              ),
              // const SizedBox(
              //   height: 25,
              // ),
              // Text("CONTACT US - CUSTOMER SERVICE",
              //     style: pageHeadingTextStyle, textAlign: TextAlign.left),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              //   decoration: BoxDecoration(
              //       color: curvePageColor,
              //       borderRadius: BorderRadius.circular(5)),
              //   width: AppDimension.getHeight(context) * .9,
              //   child: Text(
              //       "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et "
              //       "massa mi. Aliquam in hendrerit urna. Pellentesque sit amet "
              //       "sapien fringilla, mattis ligula consectetur, ultrices.",
              //       style: pageSubHeadingTextStyle,
              //       textAlign: TextAlign.left),
              // ),
            ],
          ),
        ));
    // return PageLayout_Curve(
    //     appHeading: "Term & Condition",
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text("TERMS AND CONDITIONS",
    //             style: pageHeadingTextStyle, textAlign: TextAlign.left),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         SizedBox(
    //           width: AppDimension.getHeight(context) * .9,
    //           child: Text(
    //               "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et "
    //                   "massa mi. Aliquam in hendrerit urna. Pellentesque sit amet "
    //                   "sapien fringilla, mattis ligula consectetur, ultrices. Lorem "
    //                   "ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. "
    //                   "Aliquam in hendrerit urna. Pellentesque sit amet sapien "
    //                   "fringilla, mattis ligula consectetur, ultrices.",
    //               style: pageSubHeadingTextStyle,
    //               textAlign: TextAlign.left),
    //         ),
    //         const SizedBox(
    //           height: 25,
    //         ),
    //         Text("CONTACT US - CUSTOMER SERVICE",
    //             style: pageHeadingTextStyle, textAlign: TextAlign.left),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Container(
    //           padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
    //           decoration: BoxDecoration(
    //             color: curvePageColor,
    //             borderRadius: BorderRadius.circular(5)
    //           ),
    //           width: AppDimension.getHeight(context) * .9,
    //           child: Text(
    //               "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et "
    //                   "massa mi. Aliquam in hendrerit urna. Pellentesque sit amet "
    //                   "sapien fringilla, mattis ligula consectetur, ultrices.",
    //               style: pageSubHeadingTextStyle,
    //               textAlign: TextAlign.left),
    //         ),
    //       ],
    //     )
    //     );
  }
}
