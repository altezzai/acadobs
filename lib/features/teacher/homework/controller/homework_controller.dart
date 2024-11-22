import 'package:flutter/material.dart';
import 'package:school_app/features/teacher/homework/model/homework_model';
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
}
