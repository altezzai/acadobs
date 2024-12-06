import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/features/teacher/homework/model/homework_model.dart';
import 'package:school_app/features/teacher/homework/services/homework_service.dart';

class HomeworkController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Homework> _homework = [];
  List<Homework> get homework => _homework;

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

  // add homework
  Future<void> addHomework(
    BuildContext context, {
    required String class_grade,
    required String section,
    required String subject,
    required String assignment_title,
    required String description,
    required String assigned_date,
    required String due_date,
    required String submission_type,
    required total_marks,
    required String status,
    required List<int> studentsId,
  }) async {
    try {
      final teacherId = await SecureStorageService.getUserId();
      log("${teacherId.toString}");
      final response = await HomeworkServices().addHomework(context,
          teacherId: teacherId,
          class_grade: class_grade,
          section: section,
          subject: subject,
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
        context.pushNamed(AppRouteConst.homeworkRouteName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
