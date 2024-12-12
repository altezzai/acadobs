import 'dart:developer';
//import 'dart:io';

import 'package:flutter/widgets.dart';
//import 'package:go_router/go_router.dart';
//import 'package:school_app/base/routes/app_route_const.dart';
//import 'package:school_app/core/navbar/screen/bottom_nav.dart';

import 'package:school_app/features/admin/reports/model/student_report_model.dart';

import 'package:school_app/features/admin/reports/services/student_report_services.dart';

class StudentReportController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<StudentReport> _studentreports = [];
  List<StudentReport> get studentreports => _studentreports;
  List<StudentReport> _filteredstudentreports = [];
  List<StudentReport> get filteredstudentreports => _filteredstudentreports;

  Future<void> getStudentReports() async {
    _isloading = true;
    try {
      final response = await StudentReportServices().getStudentReport();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _studentreports.clear();
        _studentreports = (response.data as List<dynamic>)
            .map((result) => StudentReport.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Get StudentReports from class and division
  Future<void> getStudentReportsByClassAndDivision(
      {required String className, required String section}) async {
    _isloading = true;
    _filteredstudentreports.clear();
    try {
      final response = await StudentReportServices().getStudentReportByClassAndDivision(
          className: className, section: section);
      log("***********${response.statusCode}");
      if (response.statusCode == 200) {
        _filteredstudentreports.clear();
        _filteredstudentreports = (response.data as List<dynamic>)
            .map((result) => StudentReport.fromJson(result))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  void clearStudentReportList() {
    _filteredstudentreports.clear();
    notifyListeners();
  }

}
