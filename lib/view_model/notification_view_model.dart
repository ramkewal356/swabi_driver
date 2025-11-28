import 'package:flutter/material.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/get_all_notification_model.dart';
import 'package:flutter_driver/data/respositories/notification_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/response/api_response.dart';

class NotificationViewModel with ChangeNotifier {
  final _myRepo = NotificationRepository();
  int pageNumber = 0;
  int pageSize = 10;
  bool isLastPage = false;
  bool isLoadingMore = false;
  int totalUnreadNotification = 0;

  ApiResponse<List<Content>> notificationList = ApiResponse.initial();

  void setNotificationList(ApiResponse<List<Content>> response) {
    notificationList = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> updateNotification = ApiResponse.initial();

  void setOnUpdateNotification(ApiResponse<CommonModel> response) {
    updateNotification = response;
    notifyListeners();
  }

  ApiResponse<bool> clearNotification = ApiResponse.initial();

  void setOnClearNotification(ApiResponse<bool> response) {
    clearNotification = response;
    notifyListeners();
  }

  Future<void> updateNotificationApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {"receiverId": driverId};
    try {
      setOnUpdateNotification(ApiResponse.loading());
      var resp = await _myRepo.updateNotificationStatusApi(query: query);
      setOnUpdateNotification(ApiResponse.completed(resp));
    } catch (e) {
      debugPrint('error $e');
      setOnUpdateNotification(ApiResponse.error(e.toString()));
    }
  }

  Future<void> getAllNotificationList(
      {required bool isFilter,
      required bool isPagination,
      int? pageNumber1,
      int? pageSize1,
      required String readStatus}) async {
    if (isLoadingMore) return;
    if (!isPagination && isFilter) {
      pageNumber = 0;
      isLastPage = false;

      setNotificationList(ApiResponse.loading());
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {
      "receiverId": driverId,
      "readStatus": readStatus,
      'pageNumber': pageNumber1 ?? pageNumber,
      'pageSize': pageSize1 ?? pageSize,
      'receiverRole': 'DRIVER'
    };
    if (isLastPage) return;
    isLoadingMore = true;
    try {
      var resp = await _myRepo.getAllNotificationApi(query: query);
      List<Content> newData = resp.data?.content ?? [];
      List<Content> allData = (pageNumber == 0)
          ? newData
          : [...notificationList.data ?? [], ...newData];
      setNotificationList(ApiResponse.completed(allData));
      isLastPage = resp.data?.last ?? false;
      if (readStatus == 'FALSE') {
        totalUnreadNotification = resp.data?.totalElements ?? 0;
      }
      pageNumber++;
    } catch (e) {
      setNotificationList(ApiResponse.error(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> clearAllNotificationApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {
      "receiverId": driverId,
      "receiverRole": 'DRIVER'
    };
    try {
      setOnClearNotification(ApiResponse.loading());
      var resp = await _myRepo.clearAllNotificationApi(query: query);
      setOnClearNotification(ApiResponse.completed(resp));
    } catch (e) {
      debugPrint('error $e');
      setOnClearNotification(ApiResponse.error(e.toString()));
    }
  }
}
