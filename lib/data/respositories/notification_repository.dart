import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/get_all_notification_model.dart';
import 'package:flutter_driver/core/services/http_service.dart';

class NotificationRepository {
  Future<CommonModel> updateNotificationStatusApi(
      {required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.updateNotificationStatusUrl,
        methodType: HttpMethodType.PATCH,
        bodyType: HttpBodyType.JSON,
        isAuthorizeRequest: false,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response ${response?.data}');
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<GetAllNotificationModel> getAllNotificationApi(
      {required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getAllNotificationUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        isAuthorizeRequest: false,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response ${response?.data}');
      var resp = GetAllNotificationModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<bool> clearAllNotificationApi(
      {required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.clearAllNotificationUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        isAuthorizeRequest: false,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('response ${response?.data}');

      if (response?.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }
}
