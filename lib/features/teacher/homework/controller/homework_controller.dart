import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/loading_provider.dart';
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
    required String assignment_date,
    required String due_date,
    required String submission_type,
    required String total_marks,
    required String status,
    required List<int> studentsId,
  }) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      final response = await HomeworkServices().addHomework(context,
          class_grade: class_grade,
          section: section,
          subject: subject,
          assignment_title: assignment_title,
          description: description,
          assignment_date: assignment_date,
          due_date: due_date,
          submission_type: submission_type,
          total_marks: total_marks,
          status: status,
          studentsId: [1, 2]);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        context.goNamed(AppRouteConst.homeworkRouteName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loadingProvider.setLoading(false); // End loader
      notifyListeners();
    }
  }
}
