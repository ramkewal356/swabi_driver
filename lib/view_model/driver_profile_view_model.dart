// Rental Booking View Model
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/driver_profile_model.dart';
import 'package:flutter_driver/data/respositories/driver_profile_repository.dart';
import 'package:flutter_driver/core/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverProfileViewModel with ChangeNotifier {
  final _myRepo = DriverProfileRepository();
  ApiResponse<DriverProfileModel> DataList = ApiResponse.initial();

  setDataList(ApiResponse<DriverProfileModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchDriverProfileViewModelApi(
      BuildContext context, data, String uid) async {
    debugPrint("${data}sfsdfsdf");
    setDataList(ApiResponse.loading());
    _myRepo
        .driverBookingListRepositoryApi(context: context, query: data)
        .then((value) async {
      setDataList(ApiResponse.completed(value));
      debugPrint('Driver Profile Api Success');
      context.push("/profilePage", extra: {"userId": uid});
      // Utils.toastMessage("Data fetching");
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Driver Profile Api Failed');
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchDriverDetailViewModelApi(
      BuildContext context, data, String uid) async {
    debugPrint("${data}sfsdfsdf");
    setDataList(ApiResponse.loading());
    _myRepo
        .driverBookingListRepositoryApi(context: context, query: data)
        .then((value) async {
      setDataList(ApiResponse.completed(value));
      debugPrint('Driver Profile Api Success');
      // context.push("/profilePage", extra: {"userId": uid});
      // Utils.toastMessage("Data fetching");
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Driver Profile Api Failed');
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

///Driver Profile Update View Model
class DriverProfileUpdateViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();
  ApiResponse<DriverProfileUpdateModel> updateProfile = ApiResponse.loading();
  bool isLoading = false;
  setDataList(ApiResponse<DriverProfileUpdateModel> response) {
    updateProfile = response;
    notifyListeners();
  }

  Future editProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String country,
    required String state,
    required String location,
    required String gender,
  }) async {
    SharedPreferences srp = await SharedPreferences.getInstance();
    var driverId = srp.getString('userId');

    Map<String, dynamic> driverRequest = {
      "driverId": driverId,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "country": country,
      "state": state,
      "driverAddress": location,
    };
    final body = {
      "driverRequest": jsonEncode(driverRequest)
      // "image": profilePic
    };
    try {
      setDataList(ApiResponse.loading());
      isLoading = true;
      notifyListeners();
      await _myRepo.editProfile(context: context, body: body).then((value) {
        setDataList(ApiResponse.completed(value));
        Provider.of<DriverProfileViewModel>(context, listen: false)
            .fetchDriverDetailViewModelApi(
                context, {"driverId": driverId}, driverId ?? '');
        debugPrint('Updated successfull');
        context.pop(context);
        Utils.toastSuccessMessage("Profile Updated Successfully");
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('error$e');
      setDataList(ApiResponse.error(e.toString()));
      isLoading = false;
      notifyListeners();
    }
  }
}

class UploadProfilePicViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();

  bool isLoading = false;
  Future<CommonModel?> uploadProfilePic(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    try {
      isLoading = true;
      notifyListeners();
      var resp =
          await _myRepo.uploadProfilePicApi(context: context, body: body);
      if (resp?.status?.httpCode == '200') {
        Utils.toastSuccessMessage(resp?.data?.body ?? '');
        // context.push('/login');
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint('error$e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}

class GetCountryStateListViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();
  List<dynamic> getCountryListModel = [];
  List<String>? getStateListModel = [];
  bool isLoading = false;
  Future<dynamic> getAccessToken({
    required BuildContext context,
  }) async {
    Map<String, String> headers = {
      'api-token':
          'ky36oc3IK7cBvBSMi9wkMQsvyf2kLTHLg83JuA8pYL5tLotwdV_401qVFkMHMunj8nM',
      'user-email': 'saurabhm@shilshatech.com',
    };
    try {
      var resp =
          await _myRepo.getAccessTokentApi(context: context, header: headers);
      return resp;
    } catch (e) {
      debugPrint('error$e');
    }
    return null;
  }

  Future<dynamic> getCountryList({
    required BuildContext context,
    required String token,
  }) async {
    Map<String, String> header = {
      "Authorization": 'Bearer $token',
    };
    try {
      _myRepo
          .getCountryListApi(context: context, header: header)
          .then((onValue) {
        getCountryListModel = onValue;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('error$e');
    }
    return null;
  }

  Future<dynamic> getStateList({
    required BuildContext context,
    // required String token,
    required String country,
  }) async {
    Map<String, dynamic> body = {
      "country": country,
    };
    try {
      isLoading = true;
      notifyListeners();
      _myRepo.getStateListApi(context: context, body: body).then((onValue) {
        if (onValue.data != null) {
          // Filter the data to get the country-specific states
          var countryData = onValue.data?.firstWhere(
            (item) => item.name == country,
            // orElse: () => null,
          );

          if (countryData != null) {
            var states = countryData.states;
            getStateListModel = states
                ?.map((state) => state.name
                    ?.replaceFirst(RegExp(r' Emirate$'), '') as String)
                .toList();
            debugPrint('vcnbxcnbxcn,,,,,,,,....???????? $getStateListModel');
          } else {
            // If country is not found in the data, handle accordingly
            getStateListModel = [];
          }

          isLoading = false;
          notifyListeners(); // Notify listeners after update
        } else {
          // Handle case when the response is null
          isLoading = false;
          notifyListeners();
        }
      });
    } catch (e) {
      debugPrint('error$e');
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
