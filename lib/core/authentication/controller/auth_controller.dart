import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/core/authentication/services/auth_services.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';

class AuthController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  //********************Login *********************
  Future<void> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    _isloading = true;
    notifyListeners();
    try {
      log("Start");
      final response =
          await AuthServices().login(email: email, password: password);
      log("Response ==== ${response.data.toString()}");
      if (response.statusCode == 200) {
        final result = response.data;
        await SecureStorageService.saveTokenAndUserData(result);
        final userType = await SecureStorageService.getUserType();
        log("User type from api===== ${response.data['user']["user_type"].toString()} ");
        log("User type from secure storage===== $userType ");
        if (userType == "student") {
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.parent);
        } else if (userType == "teacher") {
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.teacher);
        } else if (userType == "admin") {
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.admin);
        } else {
          log("Error ===No user type specified");
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // *****************Logout ***********************
  Future<void> logout({required BuildContext context}) async {
    _isloading = true;
    try {
      final response = await ApiServices.logout("/logout");
      if (response.statusCode == 200) {
        log("==============Logout Successfully================");
        await SecureStorageService.clearSecureStorage();
        context.goNamed(AppRouteConst.loginRouteName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
