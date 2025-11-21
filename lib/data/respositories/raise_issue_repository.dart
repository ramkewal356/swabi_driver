
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/data/response/app_excaptions.dart';
import 'package:flutter_driver/data/models/get_issue_model.dart';
import 'package:flutter_driver/data/models/issue_detail_model.dart';
import 'package:flutter_driver/data/models/raise_issue_model.dart';
import 'package:flutter_driver/data/models/get_issue_by_booking_id_model.dart';

import 'package:flutter_driver/core/services/http_service.dart';

class RaiseissueRepository {
  Future<RaiseIssueModel?> requestRaiseIssueApi(
      {required BuildContext context,
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
      if (response?.statusCode != null &&
          response!.statusCode! >= 200 &&
          response.statusCode! < 300) {
        var resp = RaiseIssueModel.fromJson(response.data);
        return resp;
      } else {
        throw ApiException('Server returned an error: $response');
      }
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<GetIssueModel?> getRaiseIssueApi(
      {required BuildContext context,
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
      if (response?.statusCode != null &&
          response!.statusCode! >= 200 &&
          response.statusCode! < 300) {
        var resp = GetIssueModel.fromJson(response.data);
        return resp;
      } else {
        throw BadRequestException(
            'Server returned an error: ${response?.statusCode}');
      }
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<IssueDetailsModel?> getRaiseIssueDetailsApi(
      {required BuildContext context,
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
      if (response?.statusCode != null &&
          response!.statusCode! >= 200 &&
          response.statusCode! < 300) {
        var resp = IssueDetailsModel.fromJson(response.data);
        return resp;
      } else {
        throw BadRequestException(
            'Server returned an error: ${response?.statusCode}');
      }
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
  }

  Future<GetIssueByBookingIdModel?> getRaiseIssueByBookingIdApi(
      {required BuildContext context,
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
      if (response?.statusCode != null &&
          response!.statusCode! >= 200 &&
          response.statusCode! < 300) {
        var resp = GetIssueByBookingIdModel.fromJson(response.data);
        return resp;
      } else {
        throw ApiException('Server returned an error: ${response?.statusCode}');
      }
    } catch (error) {
      http.handleErrorResponse(error: error);
      rethrow;
    }
 
  }
}
