import 'package:flutter/material.dart';
import 'package:flutter_driver/core/utils/validatorclass.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/view_model/auth_view_model.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:flutter_driver/widgets/custom_text_form_field.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  TextEditingController forgetPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: bgGreyColor,
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                  child: Image.asset('assets/images/Asset 233000 1.png')),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Forgot Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Enter your email to reset your password'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Enter your Email', style: titleTextStyle),
                        const TextSpan(
                            text: ' *', style: TextStyle(color: redColor))
                      ])),
                      const SizedBox(
                        height: 4,
                      ),
                      Customtextformfield(
                        controller: email,
                        hintText: 'Enter your email',
                        fillColor: background,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your email';
                          } else {
                            return Validatorclass.validateEmail(value);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButtonSmall(
                          width: double.infinity,
                          loading: viewModel.sendOtpResponse.status ==
                              Status.loading,
                          height: 50,
                          btnHeading: 'Submit',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel
                                  .sendOtp(context: context, email: email.text)
                                  .then((onValue) {
                                if (onValue?.status?.httpCode == '200') {
                                  // ignore: use_build_context_synchronously
                                  context.push('/verifyOtp',
                                      extra: {"email": email.text});
                                }
                              });
                            }
                          }),
                      const SizedBox(height: 10),
                      LoginSignUpBtn(
                        onTap: () => context.push("/login"),
                        btnHeading: 'Sign In',
                        sideHeading: 'Back to',
                      ),
                    ],
                  )),
            ),
          ]),
        ),
      );
    });
  }
}
