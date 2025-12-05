import 'package:flutter/material.dart';
import 'package:flutter_driver/data/models/dashboard_model.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/data/respositories/dashboard_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardViewModel with ChangeNotifier {
  final _myRepo = DashboardRepository();
  ApiResponse<DashboardModel> dashboardData = ApiResponse.initial();
  void setOnDashboardData(ApiResponse<DashboardModel> response) {
    dashboardData = response;
    notifyListeners();
  }

  Future<void> getDashboardDataApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var driverId = pref.getString('userId');
    Map<String, dynamic> query = {"driverId": driverId};
    try {
      setOnDashboardData(ApiResponse.loading());
      //call api
      var resp = await _myRepo.getDashboardDataApi(query: query);
      setOnDashboardData(ApiResponse.completed(resp));
    } catch (e) {
      setOnDashboardData(ApiResponse.error(e.toString()));
    }
  }
}
