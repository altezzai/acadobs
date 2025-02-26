import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/features/teacher/marks/models/teacher_added_marks.dart';
import 'package:school_app/features/teacher/marks/services/mark_services.dart';

class MarksController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  Future<void> addMarks({
    required BuildContext context,
    required String date,
    required String className,
    required String subject,
    required String section,
    required String title,
    required int totalMarks,
    required List<Map<String, dynamic>> students,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await MarkServices().addMarks(
        date: date,
        className: className,
        subject: subject,
        section: section,
        title: title,
        totalMarks: totalMarks,
        recordedBy: 1, // teacher id
        students: students,
      );
      if (response.statusCode == 201) {
        log("Marks uploaded successfully");
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // ******Get Teacher added marks*********
  List<TeacherAddedMarks> _teacheraddedmarks = [];
  List<TeacherAddedMarks> get teacheraddedmarks => _teacheraddedmarks;
  Future<void> getTeacherMarks() async {
    _isloading = true;
    notifyListeners(); // Ensures UI updates immediately to show the loader

    try {
      final teacherId = await SecureStorageService.getUserId();
      final response =
          await MarkServices().getTeacherMarks(teacherId: teacherId);

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _teacheraddedmarks = List.from(
          (response.data as List<dynamic>)
              .map((result) => TeacherAddedMarks.fromJson(result)),
        );
      } else {
        _teacheraddedmarks = []; // Ensure an empty list if response is invalid
      }
    } catch (e) {
      print("Error fetching marks: $e");
      _teacheraddedmarks = []; // Prevent stale data if an error occurs
    } finally {
      _isloading = false;
      notifyListeners(); // Ensures the UI updates after data is fetched
    }
  }
}
