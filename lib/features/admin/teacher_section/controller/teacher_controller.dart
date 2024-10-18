import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
import 'package:school_app/features/admin/teacher_section/services/teacher_services.dart';

class TeacherController extends ChangeNotifier {
  List<Teacher> _teachers = [];
  List<Teacher> get teachers => _teachers;

  Future<void> getTeacherDetails() async {
    try {
      final response = await TeacherServices()
          .getTeacher("/teachers"); // Updated method call
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

    notifyListeners();
  }

  Future<void> addTeacher() async {
    try {
      // Use the formData you've already defined
      Response response =
          await TeacherServices().addTeacher("/teachers", formData);
      if (response.statusCode == 201) {
        print("Teacher added successfully: ${response.data}");
      } else {
        print("Failed to add teacher: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  FormData formData = FormData.fromMap({
    "name": "Soorya",
    "date_of_birth": "1980-05-15",
    "gender": "female",
    "address": "123 Elm Street, Springfield",
    "phone_number": "458734567368",
    "email": "soo@example.com",
  });
}
