// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';

class SplashServices {
  UserViewModel userViewModel = UserViewModel();

  void login(BuildContext context) async {
    var resp = await userViewModel.getUser();
    if (resp.token == null || (resp.token ?? '').isEmpty) {
      context.push('/login');
    } else {
      context.push('/');
    }
   
  }
}
