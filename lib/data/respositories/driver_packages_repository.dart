import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/core/services/http_service.dart';
import 'package:flutter_driver/data/models/get_package_details_model.dart';
import 'package:flutter_driver/data/models/package_history_model.dart';
import 'package:flutter_driver/data/models/upcoming_package_booking_model.dart';

class DriverpackageserviceRepository {
  Future<UpcomingPackagebookingModel> getPackageUpcommingListApi({
    required Map<String, dynamic> query,

  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverBookingListUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response..packageBooking list ${response?.data}');

      var resp = UpcomingPackagebookingModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error..$error');
      http.handleErrorResponse(
        error: error,
      );
      rethrow;
    }
  }

  Future<GetPackageDetailsModel> getPackageDetailListApi({
    required Map<String, dynamic> query,
  
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverBookingDetailListUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response..packageBooking list ${response?.data}');

      var resp = GetPackageDetailsModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error..$error');
      http.handleErrorResponse(
        error: error,
      );
      rethrow;
    }
  }

  Future<CommonModel?> startActivityApi({
    required Map<String, dynamic> query,
  
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverActivityStartUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);

    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response..packageBooking list ${response?.data}');

      var resp = CommonModel.fromJson(response?.data ?? {});
      return resp;
    } catch (error) {
      debugPrint('error..$error');
      http.handleErrorResponse(
        error: error,
      );
      rethrow;
    }
  }

  Future<CommonModel?> completeActivityApi({
    required Map<String, dynamic> query,
  
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverActivityCompleteUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response..packageBooking list ${response?.data}');

      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error..$error');

      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<PackageHistoryModel> getPackageHistoryListApi({
    required Map<String, dynamic> query,
  
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverPackageHistoryUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response..packageBooking list ${response?.data}');

      var resp = PackageHistoryModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      debugPrint('error..$error');

      http.handleErrorResponse(error: error);
      rethrow;
    }
  }
}
