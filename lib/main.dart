import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_driver/firebase_notification/firebase_messaging_service.dart';
import 'package:flutter_driver/app/route.dart';
import 'package:flutter_driver/view_model/auth_view_model.dart';
import 'package:flutter_driver/view_model/dashboard_view_model.dart';
import 'package:flutter_driver/view_model/driver_rental_booking_view_model.dart';
import 'package:flutter_driver/view_model/driver_profile_view_model.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_driver/view_model/notification_view_model.dart';
import 'package:flutter_driver/view_model/raise_issue_view_model.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

// Fix for background message handler annotation error and example FL setup for DRIVER receiverRole

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Background Message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  await FirebaseMessagingService.initialize(navigatorKey);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // Enforce portrait orientation for the app
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Launch application with required providers
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ChangeNotifierProvider(create: (context) => UserViewModel()),
      ChangeNotifierProvider(create: (context) => DashboardViewModel()),
      ChangeNotifierProvider(
          create: (context) => DriverRentalBookingViewModel()),
      ChangeNotifierProvider(create: (context) => DriverProfileViewModel()),
      ChangeNotifierProvider(create: (context) => DriverPackageViewModel()),
      ChangeNotifierProvider(create: (context) => RaiseIssueViewModel()),
      ChangeNotifierProvider(create: (context) => NotificationViewModel()),
      ChangeNotifierProvider(
          create: (context) => GetCountryStateListViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    );
  }
}
