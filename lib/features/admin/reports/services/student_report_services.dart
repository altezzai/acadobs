import 'package:dio/dio.dart';
//import 'package:flutter/widgets.dart';
//import 'package:provider/provider.dart';
import 'package:school_app/base/services/api_services.dart';
//import 'package:school_app/core/controller/file_picker_provider.dart';

class StudentReportServices {
  // Get student reports
  Future<Response> getStudentReport() async {
    final Response response = await ApiServices.get("/studentReport");
    return response;
  }

  // Get student reports from class and division
  Future<Response> getStudentReportByClassAndDivision({required String className, required String section}) async {
    final Response response = await ApiServices.get("/studentReport/?class=$className&section=$section");
    return response;
  }

  



}
