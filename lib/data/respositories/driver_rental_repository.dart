import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/core/constants/app_url.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/core/services/http_service.dart';
import 'package:flutter_driver/data/models/get_rental_booking_by_id_model.dart';
import 'package:flutter_driver/data/models/rental_booking_model.dart';

///Driver Booking Details List View Repo
class DriverRentalBookingRepository {
  Future<RentalBookingModel> driverBookingListRepositoryApi(
      {
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
      var resp = RentalBookingModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver Booking View List api not successful error $e");
  
      http.handleErrorResponse(error: e);
      rethrow;
    }
  }
  Future<GetRentalBookingByIdModel> driverBookingDetailsRepositoryApi(
      {
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
      var resp = GetRentalBookingByIdModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("Driver Booking View Details api not successful error $e");
    
      http.handleErrorResponse(error: e);
      rethrow;
    }
  }
  Future<CommonModel> bookingStartAndCompleteApi(
      {
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
      debugPrint(
          "booking start and complete Ride Repo api success${response?.data}");
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (e) {
      debugPrint("booking start and complete Ride api not successful error $e");

      http.handleErrorResponse(error: e);
      rethrow;
    }
  }
}


