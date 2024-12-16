import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import '/data/app_excaptions.dart';

import 'base_apiservices.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future uploadImageHTTP(
    url,
    dynamic file,
  ) async {
    dynamic responseJson;
    try {
      var prefsToken = await SharedPreferences.getInstance();
      dynamic token = prefsToken.getString('token');
      debugPrint(token);
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
      };
      var request = http.MultipartRequest('PUT', Uri.parse(url))
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', file,
            contentType: MediaType("image", "jpg")));
      var response = await request.send();

      if (response.statusCode == 200) {
        responseJson = await response.stream.bytesToString();
      } else {
        throw UnauthorisedException(jsonEncode({"msg": "File upload error"}));
      }
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }
    return jsonDecode(responseJson);
  }

  @override
  Future<dynamic> uploadImageHTTP2(
    String url,
    dynamic file,
    String userId,
  ) async {
    dynamic responseJson;

    try {
      var prefsToken = await SharedPreferences.getInstance();
      dynamic token = prefsToken.getString('token');
      debugPrint(token);
      var formData = dio.FormData.fromMap({
        'userId': userId,
        'image': await dio.MultipartFile.fromFile(file,
            filename: 'image.jpg'), // Using MultipartFile from dio
      });

      var dioClient = dio.Dio();

      var response = await dioClient.put(
        url,
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type':
                'multipart/form-data; boundary=<calculated when request is sent>',
            'Content-Length': '<calculated when request is sent>',
            'Host': '<calculated when request is sent>',
            'User-Agent': 'PostmanRuntime/7.37.3',
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        responseJson = response.data;
      } else if (response.statusCode == 413) {
        debugPrint(response.statusCode.toString());
        throw BadRequestException(jsonEncode({'Request Entity Too Large'}));
      } else {
        debugPrint(response.statusCode.toString());
        throw UnauthorisedException(jsonEncode({"msg": "File upload error"}));
      }
    } on dio.DioError catch (e) {
      throw FetchDataException('API Connection Error: ${e.message}');
    }

    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async {
    var prefsToken = await SharedPreferences.getInstance();
    dynamic token = prefsToken.getString('token');
    print("token==$token");
    dynamic responseJson;
    try {
      if (kDebugMode) {
        print(url);
      }
      final response = await http.get(Uri.parse(url), headers: {
        "token": token,
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }
    return responseJson;
  }

  @override
  Future deleteApiResponse(String url) async {
    var prefsToken = await SharedPreferences.getInstance();
    dynamic token = prefsToken.getString('token');
    print("token==$token");
    dynamic responseJson;
    try {
      if (kDebugMode) {
        print(url);
      }
      final response = await http.delete(Uri.parse(url), headers: {
        "token": token,
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(
    String url,
    dynamic data,
  ) async {
    var prefsToken = await SharedPreferences.getInstance();
    dynamic token = prefsToken.getString('token');
    dynamic responseJson;
    try {
      if (kDebugMode) {
        print(url);
      }
      Map<String, String> headerData = {
        "Content-Type": "application/json",
        "token": token,
      };
      Response response = await post(
        Uri.parse(url),
        headers: headerData,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }

    return responseJson;
  }

  @override
  Future getPutApiResponseWithData(
    String url,
    dynamic data,
  ) async {
    var prefsToken = await SharedPreferences.getInstance();
    dynamic token = prefsToken.getString('token');
    dynamic responseJson;
    try {
      if (kDebugMode) {
        print("toekn is $token");
        print(url);
      }
      Map<String, String> headerData = {
        "Content-Type": "application/json",
        "token": token,
      };
      Response response = await put(
        Uri.parse(url),
        headers: headerData,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }

    return responseJson;
  }

  ///getPutApiResponse
  @override
  Future getPutApiResponse(String url) async {
    var prefsToken = await SharedPreferences.getInstance();
    dynamic token = prefsToken.getString('token');
    dynamic responseJson;
    try {
      if (kDebugMode) {
        print(url);
      }
      final response = await http.put(Uri.parse(url), headers: {
        "token": token,
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }
    return responseJson;
  }

  ///multi put function
  @override
  Future putSendMultiFormData(String url, Map<String, dynamic> data) async {
    var prefsToken = await SharedPreferences.getInstance();
    dynamic token = prefsToken.getString('token');
    dynamic responseJson;
    try {
      if (kDebugMode) {
        // print("token is $token");
        print(url);
      }
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.headers['token'] = token;

      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      final response = await http.put(Uri.parse(url), headers: {
        "token": token,
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }
    return responseJson;
  }

  //getstarted
  @override
  Future getPostWithoutApiResponse(
    String url,
    dynamic data,
  ) async {
    dynamic responseJson;
    try {
      Map<String, String> headerData = {
        "Content-Type": "application/json",
      };
      Response response = await post(
        Uri.parse(url),
        headers: headerData,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('API Connection Error');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        }
      case 400:
        throw BadRequestException(
            jsonDecode(response.body)['status']['message']);
      case 413:
        throw BadRequestException('Request Entity Too Large');
      case 500:
        throw BadRequestException(
            jsonDecode(response.body)['status']['message']);
      case 404:
        throw UnauthorisedException(
            jsonDecode(response.body)['status']['message']);
      case 401:
        throw InvalidPermissionException(
            jsonDecode(response.body)['status']['message']);
      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code ${response.statusCode}');
    }
  }
}
