import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/get_driver_by_id_model.dart';
import 'package:flutter_driver/data/models/get_state_name_model.dart';
import 'package:flutter_driver/core/services/http_service.dart';

///Driver Profile Detail Repo
class DriverProfileRepository {
  Future<GetDriverByIdModel> getDriverByIdApi(
      {
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
      var resp = GetDriverByIdModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver Profile api repo not successful error");

      http.handleErrorResponse(error: e);
      rethrow;
    }
  }
  Future<bool> updateProfileApi({
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
      if (response != null && response.statusCode == 200) {
        debugPrint("Add Edit Driver Success: ${response.data}");
        return true;
      } else {
        debugPrint("Add Edit Driver Failed: ${response?.statusCode}");
        return false;
      }
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<CommonModel> uploadProfilePicApi(
      {
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
      http.handleErrorResponse(error: error);
      rethrow;
    }
  
  }
}

class CountryStateRepository {
 
  Future<dynamic> getCountryListApi(
     ) async {
    var http = HttpService(
        isAuthorizeRequest: false,
      baseURL: AppUrl.countryStateBaseUrl,
        endURL: AppUrl.getCountryList,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
    );
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("getcountry List response ${response?.data}");
      return response?.data;
    } catch (error) {
      debugPrint('error.. $error');
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<GetStateNameModel> getStateListApi({
    required Map<String, dynamic> body,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.countryStateBaseUrl,
     
        endURL: AppUrl.getStateNameUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("getcountry List response ${response?.data}");
      var resp = GetStateNameModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error.. $error');
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

}
