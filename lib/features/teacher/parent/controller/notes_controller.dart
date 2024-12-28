import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/features/teacher/parent/model/latest_chat_model.dart';
import 'package:school_app/features/teacher/parent/model/parent_chat_model.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_model.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_student_model.dart';
import 'package:school_app/features/teacher/parent/services/note_services.dart';

class NotesController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;

  bool _isloadingForChats = false;
  bool get isloadingForChats => _isloadingForChats;

  List<ParentChat> _parentChat = [];
  List<ParentChat> get parentChat => _parentChat;

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
        await getNotesByTeacherId();
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
        log("Parent note: ${_parentNote.toString()}");
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
        _parentNoteStudent.clear();

        _parentNoteStudent = (response.data['data'] as List<dynamic>)
            .map((result) => NoteData.fromJson(result))
            .toList();
        log("Parent notes:${_parentNoteStudent.toString()}");
        // log("=================Parent note message:${_parentNoteStudent.}=========================");
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

  // *********Get teacherChatId from teacherId************
  int _teacherChatId = 0;
  int get teacherChatId => _teacherChatId;
  Future<int> getTeacherChatIdFromTeacherId({required int teacherId}) async {
    _isloading = true;
    notifyListeners();
    try {
      final response =
          await NoteServices().getTeacherChatId(teacherId: teacherId);

      if (response.statusCode == 200) {
        // Update _teacherChatId and return it
        _teacherChatId = response.data["teacher_id"] ?? 0;
        return _teacherChatId;
      } else {
        log('Failed to fetch teacher chat ID. Status code: ${response.statusCode}');
        return 0; // Return a default value on failure
      }
    } catch (e) {
      log('Error fetching teacher chat ID: $e');
      return 0; // Return a default value on error
    } finally {
      _isloading = false;
      notifyListeners(); // Notify the UI that the loading process has ended
    }
  }

  // ******************Parent Note Chat******************
  Future<void> sendParentNoteChatParent(
      {required int parentNoteId,
      required bool isTeacher,
      required int receiverId,
      required String message,
      required String senderRole}) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final senderId = await SecureStorageService.getChatId();
      final response = await NoteServices().parentNoteChat(
          parentNoteId: parentNoteId,
          senderId: senderId ?? 0,
          receiverId: receiverId,
          message: message,
          senderRole: senderRole);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(("Parent Note Chat response: ${response.data.toString()}"));
        await getAllParentChats(
            parentNoteId: parentNoteId,
            forTeacherScreen: false,
            forChatScreen: true);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // ******************Parent Note Chat******************
  Future<void> sendParentNoteChatTeacher(
      {required int parentNoteId,
      // required bool isTeacher,
      required int receiverId,
      required String message,
      required String senderRole}) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final senderId = await SecureStorageService.getChatId();
      final response = await NoteServices().parentNoteChat(
          parentNoteId: parentNoteId,
          senderId: senderId ?? 0,
          receiverId: receiverId,
          message: message,
          senderRole: senderRole);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(("Parent Note Chat response: ${response.data.toString()}"));
        await getAllParentChats(
            parentNoteId: parentNoteId,
            forTeacherScreen: true,
            studentIdforChat: receiverId,
            forChatScreen: true);
        await getLatestParentChats(parentNoteId: parentNoteId);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }
  // ************Get parent note chat***************

  Future<void> getAllParentNoteChat(
      {required int parentNoteId,
      required int teacherId,
      required int studentId}) async {
    _isloading = true;
    try {
      final studentChatId = await SecureStorageService.getChatId();

      final response = await NoteServices().getAllMessages(
          parentNoteId: parentNoteId,
          teacherId: _teacherChatId,
          studentId: studentChatId ?? 0);

      _parentChat.clear();
      log("parent note id: $parentNoteId, teacher id : $teacherChatId, student chat id: $studentChatId");
      if (response.statusCode == 200) {
        // _parentChat.clear();
        _parentChat = (response.data as List<dynamic>)
            .map((result) => ParentChat.fromJson(result))
            .toList();
        log("Parent Chats:${parentChat.toString()}");
        log("Parent Chat first message: ${parentChat[0].message}");
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // ************Get all parent chats***************
  Future<void> getAllParentChats(
      {required int parentNoteId,
      bool forTeacherScreen = false,
      bool forChatScreen = false,
      int studentIdforChat = 0}) async {
    if (forChatScreen == false) {
      // notifyListeners();
      _isloadingForChats = true;
    }

    // _parentChat = []; // Clear the list immediately
    notifyListeners();
    log("++++++++++++++++++++++++++++Get Chat length: ${_parentChat.length.toString()}");
    try {
      final studentChatId = await SecureStorageService.getChatId();
      final response = await NoteServices().getAllParentChats(
        parentNoteId: parentNoteId,
        studentChatId: forTeacherScreen ? studentIdforChat : studentChatId ?? 0,
      );
      log("Get all chats: ${response.data.toString()}");

      if (response.statusCode == 200 && response.data['data'] != null) {
        // Populate the list only if data is valid
        _parentChat.clear();
        _parentChat = (response.data['data'] as List<dynamic>)
            .map((result) => ParentChat.fromJson(result))
            .toList();
        log("Parent Chats: ${_parentChat.toString()}");
      } else {
        _parentChat = []; // Fallback to an empty list if no data is returned
      }
    } catch (e) {
      log("Error in fetching parent chats: $e");
      _parentChat = []; // Reset the list on error
    } finally {
      if (forChatScreen == false) {
        // notifyListeners();
        _isloadingForChats = false;
      }
      log("++++++++++++++++++++++++++++Get Chat length: ${_parentChat.length.toString()}++++++++++++++++++++++++++++++");
      notifyListeners(); // Notify listeners when loading is complete.
    }
  }

  // **********Get Latest chats for teacher***************
  List<LatestChat> _latestChats = [];
  List<LatestChat> get latestChats => _latestChats;
  Future<void> getLatestParentChats({
    required int parentNoteId,
  }) async {
    _isloadingForChats = true;
    _latestChats.clear();
    notifyListeners();
    try {
      final response =
          await NoteServices().getLatestParentChats(parentNoteId: parentNoteId);
      _latestChats.clear();
      log("parent note id: $parentNoteId, teacher id : $teacherChatId");
      if (response.statusCode == 200) {
        // _parentChat.clear();
        _latestChats = (response.data as List<dynamic>)
            .map((result) => LatestChat.fromJson(result))
            .toList();
        log("Parent Chats:${_latestChats.toString()}");
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingForChats = false;
      notifyListeners();
    }
  }
}
