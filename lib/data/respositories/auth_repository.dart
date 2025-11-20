import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/core/services/http_service.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/login_model.dart';

class AuthRepository {
  //user registration
  Future<LoginModel> loginApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverlogin,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('registration api success ${response?.data}');
      return LoginModel.fromJson(response?.data);
    } catch (e) {
      debugPrint("registration api not successful error $e");

      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: e);
      rethrow;
    }
  }

  Future<CommonModel?> changePasswordApi(
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
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error $error');
      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
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
      debugPrint("passord change response ${response?.data}");
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error..$error');
      // ignore: use_build_context_synchronously
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
      debugPrint("passord change response  ${response?.data}");
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error..$error');
      // ignore: use_build_context_synchronously
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
      debugPrint("passord change response ${response?.data}");
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error..$error');
      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }
}
