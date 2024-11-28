// import 'dart:developer';
// import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/services/studentservice.dart';

class StudentController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  
  List<Student> _students = [];
  List<Student> get students => _students;
  List<Student> _filteredstudents = [];
  List<Student> get filteredstudents => _filteredstudents;

  List<Student> _parents = [];
  List<Student> get parents => _parents;
  List<Student> _filteredparents = [];
  List<Student> get filteredparents => _filteredparents;

  // Fetch student details (GET request)
  Future<void> getStudentDetails() async {
    _isloading = true;
    try {
      final response = await StudentServices().getStudent();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _students.clear();
        _students = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // ********Add New Student************
  Future<void> addNewStudent(
    BuildContext context, {
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String studentClass,
    required String section,
    required String rollNumber,
    required String admissionNumber,
    required String aadhaarNumber,
    required String residentialAddress,
    required String contactNumber,
    required String email,
    required String fatherFullName,
    required String motherFullName,
    required String bloodGroup,
  }) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      final response = await StudentServices().addNewStudent(
          fullName: fullName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          studentClass: studentClass,
          section: section,
          rollNumber: rollNumber,
          admissionNumber: admissionNumber,
          aadhaarNumber: aadhaarNumber,
          residentialAddress: residentialAddress,
          contactNumber: contactNumber,
          email: email,
          fatherFullName: fatherFullName,
          motherFullName: motherFullName,
          bloodGroup: bloodGroup);
      if (response.statusCode == 201) {
        log(">>>>>>>>>>>>>Student Added}");
        context.goNamed(AppRouteConst.AdminstudentRouteName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loadingProvider.setLoading(false); // End loader
      notifyListeners();
    }
  }

  // Fetch student class and division details (GET request)
  Future<void> getStudentsClassAndDivision(
      {required String classname, required String section}) async {
    _isloading = true;
    try {
      final response = await StudentServices().getStudentsClassAndDivision(
        classname: classname,
        section: section,
      );
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _filteredstudents.clear();
        _filteredstudents = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Fetch Parent details (GET request)
  Future<void> getParentDetails() async {
    _isloading = true;
    try {
      final response = await StudentServices().getParent();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _parents.clear();
        _parents = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Fetch parent class and division details (GET request)
  Future<void> getParentByClassAndDivision(
      {required String classname, required String section}) async {
    _isloading = true;
    try {
      final response = await StudentServices().getParentByClassAndDivision(
        classname: classname,
        section: section,
      );
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _filteredparents.clear();
        _filteredparents = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }
}
