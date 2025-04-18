import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/core/authentication/model/login_model.dart';
import 'package:school_app/core/authentication/services/auth_services.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';

class AuthController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  LoginModel loginModel = LoginModel();
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
        final result = LoginModel.fromJson(response.data);
        loginModel = result;
        await SecureStorageService.saveTokenAndUserData(loginModel);
        log("Login data: ${loginModel.toString()}");
        final userType = await SecureStorageService.getUserType();
        log("User type from api===== ${response.data['user']["user_type"].toString()} ");
        log("User type from secure storage===== $userType ");
        if (userType == "student") {
          await getParentProfile();
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.parent);
        } else if (userType == "teacher") {
          await getTeacherProfile();
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.teacher);
        } else if (userType == "admin") {
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.admin);
        } else {
          log("Error ===No user type specified");
        }
      } else {
        final String error = response.data['error'];

        CustomSnackbar.show(
          context,
          message: error,
          type: SnackbarType.failure,
        );
      }
    } catch (e) {
      log(e.toString());
      CustomSnackbar.show(context,
          message: "Failed to Login.Please try again",
          type: SnackbarType.failure);
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
  // *****************Refresh Token*****************

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

  // get logged in teacher
  Future<void> getTeacherProfile() async {
    _isloading = true;
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response =
          await AuthServices().getTeacherProfile(teacherId: teacherId);
      if (response.statusCode == 200) {
        final result = response.data;
        await SecureStorageService.saveTeacherData(result);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // get logged in parent
  Future<void> getParentProfile() async {
    _isloading = true;
    try {
      final studentId = await SecureStorageService.getUserId();
      final response =
          await AuthServices().getParentProfile(studentId: studentId);
      if (response.statusCode == 200) {
        final result = response.data;
        await SecureStorageService.saveStudentData(result);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
