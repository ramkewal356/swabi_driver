import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/driver_profile_model.dart';
import 'package:flutter_driver/data/models/get_state_name_model.dart';
import 'package:flutter_driver/core/services/http_service.dart';

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
      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: e);
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
      debugPrint('response data:--${response?.data}');
      var resp = DriverProfileUpdateModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
    // return null;
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
      // ignore: use_build_context_synchronously
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
      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }

  Future<GetStateNameModel> getStateListApi({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.stateBaseUrl,
        endURL: AppUrl.getStateNameUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        // headers: header
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("getcountry List response ${response?.data}");
      var resp = GetStateNameModel.fromJson(response?.data);

      return resp;
    } catch (error) {
      debugPrint('error.. $error');
      // ignore: use_build_context_synchronously
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
      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }
}
