import 'package:flutter/material.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/data/response/errorHandler.dart';
import 'package:flutter_driver/model/get_issue_model.dart';
import 'package:flutter_driver/model/issue_detail_model.dart';
import 'package:flutter_driver/model/raise_issue_model.dart';
import 'package:flutter_driver/model/get_issue_by_booking_id_model.dart';
import 'package:flutter_driver/model/user_model.dart';
import 'package:flutter_driver/respository/raise_issue_repository.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';

import 'package:go_router/go_router.dart';

class RaiseissueViewModel with ChangeNotifier {
  final _myRepo = RaiseissueRepository();
  RaiseIssueModel? _raiseIssueModel;
  RaiseIssueModel? get raiseIssueModel => _raiseIssueModel;
  bool isloading = false;
  bool isloading1 = false;

  GetIssueModel? _getIssueModel;
  GetIssueModel? get getIssue => _getIssueModel;

  ApiResponse<IssueDetailsModel> issueDetail = ApiResponse.loading();

  setDataList(ApiResponse<IssueDetailsModel> response) {
    issueDetail = response;
    // isloading1 = false;
    notifyListeners();
  }

  ApiResponse<GetIssueByBookingIdModel> getissueDetail = ApiResponse.loading();

  setDataList1(ApiResponse<GetIssueByBookingIdModel> response) {
    getissueDetail = response;
    // isloading1 = false;
    notifyListeners();
  }

  Future<void> requestRaiseIssue(
      {required BuildContext context,
      required String bookingId,
      required String bookingType,
      required String issueDescription}) async {
    try {
      UserViewModel userViewModel = UserViewModel();
      UserModel? usermodel = await userViewModel.getUserId();
      Map<String, dynamic> body = {
        "bookingId": bookingId,
        "bookingType": bookingType,
        "raisedById": usermodel.userId,
        "raisedByRole": "DRIVER",
        "issueType": "Service Issue",
        "issueDescription": issueDescription
      };
      await _myRepo
          .requestRaiseIssueApi(context: context, body: body)
          .then((onValue) {
        _raiseIssueModel = onValue;
        notifyListeners();
        Utils.toastSuccessMessage('Raise requested Successfully');
        getIssueByBookingId(
            context: context,
            bookingId: bookingId,
            userId: usermodel.userId ?? '',
            bookingType: bookingType);
      }).onError((error, StackTrace) {
        // ErrorHandler().hanErrorResponse(errorResponse: error);
        ErrorHandler.handleError(error.toString());

        debugPrint('errror......${error.toString()}');
      });
    } catch (e) {
      // ErrorHandler.handleError(e);
    }
  }

  Future<GetIssueModel?> getRaiseIssue({
    required BuildContext context,
    required String issueStatus,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      isloading = true;
      notifyListeners();
      UserViewModel userViewModel = UserViewModel();
      UserModel? usermodel = await userViewModel.getUserId();
      Map<String, dynamic> query = {
        "raisedById": usermodel.userId,
        "userType": "DRIVER",
        "search": "",
        "issueStatus": issueStatus,
        "pageNumber": pageNumber.toString(),
        "pageSize": pageSize.toString()
      };
      GetIssueModel? issueModel =
          await _myRepo.getRaiseIssueApi(context: context, query: query);
      _getIssueModel = issueModel;
      notifyListeners();
      return issueModel;
    } catch (e) {
      ErrorHandler.handleError(e);
    } finally {
      isloading = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> getRaiseIssueDetails({
    required BuildContext context,
    required String issueId,
  }) async {
    try {
      isloading1 = true;
      notifyListeners();
      setDataList(ApiResponse.loading());
      Map<String, dynamic> query = {
        "issueId": issueId,
      };
      print('loder1223333$isloading1');
      await _myRepo
          .getRaiseIssueDetailsApi(context: context, query: query)
          .then((onValue) {
        if (onValue?.status?.httpCode == '200') {
          setDataList(ApiResponse.completed(onValue));
          context.push('/issueDetailsbyId');
          isloading1 = false;
          notifyListeners();
        }
      });
    } catch (e) {
      setDataList(ApiResponse.error(e.toString()));
      // ErrorHandler.handleError(e);
    } finally {
      isloading1 = false;
      notifyListeners();
    }
  }

  Future<void> getIssueByBookingId(
      {required BuildContext context,
      required String bookingId,
      required String userId,
      required String bookingType}) async {
    Map<String, dynamic> query = {
      "bookingId": bookingId,
      "userId": userId,
      "userType": "DRIVER",
      "bookingType": bookingType
    };
    try {
      setDataList1(ApiResponse.loading());

      await _myRepo
          .getRaiseIssueByBookingIdApi(context: context, query: query)
          .then((onValue) {
        if (onValue?.status?.httpCode == '200') {
          setDataList1(ApiResponse.completed(onValue));
        }
      });
    } catch (e) {
      setDataList1(ApiResponse.error(e.toString()));
    }
  }
}
