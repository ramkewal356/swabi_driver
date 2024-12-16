import 'package:flutter/material.dart';
import 'package:flutter_driver/model/get_all_notification_model.dart';
import 'package:flutter_driver/respository/notification_repository.dart';
import 'package:go_router/go_router.dart';

class NotificationViewModel with ChangeNotifier {
  final _myRepo = NotificationRepository();

  // GetAllNotificationModel? getAllNotificationModel;
  int? totalUnreadNotification;
  bool isLoading = false;
  Future<void> updateNotification({
    required BuildContext context,
    required String userId,
  }) async {
    Map<String, dynamic> query = {"receiverId": userId};
    try {
      await _myRepo
          .updateNotificationStatusApi(context: context, query: query)
          .then((onValue) {
        if (onValue?.status?.httpCode == '200') {
          context.push('/notification', extra: {'userId': userId});
          // updateNotificationStatus = onValue;
          // notifyListeners();
        }
      });
    } catch (e) {
      debugPrint('error $e');
    }
  }

  Future<GetAllNotificationModel?> getAllNotificationList(
      {required BuildContext context,
      required String userId,
      required int pageNumber,
      required int pageSize,
      required String readStatus}) async {
    Map<String, dynamic> query = {
      "receiverId": userId,
      "readStatus": readStatus,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'receiverRole': 'DRIVER'
    };
    try {
      isLoading = true;
      notifyListeners();
      if (readStatus == 'FALSE') {
        await _myRepo
            .getAllNotificationApi(context: context, query: query)
            .then((onValue) {
          if (onValue?.status?.httpCode == '200') {
            totalUnreadNotification = onValue?.data?.totalElements;
            notifyListeners();
          }
        });
      } else {
        var resp =
            await _myRepo.getAllNotificationApi(context: context, query: query);

        return resp;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('error $e');
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
