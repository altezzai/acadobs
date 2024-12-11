import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/features/admin/student/model/exam_model.dart';
import 'package:school_app/features/admin/student/services/exam_services.dart';

class ExamController extends ChangeNotifier {
  // get achievements
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Exam> _exam = [];
  List<Exam> get exam => _exam;

  Future<void> getExamMarks({required int studentId}) async {
    _isloading = true;
    try {
      final response = await ExamServices().getExamMarks(studentId: studentId);
      log("***********${response.statusCode}");
      log("***********${response.data.toString()}");
      if (response.statusCode == 200) {
        log("Started");
        _exam.clear();
        log("One");

        // Check if data is a single object
        if (response.data is Map<String, dynamic>) {
          _exam.add(Exam.fromJson(response.data));
        } else if (response.data is List<dynamic>) {
          _exam = (response.data as List<dynamic>)
              .map((result) => Exam.fromJson(result))
              .toList();
        }

        log("Two");
        log("Achievement list***********${_exam.toString()}");
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }
}
