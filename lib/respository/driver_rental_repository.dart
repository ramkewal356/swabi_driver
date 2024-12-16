import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/app_url.dart';
import 'package:flutter_driver/data/network/base_apiservices.dart';
import 'package:flutter_driver/data/network/network_apiservice.dart';
import 'package:flutter_driver/model/driver_booking_model.dart';
import 'package:flutter_driver/view_model/services/http_service.dart';

///Driver Booking Details List View Repo
class DriverRentalBookingListRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverBookingListRepositoryApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getRentalBookingByDriverdUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("Driver Booking View List Repo api success ${response?.data}");

      // dynamic response = await _apiServices.getGetApiResponse(
      //     'http://swabi.ap-south-1.elasticbeanstalk.com/'
      //     'rental/get_rental_booking_by_driverId?driverId=${data["driverId"]}&pageNumber=${data["pageNumber"]}&pageSize=${data["pageSize"]}&bookingStatus=${data["bookingStatus"]}');
      // print("Driver Booking View List Repo api success");
      // print(response);
      var resp = DriverBookingModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver Booking View List api not successful error $e");
      http.handleErrorResponse(context: context, error: e);
      rethrow;
    }
  }
}

///Driver Booking Details Single View Repo
class DriverRentalBookingDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverBookingDetailsRepositoryApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getRentalBookingByIdUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint(
          "Driver Booking View Details Repo api success ${response?.data}");

      // dynamic response = await _apiServices
      //     .getGetApiResponse('http://swabi.ap-south-1.elasticbeanstalk.com/'
      //         'rental/get_rental_booking_by_id?id=${data["id"]}');
      // print(response);
      var resp = DriverGetBookingDetailsModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver Booking View Details api not successful error $e");
      http.handleErrorResponse(context: context, error: e);
      rethrow;
    }
  }
}

///Driver Booking Details Single View Repo
class DriverOnRunningRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverOnRunningRepositoryApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.changeBookingStatus,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("Driver On Running Ride Repo api success${response?.data}");
      // dynamic response = await _apiServices.getPutApiResponseWithData(
      //     'http://swabi.ap-south-1.elasticbeanstalk.com/'
      //     'rental/change_booking_status?id=${data["id"]}&bookingStatus=${data["bookingStatus"]}',
      //     data);

      print(response);
      var resp = DriverOnRunningModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver  On Running Ride api not successful error $e");
      http.handleErrorResponse(context: context, error: e);
      rethrow;
    }
  }
}

///Driver Booking Completed Repo
class DriverBookingCompletedRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverDriverBookingCompletedRepositoryApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.changeBookingStatus,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("Driver Booking Completed Repo${response?.data}");
      // dynamic response = await _apiServices.getPutApiResponseWithData(
      //     'http://swabi.ap-south-1.elasticbeanstalk.com/'
      //     'rental/change_booking_status?id=${data["id"]}&bookingStatus=${data["bookingStatus"]}',
      //     data);
      // print("Driver Booking Completed Repo");
      // print(response);
      var resp = DriverBookingCompletedModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver Booking Not Completed Repo $e");
      http.handleErrorResponse(context: context, error: e);
      rethrow;
    }
  }
}
