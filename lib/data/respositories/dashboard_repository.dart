import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/core/services/http_service.dart';
import 'package:flutter_driver/data/models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardModel?> getDashboardDataApi(
      {required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getDashboardUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("Get Dashboard Response  ${response?.data}");
      if (response?.data is Map<String, dynamic>) {
        // Already JSON decoded
        return DashboardModel.fromJson(response?.data as Map<String, dynamic>);
      } else if (response?.data is String) {
        final decoded = jsonDecode(response?.data as String);
        return DashboardModel.fromJson(decoded);
      } else {
        throw Exception("Unexpected response format: ${response?.data}");
      }
      // return DashboardModel.fromJson(response?.data);
    } catch (error) {
      debugPrint('error..$error');
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }
}
