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

  // Fetch student details (GET request)
  Future<void> getStudentDetails() async {
    _isloading = true;
    try {
      final response = await StudentServices().getStudent();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
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
  // Add student details (POST request)
  // Future<void> addStudent(Student student) async {
  //   try {
  //     FormData formData = FormData.fromMap({
  //       "full_name": student.fullName,
  //       "date_of_birth": student.dateOfBirth,
  //       "gender": student.gender,
  //       "class": student.studentDatumClass,
  //       "section": student.section,
  //       "roll_number": student.rollNumber,
  //       "admission_number": student.admissionNumber,
  //       "aadhaar_number": student.aadhaarNumber,
  //       "residential_address": student.residentialAddress,
  //       "contact_number": student.contactNumber,
  //       "email": student.email,
  //       "father_full_name": student.fatherFullName,
  //       "mother_full_name": student.motherFullName,
  //       "blood_group": student.bloodGroup,
  //       // Add other fields as needed
  //     });

  //     // Sending the POST request to add a student
  //     final response = await SampleServices().addStudent("/students", formData);

  //     // Check if the request was successful
  //     if (response.statusCode == 201) {
  //       print("Student added successfully: ${response.data}");
  //       // Optionally refresh the student list after adding a new student
  //       await getStudentDetails();
  //     } else {
  //       print("Failed to add student: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error adding student: $e");
  //   }
  // }
}
