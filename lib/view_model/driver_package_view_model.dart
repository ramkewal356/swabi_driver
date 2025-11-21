import 'package:flutter/material.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/driver_package_model.dart';
// import 'package:flutter_driver/data/models/driver_package_history_model.dart';
import 'package:flutter_driver/data/models/get_package_details_model.dart';
import 'package:flutter_driver/data/models/package_history_model.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/data/respositories/driver_packages_repository.dart';
import 'package:flutter_driver/core/utils/utils.dart';
// import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverPackageViewModel with ChangeNotifier {
  DriverpackageserviceRepository driverpackageserviceRepository =
      DriverpackageserviceRepository();

  ApiResponse<DriverPackageBookingListModel> packageBookingList =
      ApiResponse.initial();
  void setPackageList(ApiResponse<DriverPackageBookingListModel> response) {
    packageBookingList = response;
    notifyListeners();
  }

  ApiResponse<GetPackageDetailsModel> packageDetails = ApiResponse.initial();
  void setPackageDetails(ApiResponse<GetPackageDetailsModel> response) {
    packageDetails = response;
    notifyListeners();
  }

  ApiResponse<PackageHistoryModel> packageHistoryList = ApiResponse.initial();
  void setPackageHistoryList(ApiResponse<PackageHistoryModel> response) {
    packageHistoryList = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> startActivity = ApiResponse.initial();
  void setOnStartActivity(ApiResponse<CommonModel> response) {
    startActivity = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> completeActivity = ApiResponse.initial();
  void setOnCompleteActivity(ApiResponse<CommonModel> response) {
    completeActivity = response;
    notifyListeners();
  }

  void updateDayStatus(String newStatus) {
    if (packageDetails.data != null) {
      packageDetails.data?.data?.dayStatus = newStatus;
      notifyListeners();
    }
  }

  Future<DriverPackageBookingListModel?> getPackageBookingList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {"driverId": driverId};
    try {
      setPackageList(ApiResponse.loading());

      var value = await driverpackageserviceRepository
          .getPackageUpcommingListApi(query: query);

      if (value?.status.httpCode == '200') {
        setPackageList(ApiResponse.completed(value));
        debugPrint("Driver Booking Details Success");
      } else {
        debugPrint("Failed to fetch booking details");
      }
    } catch (e) {
      setPackageList(ApiResponse.error(e.toString()));
      debugPrint('error: $e');
    }
    return null;
  }

  Future<DriverPackageDetailModel?> getPackageDetailList({
    required String driverAssignId,
  }) async {
    Map<String, dynamic> query = {"driverAssignedId": driverAssignId};
    try {
      setPackageDetails(ApiResponse.loading());
      var value = await driverpackageserviceRepository.getPackageDetailListApi(
          query: query);

      if (value.status?.httpCode == '200') {
        setPackageDetails(ApiResponse.completed(value));
        debugPrint("Driver Booking Details Success");
      } else {
        debugPrint("Failed to fetch booking details");
      }
    } catch (e) {
      setPackageDetails(ApiResponse.error(e.toString()));
      debugPrint('error: $e');
    }
    return null;
  }

  Future<CommonModel?> activityStart(
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
      setOnStartActivity(ApiResponse.loading());
      var resp =
          await driverpackageserviceRepository.startActivityApi(query: query);
      setOnStartActivity(ApiResponse.completed(resp));
      Utils.toastSuccessMessage(resp?.data?.body ?? '');
      return resp;
    } catch (e) {
      setOnStartActivity(ApiResponse.error(e.toString()));
      debugPrint('error: $e');
    }
    return null;
  }

  Future<CommonModel?> activityComplete(
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
      setOnCompleteActivity(ApiResponse.loading());
      var resp = await driverpackageserviceRepository.completeActivityApi(
          query: query);
      setOnCompleteActivity(ApiResponse.completed(resp));
      Utils.toastSuccessMessage(resp?.data?.body ?? '');
      return resp;
    } catch (e) {
      setOnCompleteActivity(ApiResponse.error(e.toString()));
      debugPrint('error: $e');
    }
    return null;
  }

  Future<PackageHistoryModel?> getPackageBookingHistoryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {"driverId": driverId};
    try {
      setPackageHistoryList(ApiResponse.loading());
      var value = await driverpackageserviceRepository.getPackageHistoryListApi(
          query: query);

      if (value.status?.httpCode == '200') {
        setPackageHistoryList(ApiResponse.completed(value));
        debugPrint("Driver Booking history Success");
      } else {
        debugPrint("Failed to fetch booking details");
      }
    } catch (e) {
      setPackageHistoryList(ApiResponse.error(e.toString()));
      debugPrint('error: $e');
    }
    return null;
  }
}
