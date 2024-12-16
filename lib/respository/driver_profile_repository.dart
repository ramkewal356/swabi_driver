import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/app_url.dart';
import 'package:flutter_driver/data/response/baseResponse.dart';
import 'package:flutter_driver/model/change_password_model.dart';
import 'package:flutter_driver/model/common_model.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/view_model/services/http_service.dart';

///Driver Profile Detail Repo
class DriverProfileRepository {
  Future<dynamic> driverBookingListRepositoryApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getDriverUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('Driver Profile Repo api success ${response?.data}');
      var resp = DriverProfileModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver Profile api repo not successful error");
      http.handleErrorResponse(context: context, error: e);
      rethrow;
    }
  }

  Future<ChangePasswordModel?> changePasswordApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.changepasswordUrl,
        methodType: HttpMethodType.PATCH,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("passord change response ${response?.data}");
      var resp = ChangePasswordModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error $error');
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }
}

class DriverProfileUpdateRepository {
  Future<DriverProfileUpdateModel?> editProfile(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverProfileUpdateEndUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.FormData,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print('response data:--${response?.data}');
      var resp = DriverProfileUpdateModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      // BaseResponseModel baseResponseModel =
      //     BaseResponseModel.fromJson(error.response?.data);
      // print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
    // return null;
  }

  Future<CommonModel?> sendOtpApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.sendOtpsUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
    // return null;
  }

  Future<CommonModel?> verifyOtpApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.verifyOtpUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }

  Future<CommonModel?> resetPasswordApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.resetPassordUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }

  Future<CommonModel?> uploadProfilePicApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.uploadProfilePic,
        methodType: HttpMethodType.PATCH,
        bodyType: HttpBodyType.FormData,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("upload profile pic ${response?.data}");
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error . $error');
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }

  Future<dynamic> getCountryListApi(
      {required BuildContext context,
      required Map<String, String> header}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.locationBaseUrl,
        endURL: AppUrl.getCountryList,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        headers: header);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("getcountry List response ${response?.data}");
      // var resp = GetCountryListModel.fromJson(jsonDecode(response?.data));

      // Convert to a list of GetCountryListModel
      return response?.data;

      // return resp;
    } catch (error) {
      debugPrint('error.. $error');
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }

  Future<dynamic> getStateListApi(
      {required BuildContext context,
      required Map<String, String> header,
      required String country}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.locationBaseUrl,
        endURL: AppUrl.getStateList + country,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        headers: header);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("getcountry List response ${response?.data}");
      // var resp = GetStateListModel.fromJson(response?.data);
      if (response?.data != null) {
        return response?.data;
      } else {
        return null;
      }
      // return response?.data;
    } catch (error) {
      debugPrint('error.. $error');
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }

  Future<dynamic> getAccessTokentApi({
    required BuildContext context,
    required Map<String, String> header,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.locationBaseUrl,
        endURL: AppUrl.getAccessTokenUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        headers: header);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("getcountry List response ${response?.data}");
      // var resp = GetStateListModel.fromJson(response?.data);
      return response?.data;
    } catch (error) {
      debugPrint('error.. $error');
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }
}
