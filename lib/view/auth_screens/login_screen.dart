import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/utils/validatorclass.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/firebase_notification/firebase_messaging_service.dart';
import 'package:flutter_driver/firebase_options.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:flutter_driver/widgets/custom_text_form_field.dart';
import 'package:flutter_driver/core/constants/assets.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:flutter_driver/view_model/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String usr = '';
  String pass = '';
  bool value = false;
  bool _rememberMe = false;
  bool obsucePassword = true;
  final _formKey = GlobalKey<FormState>();
  String? notificationToken;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // List<TextEditingController> controller =
  //     List.generate(2, (index) => TextEditingController());
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    // requestPermission();
    getToken();
    savecredential();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //
    // });
  }

  // void requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     debugPrint('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     debugPrint('User granted provisional permission');
  //   } else {
  //     debugPrint('User declined or has not accepted permission');
  //   }
  // }

  void getToken() async {
    notificationToken = await FirebaseMessagingService.getToken();
  }

  Future<void> savecredential() async {
    final prefsData = await SharedPreferences.getInstance();

    setState(() {
      emailController.text = prefsData.getString('email') ?? '';
      passwordController.text = prefsData.getString('password') ?? '';
      _rememberMe = prefsData.getBool('remember') ?? false;
      debugPrint('email id ${emailController.text}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: bgGreyColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(child: Image.asset(appLogo1)),
                  // child: Center(child: Image.asset(appLogo1)),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'WELCOME!\nPlease sign in to your account',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                  // child: CustomTextWidget(
                  //     content: "WELCOME!\nPlease sign in to your account",
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w600,
                  //     maxline: 2,
                  //     textColor: textColor),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(text: 'Enter your email', style: titleTextStyle),
                    const TextSpan(
                        text: ' *', style: TextStyle(color: redColor))
                  ])),
                ),
                Customtextformfield(
                  focusNode: focusNode1,
                  fillColor: background,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter your email',
                  validator: (value) {
                    return Validatorclass.validateEmail(value);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text: 'Enter your password', style: titleTextStyle),
                    const TextSpan(
                        text: ' *', style: TextStyle(color: redColor))
                  ])),
                ),
                Customtextformfield(
                  focusNode: focusNode2,
                  controller: passwordController,
                  obscureText: !obsucePassword,
                  enableInteractiveSelection: obsucePassword,
                  fillColor: background,
                  hintText: 'Enter your password',
                  suffixIcons: IconButton(
                    icon: Icon(
                      obsucePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obsucePassword = !obsucePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      activeColor: btnColor,
                      value: _rememberMe,
                      onChanged: (bool? value1) {
                        FocusScope.of(context).unfocus();
                        focusNode1.unfocus();
                        focusNode2.unfocus();

                        setState(() {
                          _rememberMe = !_rememberMe;
                          debugPrint('rememberme...$_rememberMe');
                        });
                      },
                    ),
                    Expanded(
                        child: Text('Remember Me',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w700,
                                color: Colors.black))),
                    TextButton(
                      onPressed: () {
                        context.push('/forgotPassword');
                      },
                      child: Text('Forgot your password?',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w700,
                              color: Colors.green)),
                    ),
                  ],
                ),
                CustomButtonSmall(
                  height: 45,
                  width: double.infinity,
                  btnHeading: "Sign In",
                  loading: authViewMode.loginResponse.status == Status.loading,
                  onTap: () {
                    String platformType =
                        FirebaseMessagingService().getPlatformType();
                    if (_formKey.currentState!.validate()) {
                      authViewMode.loginApi(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                          notificationToken: notificationToken ?? '',
                          rememberMe: _rememberMe,
                          platformType: platformType);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
        ),
      ),
    );
  }
}
