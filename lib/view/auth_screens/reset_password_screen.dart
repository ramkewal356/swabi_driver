import 'package:flutter/material.dart';
import 'package:flutter_driver/core/utils/validatorclass.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/view_model/auth_view_model.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:flutter_driver/widgets/custom_text_form_field.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:go_router/go_router.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpass = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: bgGreyColor,
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                    child: Image.asset('assets/images/Asset 233000 1.png')),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(text: 'New password', style: titleTextStyle),
                          const TextSpan(
                              text: ' *', style: TextStyle(color: redColor))
                        ])),
                        const SizedBox(
                          height: 5,
                        ),
                        Customtextformfield(
                          fillColor: background,
                          obscureText: !obscurePassword,
                          // obscuringCharacter: '*',
                          enableInteractiveSelection: obscurePassword,
                          controller: password,
                          hintText: 'New password',
                          suffixIcons: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter new password';
                            } else {
                              return Validatorclass.validatePassword(value);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Confirm password', style: titleTextStyle),
                          const TextSpan(
                              text: ' *', style: TextStyle(color: redColor))
                        ])),
                        const SizedBox(
                          height: 4,
                        ),
                        Customtextformfield(
                          fillColor: background,
                          obscureText: !obscureConfirmPassword,
                          // obscuringCharacter: '*',
                          enableInteractiveSelection: obscureConfirmPassword,
                          controller: confirmpass,
                          hintText: 'Confirm password',
                          suffixIcons: IconButton(
                            icon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureConfirmPassword =
                                    !obscureConfirmPassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter confirm password';
                            } else if (value != password.text) {
                              return "Password not matched";
                            } else {
                              return Validatorclass.validatePassword(value);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtonSmall(
                            loading: viewModel.resetPassResponse.status ==
                                Status.loading,
                            width: double.infinity,
                            height: 50,
                            btnHeading: 'Submit',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.resetPassword(
                                    context: context,
                                    email: widget.email,
                                    password: password.text);
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
      },
    );
  }
}
