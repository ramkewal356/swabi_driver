// Rental Booking View Model
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/model/change_password_model.dart';
import 'package:flutter_driver/model/common_model.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/respository/driver_profile_repository.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverProfileViewModel with ChangeNotifier {
  final _myRepo = DriverProfileRepository();
  ApiResponse<DriverProfileModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<DriverProfileModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchDriverProfileViewModelApi(
      BuildContext context, data, String uid) async {
    print("${data}sfsdfsdf");
    setDataList(ApiResponse.loading());
    _myRepo
        .driverBookingListRepositoryApi(context: context, query: data)
        .then((value) async {
      setDataList(ApiResponse.completed(value));
      print('Driver Profile Api Success');
      context.push("/profilePage", extra: {"userId": uid});
      // Utils.toastMessage("Data fetching");
    }).onError((error, stackTrace) {
      print(error.toString());
      print('Driver Profile Api Failed');
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchDriverDetailViewModelApi(
      BuildContext context, data, String uid) async {
    print("${data}sfsdfsdf");
    setDataList(ApiResponse.loading());
    _myRepo
        .driverBookingListRepositoryApi(context: context, query: data)
        .then((value) async {
      setDataList(ApiResponse.completed(value));
      print('Driver Profile Api Success');
      // context.push("/profilePage", extra: {"userId": uid});
      // Utils.toastMessage("Data fetching");
    }).onError((error, stackTrace) {
      print(error.toString());
      print('Driver Profile Api Failed');
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

///Driver Profile Update View Model
class DriverProfileUpdateViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();
  ApiResponse<DriverProfileUpdateModel> updateProfile = ApiResponse.loading();
  bool isLoading = false;
  setDataList(ApiResponse<DriverProfileUpdateModel> response) {
    updateProfile = response;
    notifyListeners();
  }

  Future editProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String country,
    required String state,
    required String location,
    required String gender,
  }) async {
    SharedPreferences srp = await SharedPreferences.getInstance();
    var driverId = srp.getString('userId');

    Map<String, dynamic> driverRequest = {
      "driverId": driverId,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "country": country,
      "state": state,
      "driverAddress": location,
    };
    final body = {
      "driverRequest": jsonEncode(driverRequest)
      // "image": profilePic
    };
    try {
      setDataList(ApiResponse.loading());
      isLoading = true;
      notifyListeners();
      await _myRepo.editProfile(context: context, body: body).then((value) {
        setDataList(ApiResponse.completed(value));
        Provider.of<DriverProfileViewModel>(context, listen: false)
            .fetchDriverDetailViewModelApi(
                context, {"driverId": driverId}, driverId ?? '');
        print('Updated successfull');
        context.pop(context);
        Utils.toastSuccessMessage("Profile Updated Successfully");
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print('error$e');
      setDataList(ApiResponse.error(e.toString()));
      isLoading = false;
      notifyListeners();
    }
  }
}

class ResetPasswordViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();
  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  Future<CommonModel?> sendOtp(
      {required BuildContext context, required String email}) async {
    Map<String, dynamic> query = {"email": email};
    try {
      isLoading = true;
      notifyListeners();
      var resp = await _myRepo.sendOtpApi(context: context, query: query);
      if (resp?.status?.httpCode == '200') {
        Utils.toastSuccessMessage(resp?.data?.body ?? '');
        isLoading = false;
        notifyListeners();
      }

      return resp;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint('error$e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> verifyOtp(
      {required BuildContext context,
      required String email,
      required String otp}) async {
    Map<String, dynamic> query = {"email": email, "otp": otp};
    try {
      isLoading1 = true;
      notifyListeners();
      await _myRepo.verifyOtpApi(context: context, query: query).then((resp) {
        if (resp?.status?.httpCode == '200') {
          Utils.toastSuccessMessage(resp?.data?.body ?? '');
          context.push('/resetPassword', extra: {"email": email});
          isLoading = false;
          notifyListeners();
        }
      });
    } catch (e) {
      isLoading1 = false;
      notifyListeners();
      debugPrint('error$e');
    } finally {
      isLoading1 = false;
      notifyListeners();
    }
  }

  Future<CommonModel?> resetPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    Map<String, dynamic> query = {"email": email, "password": password};
    try {
      isLoading2 = true;
      notifyListeners();
      var resp = await _myRepo.resetPasswordApi(context: context, query: query);
      if (resp?.status?.httpCode == '200') {
        Utils.toastSuccessMessage(resp?.data?.body ?? '');
        context.push('/login');
        isLoading2 = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading2 = false;
      notifyListeners();
      debugPrint('error$e');
    } finally {
      isLoading2 = false;
      notifyListeners();
    }
    return null;
  }
}

class UploadProfilePicViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();

  bool isLoading = false;
  Future<CommonModel?> uploadProfilePic(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    try {
      isLoading = true;
      notifyListeners();
      var resp =
          await _myRepo.uploadProfilePicApi(context: context, body: body);
      if (resp?.status?.httpCode == '200') {
        Utils.toastSuccessMessage(resp?.data?.body ?? '');
        // context.push('/login');
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint('error$e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}

class GetCountryStateListViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();
  List<dynamic> getCountryListModel = [];
  List<dynamic> getStateListModel = [];
  bool isLoading = false;
  Future<dynamic> getAccessToken({
    required BuildContext context,
  }) async {
    Map<String, String> headers = {
      'api-token':
          'ky36oc3IK7cBvBSMi9wkMQsvyf2kLTHLg83JuA8pYL5tLotwdV_401qVFkMHMunj8nM',
      'user-email': 'saurabhm@shilshatech.com',
    };
    try {
      var resp =
          await _myRepo.getAccessTokentApi(context: context, header: headers);
      return resp;
    } catch (e) {
      debugPrint('error$e');
    }
    return null;
  }

  Future<dynamic> getCountryList({
    required BuildContext context,
    required String token,
  }) async {
    Map<String, String> header = {
      "Authorization": 'Bearer $token',
    };
    try {
      _myRepo
          .getCountryListApi(context: context, header: header)
          .then((onValue) {
        getCountryListModel = onValue;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('error$e');
    }
    return null;
  }

  Future<dynamic> getStateList({
    required BuildContext context,
    required String token,
    required String country,
  }) async {
    Map<String, String> header = {
      "Authorization": 'Bearer $token',
    };
    try {
      isLoading = true;
      notifyListeners();
      _myRepo
          .getStateListApi(context: context, header: header, country: country)
          .then((onValue) {
        if (onValue != null) {
          getStateListModel = onValue;
          isLoading = false;
          notifyListeners(); // Returns a List
        } else {
          isLoading = false;
          notifyListeners();
          return []; // Return an empty List if the response is null
        }
      });
    } catch (e) {
      debugPrint('error$e');
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}

class ChangePasswordViewModel with ChangeNotifier {
  final _myRepo = DriverProfileRepository();
  ApiResponse<ChangePasswordModel> dataList = ApiResponse.loading();
  bool isLoading = false;
  setDataList(ApiResponse<ChangePasswordModel> response) {
    dataList = response;
    notifyListeners();
  }

  Future<ChangePasswordModel?> changePasswordViewModelApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    try {
      setDataList(ApiResponse.loading());
      isLoading = true;
      notifyListeners();
      await _myRepo
          .changePasswordApi(context: context, query: query)
          .then((value) {
        setDataList(ApiResponse.completed(value));
        Utils.toastSuccessMessage("Password changed successfully");
        context.pop();
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('error $e');
      setDataList(ApiResponse.error(e.toString()));
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
