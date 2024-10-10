import 'package:flutter/material.dart';
import 'package:school_app/sample/model/student_data.dart';
import 'package:school_app/services/api_service.dart';

class SampleController extends ChangeNotifier {
  List<StudentData> _studentData = [];
  List<StudentData> get studentData => _studentData;

  Future<void> getStudentDetails() async {
    try {
      final response = await SampleServices.get("/students");
      if (response.statusCode == 200) {
        _studentData = (response.data as List<dynamic>)
            .map((result) => StudentData.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
