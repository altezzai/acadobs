import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/features/teacher/parent/services/note_services.dart';

class NotesController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  // ******Add notes to parents********
  Future<void> addParentNote({
    required BuildContext context,
    required int studentId,
    required String title,
    required String description,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await NoteServices().addNotes(
          studentId: studentId,
          teacherId: teacherId,
          title: title,
          description: description);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Note Added Successfully");
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
