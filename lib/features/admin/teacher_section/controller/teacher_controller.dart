import 'package:flutter/material.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
import 'package:school_app/features/admin/teacher_section/services/teacher_services.dart';

class TeacherController extends ChangeNotifier {
  List<Teacher> _teachers = [];
  List<Teacher> get teachers => _teachers;

  Future<void> getTeacherDetails() async {
    try {
      final response = await TeacherServices.get("/teachers");
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
}
