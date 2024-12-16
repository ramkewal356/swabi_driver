import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/custom_list_tile.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:go_router/go_router.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
        appBarTitle: 'Help & Support',
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Custom_ListTile(
              img: rideIssue,
              iconColor: btnColor,
              heading: "Raised Issue",
              onTap: () => context.push("/getRaiseIssue"),
            ),
            // Custom_ListTile(
            //   img: otherIssue,
            //   iconColor: btnColor,
            //   heading: "Other Issue",
            //   onTap: () {},
            //   // onTap: () => context.push("/termCondition"),
            // ),
            Custom_ListTile(
                img: contact,
                disableColor: true,
                iconColor: btnColor,
                heading: "Contact",
                onTap: () {
                  // context.push("/contact");
                }),
            Custom_ListTile(
              disableColor: true,
              img: privacyPolicy,
              iconColor: btnColor,
              heading: "Privacy & Policy",
              onTap: () {},
              // onTap: () => context.push("/termCondition"),
            ),
            Custom_ListTile(
              img: tnc,
              iconColor: btnColor,
              heading: "Term & Condition",
              onTap: () => context.push("/termCondition"),
            ),
          ],
        ));
  }
}
