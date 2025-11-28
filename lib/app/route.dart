// routes.dart

import 'package:flutter/material.dart';
import 'package:flutter_driver/view/dashboard/bottom_navigation_bar.dart';
import 'package:flutter_driver/view/dashboard/package/upcoming_package_booking_screen.dart';
import 'package:flutter_driver/view/dashboard/raiseIssue_pages/custom_ride_issue_page.dart';
import 'package:flutter_driver/view/auth_screens/change_password_screen.dart';
import 'package:flutter_driver/view/dashboard/account_pages/help_and_support.dart';
import 'package:flutter_driver/view/dashboard/notification/notification_screen.dart';
import 'package:flutter_driver/view/dashboard/account_pages/profile_screen.dart';
import 'package:flutter_driver/view/dashboard/raiseIssue_pages/raise_issue_screen.dart';
import 'package:flutter_driver/view/dashboard/account_pages/term_condition.dart';
import 'package:flutter_driver/view/dashboard/home_screen.dart';
import 'package:flutter_driver/view/dashboard/package/package_detail_screen.dart';
import 'package:flutter_driver/view/dashboard/history/history_management_screen.dart';
import 'package:flutter_driver/view/dashboard/raiseIssue_pages/issue_view_details.dart';
import 'package:flutter_driver/view/dashboard/rental/rental_booking_detail_screen.dart';
import 'package:flutter_driver/view/dashboard/rental/rental_booking_managment.dart';
import 'package:flutter_driver/view/auth_screens/forgot_screen.dart';
import 'package:flutter_driver/view/auth_screens/login_screen.dart';
import 'package:flutter_driver/view/auth_screens/otp_verification_screen.dart';
import 'package:flutter_driver/view/auth_screens/reset_password_screen.dart';
import 'package:flutter_driver/view/auth_screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter myRouter = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashSreen();
        }),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),

    ShellRoute(
      builder: (context, state, child) =>
          CustomBottomNavigationBar(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
            path: '/rentalManagement',
            builder: (context, state) => const RentalBookingManagment()),
        GoRoute(
            path: '/packageManagement',
            builder: (context, state) => const UpcommingPackagebooking()),
        GoRoute(
            path: '/user', builder: (context, state) => const ProfilePage()),
      ],
    ),
    GoRoute(
      path: '/historyManagement',
      builder: (BuildContext context, GoRouterState state) {
       
        return const HistoryManagementScreen();
      },
    ),
    GoRoute(
      path: '/notification',
      builder: (BuildContext context, GoRouterState state) {
       
        return NotificationScreen();
      },
    ),
    GoRoute(
        path: '/profilePage',
        builder: (BuildContext context, GoRouterState state) {
        return ProfilePage();
      },
     
    ),
   
    GoRoute(
      path: '/packageDetailPage',
      
      builder: (BuildContext context, GoRouterState state) {
        var bookingId = state.extra as Map<String, dynamic>;
        return Packagedetailpage(
          driverAssignedId: bookingId["driverAssignedId"],
        
        );
      },
    ),
    GoRoute(
      path: '/setting',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(
            child: Scaffold(
          body: Center(child: Text("Setting Page")),
        ));
      },
    ),
    GoRoute(
      path: '/changePassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var driverId = state.extra as Map<String, dynamic>;
        return ChangePassword(
          driverId: driverId['driverId'],
        );
      },
    ),
    GoRoute(
      path: '/forgotPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPassword();
      },
    ),
    GoRoute(
      path: '/verifyOtp',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return OtpVerificationScreen(
          email: data["email"],
        );
      },
    ),
    GoRoute(
      path: '/resetPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;

        return ResetPasswordScreen(
          email: data["email"],
        );
      },
    ),
    GoRoute(
      path: '/termCondition',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const TermCondition();
      },
    ),
    GoRoute(
      path: '/help&support',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpAndSupport();
      },
    ),
    GoRoute(
      path: '/rideIssue',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var dataValue = state.extra as Map<String, dynamic>;
        return CustomRideissuePage(
          bookingId: dataValue['bookingId'],
          bookingType: dataValue['bookingType'],
          vendorId: dataValue["vendorId"],
        );
      },
    ),
    GoRoute(
      path: '/getRaiseIssue',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const RaiseIssueScreen();
      },
    ),
    GoRoute(
      path: '/issueDetailsbyId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return IssueViewDetails(
          issueId: data["issueId"],
        );
      },
    ),
    GoRoute(
      path: '/bookingDetails',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return RentalBookingDetailScreen(
          bookingId: data['bookingId'],
        );
      },
    ),
  ],
);
