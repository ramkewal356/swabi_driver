import 'package:flutter_driver/firebase_notification/firebase_messaging_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;


void setupLocator() {
  locator.registerLazySingleton<FirebaseMessagingService>(
      () => FirebaseMessagingService());
 
}

