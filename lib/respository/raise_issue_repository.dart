import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/app_excaptions.dart';
import 'package:flutter_driver/data/app_url.dart';
import 'package:flutter_driver/model/get_issue_model.dart';
import 'package:flutter_driver/model/issue_detail_model.dart';
import 'package:flutter_driver/model/raise_issue_model.dart';
import 'package:flutter_driver/model/get_issue_by_booking_id_model.dart';

import 'package:flutter_driver/view_model/services/http_service.dart';

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
    } on DioException catch (dioError) {
      // throw FetchDataException(dioError.message);
      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException('Connection TimeOut');
      } else if (dioError.type == DioExceptionType.connectionError) {
        throw NetworkException('Internet Connection error');
      } else if (dioError.response != null) {
        throw ApiException(
            'Server responded with an error: ${dioError.response}');
      } else {
        throw UnknownException('Unknown error occurred');
      }
    } catch (e) {
      throw UnknownException('Unknown error occurred');
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
    } on SocketException catch (dioError) {
      throw FetchDataException(dioError.toString());
    } catch (e) {
      throw UnauthorisedException(e.toString());
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
    } on SocketException catch (dioError) {
      throw FetchDataException(dioError.toString());
    } catch (e) {
      throw UnauthorisedException(e.toString());
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
    } catch (dioError) {
      http.handleErrorResponse(context: context, error: dioError);
    }
    return null;
  }
}
