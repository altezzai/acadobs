import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
import 'package:school_app/features/admin/teacher_section/services/teacher_services.dart';

class TeacherController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Teacher> _teachers = [];
  List<Teacher> get teachers => _teachers;

  Future<void> getTeacherDetails() async {
    _isloading = true;
    try {
      final response =
          await TeacherServices().getTeacher(); // Updated method call
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _teachers = (response.data as List<dynamic>)
            .map((result) => Teacher.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Future<void> addTeacher() async {
  //   try {
  //     // Use the formData you've already defined
  //     Response response =
  //         await TeacherServices().addTeacher("/teachers", formData);
  //     if (response.statusCode == 201) {
  //       print("Teacher added successfully: ${response.data}");
  //     } else {
  //       print("Failed to add teacher: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // FormData formData = FormData.fromMap({
  //   "name": "Soorya",
  //   "date_of_birth": "1980-05-15",
  //   "gender": "female",
  //   "address": "123 Elm Street, Springfield",
  //   "phone_number": "458734567368",
  //   "email": "soo@example.com",
  // });

  // ********Add New Teacher************
  Future<void> addNewTeacher(BuildContext context,
      {required String fullName,
      required String dateOfBirth,
      required String gender,
      required String address,
      required String contactNumber,
      required String emailAddress}) async {
    _isloading = true;
    try {
      final response = await TeacherServices().addNewTeacher(
          fullName: fullName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          address: address,
          contactNumber: contactNumber,
          emailAddress: emailAddress);
      if (response.statusCode == 201) {
        log(">>>>>>>>>>>>>Teacher Added}");
        context.goNamed(AppRouteConst.AdminteacherRouteName);
      }
    } catch (e) {
      log(e.toString());
    }
    _isloading = false;
    notifyListeners();
  }
}
