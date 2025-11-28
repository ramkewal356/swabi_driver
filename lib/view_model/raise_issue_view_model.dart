import 'package:flutter/material.dart';
import 'package:flutter_driver/data/models/raise_issue_model.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/data/models/get_issue_model.dart';
import 'package:flutter_driver/data/models/issue_detail_model.dart';
import 'package:flutter_driver/data/models/get_issue_by_booking_id_model.dart';
import 'package:flutter_driver/data/models/user_model.dart';
import 'package:flutter_driver/data/respositories/raise_issue_repository.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';

class RaiseIssueViewModel with ChangeNotifier {
  final _myRepo = RaiseissueRepository();
  int pageNumber = 0;
  int pageSize = 10;
  bool isLastPage = false;
  bool isLoadingMore = false;

  ApiResponse<RaiseIssueModel> raiseRequestResonse = ApiResponse.initial();

  void setRaiseRequest(ApiResponse<RaiseIssueModel> response) {
    raiseRequestResonse = response;
    notifyListeners();
  }

  ApiResponse<List<Content>> raiseIssueList = ApiResponse.initial();

  void setRaiseDataList(ApiResponse<List<Content>> response) {
    raiseIssueList = response;

    notifyListeners();
  }

  ApiResponse<IssueDetailsModel> getIssueDetail = ApiResponse.initial();

  void setIssueDetails(ApiResponse<IssueDetailsModel> response) {
    getIssueDetail = response;

    notifyListeners();
  }

  ApiResponse<GetIssueByBookingIdModel> getIssueData = ApiResponse.initial();

  void setIssueDataByBokingId(ApiResponse<GetIssueByBookingIdModel> response) {
    getIssueData = response;

    notifyListeners();
  }

  Future<RaiseIssueModel?> requestRaiseIssue(
      {required BuildContext context,
      required String bookingId,
      required String bookingType,
      required String issueDescription,
      required String vendorId}) async {
    UserViewModel userViewModel = UserViewModel();
    UserModel? usermodel = await userViewModel.getUserId();
    Map<String, dynamic> body = {
      "bookingId": bookingId,
      "bookingType": bookingType,
      "raisedById": usermodel.userId,
      "raisedByRole": "DRIVER",
      "issueType": "Service Issue",
      "issueDescription": issueDescription,
      "vendor": {'vendorId': vendorId}
    };
    try {
      setRaiseRequest(ApiResponse.loading());
      var resp = await _myRepo.requestRaiseIssueApi(body: body);
      setRaiseRequest(ApiResponse.completed(resp));

      return resp;
    } catch (e) {
      setRaiseRequest(ApiResponse.error(e.toString()));
    }
    return null;
  }

  Future<void> getRaiseIssueApi({
    required bool isFilter,
    required bool isPagination,
    required String issueStatus,
  }) async {
    if (isLoadingMore) return;
    if (!isPagination && isFilter) {
      pageNumber = 0;
      isLastPage = false;

      setRaiseDataList(ApiResponse.loading());
    }
    UserViewModel userViewModel = UserViewModel();
    UserModel? usermodel = await userViewModel.getUserId();
    Map<String, dynamic> query = {
      "raisedById": usermodel.userId,
      "userType": "DRIVER",
      "search": "",
      "issueStatus": issueStatus,
      "pageNumber": pageNumber,
      "pageSize": pageSize
    };
    if (isLastPage) return;
    isLoadingMore = true;
    try {
      var resp = await _myRepo.getRaiseIssueApi(query: query);
      List<Content> newData = resp.data?.content ?? [];
      List<Content> allData = (pageNumber == 0)
          ? newData
          : [...raiseIssueList.data ?? [], ...newData];
      isLastPage = resp.data?.last ?? false;
      pageNumber++;
      setRaiseDataList(ApiResponse.completed(allData));
    } catch (e) {
      setRaiseDataList(ApiResponse.error(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> getRaiseIssueDetailsApi({
    required String issueId,
  }) async {
    Map<String, dynamic> query = {
      "issueId": issueId,
    };
    setIssueDetails(ApiResponse.loading());
    try {
      var resp = await _myRepo.getRaiseIssueDetailsApi(query: query);
      setIssueDetails(ApiResponse.completed(resp));
    } catch (e) {
      setIssueDetails(ApiResponse.error(e.toString()));
    }
  }

  Future<void> getIssueByBookingId(
      {required String bookingId, required String bookingType}) async {
    UserViewModel userViewModel = UserViewModel();
    UserModel? usermodel = await userViewModel.getUserId();
    Map<String, dynamic> query = {
      "bookingId": bookingId,
      "userId": usermodel.userId,
      "userType": "DRIVER",
      "bookingType": bookingType
    };
    try {
      setIssueDataByBokingId(ApiResponse.loading());

      var resp = await _myRepo.getRaiseIssueByBookingIdApi(query: query);
      setIssueDataByBokingId(ApiResponse.completed(resp));
    } catch (e) {
      setIssueDataByBokingId(ApiResponse.error(e.toString()));
    }
  }
}
