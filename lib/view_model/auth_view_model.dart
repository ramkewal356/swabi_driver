// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_driver/data/models/common_model.dart';
import 'package:flutter_driver/data/models/login_model.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../data/respositories/auth_repository.dart';
import '../data/models/user_model.dart';
import '../core/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  late bool setupFinish = false;
  bool check = true;
  ApiResponse<LoginModel> loginResponse = ApiResponse.initial();
  void setOnLogin(ApiResponse<LoginModel> response) {
    loginResponse = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> sendOtpResponse = ApiResponse.initial();
  void setOnSendOtp(ApiResponse<CommonModel> response) {
    sendOtpResponse = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> verifyOtpResponse = ApiResponse.initial();
  void setOnVerifyOtp(ApiResponse<CommonModel> response) {
    verifyOtpResponse = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> resetPassResponse = ApiResponse.initial();
  void setOnResetPassword(ApiResponse<CommonModel> response) {
    resetPassResponse = response;
    notifyListeners();
  }

  ApiResponse<CommonModel> changePassResponse = ApiResponse.initial();
  void setOnChangePassword(ApiResponse<CommonModel> response) {
    changePassResponse = response;
    notifyListeners();
  }

  Future<void> loginApi(
      {required BuildContext context,
      required String email,
      required String password,
      required String notificationToken,
    required bool rememberMe,
    required String platformType,
  }) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
      'userType': "DRIVER",
      "notificationToken": notificationToken,
      "TokenType": platformType
    };

    try {
      setOnLogin(ApiResponse.loading());
      _myRepo.loginApi(context: context, body: data).then((value) {
        final userPreference = context.read<UserViewModel>();
        userPreference.saveToken(UserModel(token: value.data?.token));
        userPreference
            .saveUserId(UserModel(userId: value.data?.userId.toString()));
        rememberMe
            ? userPreference.saveRememberMe(email, password, rememberMe)
            : userPreference.clearRememberMe();

        Utils.toastSuccessMessage("Login Successfully");
        setOnLogin(ApiResponse.completed(value));
        context.go('/');
      }).onError((error, stackTrace) {
        setOnLogin(ApiResponse.error(error.toString()));
        FocusScope.of(context).unfocus();
        debugPrint(error.toString());
      });
    } catch (e) {
      setOnLogin(ApiResponse.error(e.toString()));
    }
  }

  Future<CommonModel?> sendOtp(
      {required BuildContext context, required String email}) async {
    Map<String, dynamic> query = {"email": email};
    setOnSendOtp(ApiResponse.loading());
    try {
      var resp = await _myRepo.sendOtpApi(context: context, query: query);
      if (resp?.status?.httpCode == '200') {
        Utils.toastSuccessMessage(resp?.data?.body ?? '');
        setOnSendOtp(ApiResponse.completed(resp));
      }

      return resp;
    } catch (e) {
      setOnSendOtp(ApiResponse.error(e.toString()));
      debugPrint('error$e');
    }
    return null;
  }

  Future<void> verifyOtp(
      {required BuildContext context,
      required String email,
      required String otp}) async {
    Map<String, dynamic> query = {"email": email, "otp": otp};
    setOnVerifyOtp(ApiResponse.loading());
    try {
      await _myRepo.verifyOtpApi(context: context, query: query).then((resp) {
        if (resp?.status?.httpCode == '200') {
          Utils.toastSuccessMessage(resp?.data?.body ?? '');
          setOnVerifyOtp(ApiResponse.completed(resp));
          context.push('/resetPassword', extra: {"email": email});
        }
      });
    } catch (e) {
      setOnVerifyOtp(ApiResponse.error(e.toString()));
      debugPrint('error$e');
    }
  }

  Future<void> resetPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    Map<String, dynamic> query = {"email": email, "password": password};
    try {
      setOnResetPassword(ApiResponse.loading());
      var resp = await _myRepo.resetPasswordApi(context: context, query: query);
      if (resp?.status?.httpCode == '200') {
        Utils.toastSuccessMessage(resp?.data?.body ?? '');
        setOnResetPassword(ApiResponse.completed(resp));
        context.push('/login');
      }
    } catch (e) {
      setOnResetPassword(ApiResponse.error(e.toString()));
      debugPrint('error$e');
    }
  }

  Future<CommonModel?> changePasswordViewModelApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    try {
      setOnChangePassword(ApiResponse.loading());

      await _myRepo
          .changePasswordApi(context: context, query: query)
          .then((value) {
        setOnChangePassword(ApiResponse.completed(value));
        Utils.toastSuccessMessage("Password changed successfully");
        context.pop();
      });
    } catch (e) {
      debugPrint('error $e');
      setOnChangePassword(ApiResponse.error(e.toString()));
    }
    return null;
  }
}
