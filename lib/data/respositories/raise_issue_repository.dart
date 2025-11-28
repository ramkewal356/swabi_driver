
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/data/models/get_issue_model.dart';
import 'package:flutter_driver/data/models/issue_detail_model.dart';
import 'package:flutter_driver/data/models/raise_issue_model.dart';
import 'package:flutter_driver/data/models/get_issue_by_booking_id_model.dart';

import 'package:flutter_driver/core/services/http_service.dart';

class RaiseissueRepository {
  Future<RaiseIssueModel> requestRaiseIssueApi(
      {
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.raiseIssueUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('respone of raise issue request${response?.data}');
      return RaiseIssueModel.fromJson(response?.data);
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<GetIssueModel> getRaiseIssueApi(
      {
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getIssueUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('respone of get raise issue${response?.data}');
      return GetIssueModel.fromJson(response?.data);
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<IssueDetailsModel> getRaiseIssueDetailsApi(
      {
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getIssueDetailsUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('respone of get raise issue${response?.data}');
      return IssueDetailsModel.fromJson(response?.data);
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<GetIssueByBookingIdModel?> getRaiseIssueByBookingIdApi(
      {
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getIsseBybooking,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('respone of get raise issue${response?.data}');
      return GetIssueByBookingIdModel.fromJson(response?.data);
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
 
  }
}
