
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/get_driver_by_id_model.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/data/respositories/driver_profile_repository.dart';
import 'package:flutter_driver/core/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverProfileViewModel with ChangeNotifier {
  final _myRepo = DriverProfileRepository();
  ApiResponse<GetDriverByIdModel> getDriverDetails = ApiResponse.initial();

  void setOnGetDriver(ApiResponse<GetDriverByIdModel> response) {
    getDriverDetails = response;
    notifyListeners();
  }

  ApiResponse<bool> updateDriver = ApiResponse.initial();

  void setOnUpdateDriver(ApiResponse<bool> response) {
    updateDriver = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> profilePicUpdate = ApiResponse.initial();

  void setOnProfilePicUpdate(ApiResponse<CommonModel> response) {
    profilePicUpdate = response;
    notifyListeners();
  }

  Future<void> getDriverByIdApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {"driverId": driverId};
    try {
      setOnGetDriver(ApiResponse.loading());
      var resp = await _myRepo.getDriverByIdApi(query: query);
      setOnGetDriver(ApiResponse.completed(resp));
    } catch (e) {
      setOnGetDriver(ApiResponse.error(e.toString()));
    }
  }

  Future<void> updateProfileApi({
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
      setOnUpdateDriver(ApiResponse.loading());
      var resp = await _myRepo.updateProfileApi(body: body);
      setOnUpdateDriver(ApiResponse.completed(resp));
      Utils.toastSuccessMessage('Profile Updated SuccessFully');
      context.pop();
    } catch (e) {
      setOnUpdateDriver(ApiResponse.error(e.toString()));
    }
  }

  Future<void> uploadProfilePicApi({required String file}) async {
    SharedPreferences srp = await SharedPreferences.getInstance();
    var driverId = srp.getString('userId');
    var profilePic =
        await MultipartFile.fromFile(file, filename: "profile.jpg");
    Map<String, dynamic> body = {"driverId": driverId, "image": profilePic};
    try {
      setOnProfilePicUpdate(ApiResponse.loading());
      var resp = await _myRepo.uploadProfilePicApi(body: body);
      if (resp.status?.httpCode == '200') {
        setOnProfilePicUpdate(ApiResponse.completed(resp));
        Utils.toastSuccessMessage(resp.data?.body ?? '');
      }
    } catch (e) {
      setOnProfilePicUpdate(ApiResponse.error(e.toString()));
    }
  }
}

class GetCountryStateListViewModel with ChangeNotifier {
  final _myRepo = CountryStateRepository();

  ApiResponse<List<dynamic>> getCountryListModel = ApiResponse.initial();

  void setOnCountryList(ApiResponse<List<dynamic>> response) {
    getCountryListModel = response;
    notifyListeners();
  }

  ApiResponse<List<String>> stateList = ApiResponse.initial();

  void setOnStateList(ApiResponse<List<String>> response) {
    stateList = response;
    notifyListeners();
  }

  Future<dynamic> getAccessToken({
    required BuildContext context,
  }) async {
    Map<String, String> headers = {
      'api-token':
          'ky36oc3IK7cBvBSMi9wkMQsvyf2kLTHLg83JuA8pYL5tLotwdV_401qVFkMHMunj8nM',
      'user-email': 'saurabhm@shilshatech.com',
    };
    try {
      var resp = await _myRepo.getAccessTokentApi(header: headers);
      return resp;
    } catch (e) {
      debugPrint('error$e');
    }
    return null;
  }

  Future<void> getCountryList({
    required BuildContext context,
    required String token,
  }) async {
    Map<String, String> header = {
      "Authorization": 'Bearer $token',
    };
    try {
      setOnCountryList(ApiResponse.loading());
      var resp = await _myRepo.getCountryListApi(header: header);
      setOnCountryList(ApiResponse.completed(resp));
    } catch (e) {
      debugPrint('error$e');
      setOnCountryList(ApiResponse.error(e.toString()));
    }
  
  }

  Future<void> getStateList({
    required String country,
  }) async {
    Map<String, dynamic> body = {
      "country": country,
    };
    try {
      setOnStateList(ApiResponse.loading());
      _myRepo.getStateListApi(body: body).then((onValue) {
        if (onValue.data != null) {
          // Filter the data to get the country-specific states
          var countryData = onValue.data?.firstWhere(
            (item) => item.name == country,
            // orElse: () => null,
          );

          if (countryData != null) {
            var states = countryData.states;
            var getStateListModel = states
                ?.map((state) => state.name
                    ?.replaceFirst(RegExp(r' Emirate$'), '') as String)
                .toList();
            setOnStateList(ApiResponse.completed(getStateListModel));
          }
        }
      });
    } catch (e) {
      debugPrint('error$e');
      setOnStateList(ApiResponse.error(e.toString()));
    }
  }
}
