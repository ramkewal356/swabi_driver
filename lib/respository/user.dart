import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/app_url.dart';
import 'package:flutter_driver/view_model/services/http_service.dart';

import '../data/network/base_apiservices.dart';
import '../data/network/network_apiservice.dart';

class UserRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  //user registration
  Future<dynamic> loginApi(
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
      // dynamic response =
      //     await _apiServices.getPostWithoutApiResponse(AppUrl.login, data);
      // print("registration api success $data");
      return response?.data;
    } catch (e) {
      debugPrint("registration api not successful error $e");

      http.handleErrorResponse(context: context, error: e);
      rethrow;
    }
  }
}
