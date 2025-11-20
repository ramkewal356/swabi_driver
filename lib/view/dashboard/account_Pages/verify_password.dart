import 'package:flutter/material.dart';
import 'package:flutter_driver/widgets/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/widgets/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/widgets/login/login_customTextFeild.dart';
import 'package:flutter_driver/core/constants/assets.dart';
import 'package:flutter_driver/core/utils/dimensions.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:go_router/go_router.dart';

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({super.key});

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  @override
  Widget build(BuildContext context) {
    return PageLayout_Curve(appHeading: "Verify Password",
        child: Column(
          children: [
            LoginTextFeild(
                headingReq: true,
                controller: TextEditingController(),
                heading: "Old Password",
              img: pass,
              prefixIcon: true,
              obscure: true,
              suffixIcon: true,
              hint: "Enter your old password",
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: AppDimension.getWidth(context)*.9,
                child: Text("Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien.",
                style: infoTextStyle,
                )),
            const Spacer(),
            CustomButtonBig(btnHeading: "Next",
              onTap: () => context.push("/changePassword"),),
            const SizedBox(height: 10),
          ],
        ));
  }
}
