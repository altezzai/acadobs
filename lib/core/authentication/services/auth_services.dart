import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class AuthServices {
  // Login
  Future<Response> login(
      {required String email, required String password}) async {
    final response = await ApiServices.post(
        "/login", {"email": email, "password": password});
    log(response.data.toString());
    return response;
  }

  Future<Response> getTeacherProfile({required int teacherId}) async {
    final Response response = await ApiServices.get('/teachers/$teacherId');
    return response;
  }
}
