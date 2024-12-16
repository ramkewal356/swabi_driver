import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/firebase_options.dart';
import 'package:flutter_driver/service_locator.dart';
import 'package:flutter_driver/utils/routes/route.dart';
import 'package:flutter_driver/view_model/auth_view_model.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_driver/view_model/notification_view_model.dart';
import 'package:flutter_driver/view_model/raiseIssue_view_model.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(
            create: (context) => DriverGetBookingListViewModel()),
        ChangeNotifierProvider(
            create: (context) => DriverGetBookingDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => DriverProfileViewModel()),
        ChangeNotifierProvider(
            create: (context) => ChangePasswordViewModel()),
        ChangeNotifierProvider(
            create: (context) => DriverProfileUpdateViewModel()),
        ChangeNotifierProvider(create: (context) => DriverOnRunningViewModel()),
        ChangeNotifierProvider(
            create: (context) => DriverCompletedBookingViewModel()),
    
        ChangeNotifierProvider(create: (context) => DriverPackageViewModel()),
        ChangeNotifierProvider(create: (context) => RaiseissueViewModel()),
        ChangeNotifierProvider(create: (context) => ResetPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => NotificationViewModel()),
        ChangeNotifierProvider(
            create: (context) => UploadProfilePicViewModel()),
        ChangeNotifierProvider(
            create: (context) => GetCountryStateListViewModel()),
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: myRouter,
      // home: VendorProfileScreen(),
      // const SplashSreen(),
    );
  }
}
