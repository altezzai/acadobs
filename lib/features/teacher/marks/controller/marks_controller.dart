import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:school_app/features/teacher/marks/services/mark_services.dart';

class MarksController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
    bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  Future<void> addMarks(
      {required BuildContext context,
      required String date,
      required String className,
      required String subject,
      required String section,
      required String title,
      required int totalMarks,
      required List<Map<String, dynamic>> students}) async {
    _isloadingTwo = true;
    try {
      final response = await MarkServices().addMarks(
          date: date,
          className: className,
          subject: subject,
          section: section,
          title: title,
          totalMarks: totalMarks,
          recordedBy: 1, //teacher id
          students: students);
      if (response.statusCode == 201) {
        log("Marks uploaded succesfully");
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }
}
