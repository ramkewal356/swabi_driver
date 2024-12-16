import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driver_package_model.dart';
import 'package:flutter_driver/model/driver_package_history_model.dart';
import 'package:flutter_driver/respository/driver_packages_repository.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverPackageViewModel with ChangeNotifier {
  DriverpackageserviceRepository driverpackageserviceRepository =
      DriverpackageserviceRepository();
  DriverPackageBookingListModel? driverPackageBookingListModel;
  DriverPackageDetailModel? driverPackageDetailModel;
  DriverPackageBookingHistoryListModel? driverPackageBookingHistoryListModel;
  bool isLoading = false;
  bool isLoading1 = false;
  bool get loading => isLoading;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void updateDayStatus(String newStatus) {
    if (driverPackageDetailModel?.data != null) {
      driverPackageDetailModel?.data.dayStatus = newStatus;
      notifyListeners();
    }
  }

  Future<DriverPackageBookingListModel?> getPackageBookingList({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {"driverId": driverId};
    try {
      isLoading = true;
      notifyListeners();

      var value =
          await driverpackageserviceRepository.getPackageUpcommingListApi(
        query: query,
        context: context,
      );

      if (value?.status.httpCode == '200') {
        driverPackageBookingListModel = value;
        isLoading = false;
        notifyListeners();
        print("Driver Booking Details Success");
      } else {
        print("Failed to fetch booking details");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('error: $e');
    }
    return null;
  }

  Future<DriverPackageDetailModel?> getPackageDetailList({
    required BuildContext context,
    required driverAssignId,
  }) async {
    Map<String, dynamic> query = {"driverAssignedId": driverAssignId};
    try {
      isLoading1 = true;
      notifyListeners();
      // setLoading(true);
      var value = await driverpackageserviceRepository.getPackageDetailListApi(
          query: query, context: context);

      if (value?.status.httpCode == '200') {
        driverPackageDetailModel = value;
        isLoading1 = false;
        notifyListeners();
        print("Driver Booking Details Success");
      } else {
        print("Failed to fetch booking details");
      }
    } catch (e) {
      isLoading1 = false;
      notifyListeners();
      print('error: $e');
    } finally {
      isLoading1 = false;
      notifyListeners();
    }
    return null;
  }

  Future<DriverActivityStartModel?> activityStart(
      {required BuildContext context,
      required packageBookingId,
      required date,
      required zoneId}) async {
    Map<String, dynamic> query = {
      "packageBookingId": packageBookingId,
      "date": date,
      "zoneId": zoneId
    };
    try {
      // return null;
      isLoading = true;
      notifyListeners();

      await driverpackageserviceRepository
          .startActivityApi(query: query, context: context)
          .then((value) {
        if (value?.status.httpCode == '200') {
          // driverPackageDetailModel = value;
          // ignore: use_build_context_synchronously
          Utils.toastSuccessMessage('Activity Started');
          context.pop();
          debugPrint("Driver activity started");
        } else {
          debugPrint("Failed to fetch booking details");
        }

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('error: $e');
    }
    return null;
  }

  Future<DriverActivityCompleteModel?> activityComplete(
      {required BuildContext context,
      required packageBookingId,
      required date,
      required zoneId}) async {
    Map<String, dynamic> query = {
      "packageBookingId": packageBookingId,
      "date": date,
      "zoneId": zoneId
    };
    try {
      isLoading = true;
      notifyListeners();

      await driverpackageserviceRepository
          .completeActivityApi(query: query, context: context)
          .then((value) {
        if (value?.status.httpCode == '200') {
          // driverPackageDetailModel = value;
          updateDayStatus('COMPLETED');
          // ignore: use_build_context_synchronously
          Utils.toastSuccessMessage('Activity Completed');
          // context.pop();
          debugPrint("Driver Activity completed");
        } else {
          debugPrint("Failed to fetch booking details");
        }

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint('error: $e');
    }
    return null;
  }

  Future<DriverPackageBookingHistoryListModel?> getPackageBookingHistoryList({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {"driverId": driverId};
    try {
      isLoading = true;
      notifyListeners();

      var value = await driverpackageserviceRepository.getPackageHistoryListApi(
          query: query, context: context);

      if (value?.status.httpCode == '200') {
        driverPackageBookingListModel = value;
        print("Driver Booking history Success");
      } else {
        print("Failed to fetch booking details");
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('error: $e');
    }
    return null;
  }
}
