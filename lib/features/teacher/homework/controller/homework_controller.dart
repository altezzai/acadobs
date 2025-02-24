import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/loading_dialog.dart';
import 'package:school_app/features/teacher/homework/model/homework_model.dart';
import 'package:school_app/features/teacher/homework/services/homework_service.dart';

class HomeworkController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  List<Homework> _homework = [];
  List<Homework> get homework => _homework;

  List<Homework> _teacherHomework = [];
  List<Homework> get teacherHomework => _teacherHomework;

// ************** get all homework*************
  Future<void> getHomework() async {
    _isloading = true;
    try {
      final response = await HomeworkServices().getHomework();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _homework = (response.data as List<dynamic>)
            .map((result) => Homework.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

// ************** get all homework*************
  Future<void> getHomeworkByTeacherId() async {
    _isloading = true;
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await HomeworkServices()
          .getHomeworkByTeacherId(teacherId: teacherId.toString());
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _teacherHomework.clear();
        _teacherHomework = (response.data['homework'] as List<dynamic>)
            .map((result) => Homework.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // add homework
  Future<void> addHomework(
    BuildContext context, {
    required String class_grade,
    required String section,
    required int subjectId,
    required String assignment_title,
    required String description,
    required String assigned_date,
    required String due_date,
    required String submission_type,
    required total_marks,
    required String status,
    required List<int> studentsId,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final teacherId = await SecureStorageService.getUserId();
      log("${teacherId.toString}");
      final response = await HomeworkServices().addHomework(context,
          teacherId: teacherId,
          class_grade: class_grade,
          section: section,
          subjectId: subjectId,
          assignment_title: assignment_title,
          description: description,
          assigned_date: assigned_date,
          due_date: due_date,
          submission_type: submission_type,
          total_marks: total_marks,
          status: status,
          studentsId: studentsId);
      log("Response++++=${response.data.toString()}");
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        await getHomeworkByTeacherId();
        CustomSnackbar.show(context,
            message: "Homework Added Successfully", type: SnackbarType.success);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // add homework
  Future<void> editHomework(
    BuildContext context, {
    required int homeworkId,
    required String class_grade,
    required String section,
    required int subjectId,
    required String assignment_title,
    required String description,
    required String assigned_date,
    required String due_date,
    required String submission_type,
    required total_marks,
    required String status,
    required List<int> studentsId,
  }) async {
    _isloadingTwo = true;
    try {
      final teacherId = await SecureStorageService.getUserId();
      log("${teacherId.toString}");
      final response = await HomeworkServices().editHomework(context,
          homeworkId: homeworkId,
          teacherId: teacherId,
          class_grade: class_grade,
          section: section,
          subjectId: subjectId,
          assignment_title: assignment_title,
          description: description,
          assigned_date: assigned_date,
          due_date: due_date,
          submission_type: submission_type,
          total_marks: total_marks,
          status: status,
          studentsId: studentsId);
      log("Response++++=${response.data.toString()}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");
        await getHomeworkByTeacherId();
        CustomSnackbar.show(context,
            message: "Homework Edited Successfully",
            type: SnackbarType.success);

        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // Delete Homework
  Future<void> deleteHomework(
      {required BuildContext context, required int homeworkId}) async {
    _isloading = true;
    notifyListeners();
    // Show loading dialog
    LoadingDialog.show(context, message: "Deleting homework...");
    try {
      final response =
          await HomeworkServices().deleteHomework(homeworkId: homeworkId);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");
        await getHomeworkByTeacherId();
        CustomSnackbar.show(context,
            message: "Homework Deleted Successfully", type: SnackbarType.info);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
      LoadingDialog.hide(context);
    }
  }
}
