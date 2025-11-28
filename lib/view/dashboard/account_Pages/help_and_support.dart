import 'package:flutter/material.dart';
import 'package:flutter_driver/widgets/custom_list_tile.dart';
import 'package:flutter_driver/core/constants/assets.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:go_router/go_router.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
        appBarTitle: 'Help & Support',
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CustomListTile(
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
            CustomListTile(
                img: contact,
                disableColor: true,
                iconColor: btnColor,
                heading: "Contact",
                onTap: () {
                  // context.push("/contact");
                }),
            CustomListTile(
              disableColor: true,
              img: privacyPolicy,
              iconColor: btnColor,
              heading: "Privacy & Policy",
              onTap: () {},
              // onTap: () => context.push("/termCondition"),
            ),
            CustomListTile(
              img: tnc,
              iconColor: btnColor,
              heading: "Term & Condition",
              onTap: () => context.push("/termCondition"),
            ),
          ],
        ));
  }
}
