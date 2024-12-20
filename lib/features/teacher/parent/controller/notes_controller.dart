import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_model.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_student_model.dart';
import 'package:school_app/features/teacher/parent/services/note_services.dart';

class NotesController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;

  // *********Add notes to Students/Parents********
  Future<void> addParentNote({
    required BuildContext context,
    required List<int> studentIds,
    required String title,
    required String description,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await NoteServices().addNotes(
          studentId: studentIds,
          teacherId: teacherId,
          title: title,
          description: description);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Note Added Successfully");
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // **********Get Notes by Note Id************
  ParentNote? _parentNote;
  ParentNote? get parentNote => _parentNote;
  Future<void> getNotesByNoteId({required int noteId}) async {
    _isloading = true;
    notifyListeners(); // Notify the UI about the loading state
    try {
      // final teacherId = await SecureStorageService.getUserId();
      final response = await NoteServices().getNoteById(noteId: noteId);
      final responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        // If the response is a single object.
        _parentNote = ParentNote.fromJson(responseData);
      } else {
        log('Failed to fetch notes: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching notes: $e');
    } finally {
      _isloading = false;
      notifyListeners(); // Notify the UI about the updated state
    }
  }

  // **********Get Notes by TeacherId************
  List<Map<String, dynamic>> _notesByTeacher = [];
  List<Map<String, dynamic>> get notesByTeacher => _notesByTeacher;

  Future<void> getNotesByTeacherId() async {
    _isloading = true;
    notifyListeners(); // Notify the UI about the loading state
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response =
          await NoteServices().getNotesByTeacherId(teacherId: teacherId);

      if (response.statusCode == 200) {
        // Parse response data into the desired format
        final List<dynamic> data =
            response.data; // Assuming response.data is a JSON array

        _notesByTeacher = data.map((note) {
          return {
            "id": note['id'],
            "teacherId": note['teacher_id'],
            "title": note['note_title'],
            "content": note['note_content'],
            "attachment": note['note_attachment'],
            "createdAt": note['created_at'],
            "updatedAt": note['updated_at'],
          };
        }).toList();
      } else {
        log('Failed to fetch notes: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching notes: $e');
    } finally {
      _isloading = false;
      notifyListeners(); // Notify the UI about the updated state
    }
  }

// ************Get Notes by StudentId**************
  List<NoteData> _parentNoteStudent = [];
  List<NoteData> get parentNoteStudent => _parentNoteStudent;
  Future<void> getNotesByStudentId({required int studentId}) async {
    _isloading = true;
    notifyListeners();
    try {
      final response =
          await NoteServices().getNoteByStudentId(studentId: studentId);
      if (response.statusCode == 200) {
        _parentNoteStudent = (response.data['data'] as List<dynamic>)
            .map((result) => NoteData.fromJson(result))
            .toList();
        log("Parent notes:${_parentNoteStudent.toString()}");
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // **********Unviewed notes count by parent*****
  int _unviewedNotesCount = 0;

  int get unviewedNotesCount => _unviewedNotesCount;

  // Method to fetch unviewed notes count by student ID
  Future<void> fetchUnviewedNotesCountByStudentId(
      {required int studentId}) async {
    _isloading = true;
    notifyListeners(); // Notify UI to show loading indicator

    try {
      final response = await NoteServices()
          .getUnViewedNotesCountByStudentId(studentId: studentId);
      if (response.statusCode == 200 && response.data["status"] == "success") {
        _unviewedNotesCount = response.data["unviewed_count"] ?? 0;
        log("Unviewed message count:${_unviewedNotesCount.toString()}");
      } else {
        _unviewedNotesCount = 0; // Default to 0 in case of an error
      }
    } catch (e) {
      _unviewedNotesCount = 0;
      debugPrint("Error fetching unviewed notes count: $e");
    } finally {
      _isloading = false;
      notifyListeners(); // Notify UI to stop loading
    }
  }

  // *********Mark Parent note as viewed*************
  Future<void> markParentNoteAsViewed(
      {required BuildContext context,
      required int studentId,
      required int parentNoteId,
      required NoteData teacherNote}) async {
    _isloadingTwo = true;
    try {
      final response = await NoteServices().markParentNoteAsViewed(
          studentId: studentId, parentNoteId: parentNoteId);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(("Message viewed response: ${response.data.toString()}"));
        await getNotesByStudentId(studentId: studentId);
        await fetchUnviewedNotesCountByStudentId(studentId: studentId);
        // context.pushNamed(AppRouteConst.parentNoteDetailRouteName,
        //     extra: teacherNote);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }
}
