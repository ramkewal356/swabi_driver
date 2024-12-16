
import 'package:flutter/material.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../respository/user.dart';
import '/model/user_model.dart';
import '/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = UserRepository();
  late bool setupFinish = false;

  bool check = true;
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  
  Future<void> loginApi(
      {required BuildContext context,
      required String email,
      required String password,
      required String notificationToken,
      required bool rememberMe}) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
      'notificationToken': notificationToken,
      'userType': 'DRIVER'
    };
    setLoading(true);
    {
      _myRepo.loginApi(context: context, body: data).then((value) async {
        

        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        debugPrint("save token $value");

        debugPrint(value['data']['userId'].toString());
        String userID = value['data']['userId'].toString();
        String token1 = value['data']['token'].toString();
        userPreference.saveToken(UserModel(token: token1));
        userPreference.saveUserId(UserModel(userId: userID));
        rememberMe
            ? userPreference.saveRememberMe(email, password, rememberMe)
            : userPreference.clearRememberMe();
        debugPrint('userId: $userID');
        debugPrint('token: ${token1.toString()}');
        Utils.toastSuccessMessage("Login Successfully");
        context.go('/');
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
        // Utils.toastMessage(error.toString());
        FocusScope.of(context).unfocus();
        debugPrint(error.toString());
        
      });
    }
  }
}
