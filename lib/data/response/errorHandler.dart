import 'package:flutter/material.dart';
import 'package:flutter_driver/data/app_excaptions.dart';
import 'package:flutter_driver/data/response/baseResponse.dart';
import 'package:flutter_driver/data/string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorHandler {
  int? responseStatusCode;
  static void handleError(e) {
    if (e is NetworkException) {
      // Handle network issues
      debugPrint("Network error: ${e.message}");
    } else if (e is ApiException) {
      // Handle API errors
      debugPrint("API error: ${e.message}");
    } else if (e is TimeoutException) {
      // Handle timeouts
      debugPrint("Timeout error: ${e.message}");
    } else {
      // Handle unknown or general errors
      debugPrint("Unknown error: ${e.toString()}");
    }
  }

  void hanErrorResponse({
    BuildContext? context,
    dynamic error,
    BaseResponseModel? errorResponse,
    bool tryParse = true,
    Function? postHandleError,
    bool isLogin = false,
  }) {
    String? message;
    // if (error != null && tryParse) {
    //   try {
    //     print({"error.response?.data": error.response?.data});
    //     message =
    //         '${error.response?.data["message"] ?? error.response?.data["errors"][0]["msg"]}';
    //   } catch (error) {
    //     message = null;
    //   }
    // }
    message = errorResponse?.status?.message;
    responseStatusCode = int.parse(errorResponse?.status?.httpCode ?? '');
    switch (this.responseStatusCode) {
      case 200:
        // Fluttertoast.showToast(msg: kStringSomethingWentWrong);
        return;
      case 301:
        // bad request
        // print({"error 400": error.response.data["message"]});
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        } else {
          Fluttertoast.showToast(msg: kStringBadRequest);
        }
        break;
      case 400:
        // bad request
        // print({"error 400": error.response.data["message"]});
        if (message != null) {
          Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
          break;
        } else {
          Fluttertoast.showToast(msg: kStringBadRequest);
        }
        break;
      case 401:
        // unauthorize
        if (!isLogin) {
          Fluttertoast.showToast(msg: message ?? kStringSessionTimeout);
          // _auth.unauthenticateUser(context!);
          return;
        } else {
          Fluttertoast.showToast(msg: kStringInvalidCredentials);
        }
        break;
      case 404:
        // Forbidden
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        }
        Fluttertoast.showToast(msg: kStringForbidden);
        break;
      case 500:
        // internal server error
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        }
        Fluttertoast.showToast(msg: kStringServerError);
        break;
      default:
        if (message != null) {
          Fluttertoast.showToast(msg: message);
          break;
        }
        Fluttertoast.showToast(msg: kStringSomethingWentWrong);
        break;
    }
    if (postHandleError != null) {
      postHandleError();
    }
  }
}
