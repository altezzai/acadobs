import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/features/admin/teacher_section/model/activity_model.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
import 'package:school_app/features/admin/teacher_section/services/teacher_services.dart';

class TeacherController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;

  List<Teacher> _teachers = [];
  List<Teacher> get teachers => _teachers;

  // Selected teacher IDs
  List<int> _selectedTeacherIds = [];
  List<int> get selectedTeacherIds => _selectedTeacherIds;

  // Fetch teacher details and clear selections
  Future<void> getTeacherDetails() async {
    _isloading = true;
    _selectedTeacherIds.clear();
    try {
      final response = await TeacherServices().getTeacher();
      if (response.statusCode == 200) {
        _teachers = (response.data as List<dynamic>)
            .map((result) => Teacher.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // *************individual teacher details**************
  Teacher? _individualTeacher;
  Teacher? get individualTeacher => _individualTeacher;
  Future<void> getIndividualTeacherDetails({required int teacherId}) async {
    _isloading = true;
    notifyListeners(); // Notify before starting the operation

    try {
      log("Fetching individual teacher details...");

      log("Retrieved Teacher ID: $teacherId");

      final response = await TeacherServices()
          .getIndividualTeacherDetails(teacherId: teacherId);

      log("API Response Status Code: ${response.statusCode}");
      log("API Response Data: ${response.data}");

      if (response.statusCode == 200) {
        // Assuming response.data contains the single teacher JSON object
        _individualTeacher = Teacher.fromJson(response.data);
        log("Teacher details successfully stored in _individualTeacher: ${_individualTeacher.toString()}");
      } else {
        log("Failed to fetch teacher details. Status Code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      log("Error fetching teacher details: $e",
          error: e, stackTrace: stackTrace);
    } finally {
      _isloading = false;
      notifyListeners(); // Notify after completing the operation
    }
  }

  //******** */ Add a new teacher
  Future<void> addNewTeacher(
    BuildContext context, {
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String address,
    required String contactNumber,
    required String emailAddress,
    required String profilePhoto,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await TeacherServices().addNewTeacher(
        fullName: fullName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        address: address,
        contactNumber: contactNumber,
        emailAddress: emailAddress,
        profilePhoto: profilePhoto,
      );
      if (response.statusCode == 201) {
        log("Teacher added successfully");
        await getTeacherDetails();
        CustomSnackbar.show(
          context,
          message: "Teacher Added Successfully",
          type: SnackbarType.success,
        );
        Navigator.pop(context);
      } else {
        final Map<String, dynamic> errors = response.data['message'];

        // Extract all error messages into a list
        List<String> errorMessages = [];
        errors.forEach((key, value) {
          if (value is List) {
            errorMessages.addAll(value.map((e) => e.toString()));
          } else if (value is String) {
            errorMessages.add(value);
          }
        });
// Format the errors with numbering
        String formattedErrors = errorMessages
            .asMap()
            .entries
            .map((entry) => "${entry.key + 1}. ${entry.value}")
            .join("\n");

        // Show error messages in Snackbar
        CustomSnackbar.show(
          context,
          message: formattedErrors,
          type: SnackbarType.failure,
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // Toggle teacher selection
  void toggleTeacherSelection(int teacherId) {
    if (_selectedTeacherIds.contains(teacherId)) {
      _selectedTeacherIds.remove(teacherId);
    } else {
      _selectedTeacherIds.add(teacherId);
    }
    notifyListeners();
  }

  // Check if a teacher is selected
  bool isTeacherSelected(int teacherId) {
    return _selectedTeacherIds.contains(teacherId);
  }

  // Clear selections
  void clearSelection() {
    _selectedTeacherIds.clear();
    notifyListeners();
  }

  // Get selected teachers' details
  List<Teacher> getSelectedTeachers() {
    return _teachers
        .where((teacher) => _selectedTeacherIds.contains(teacher.id))
        .toList();
  }

  List<ActivityElement> _activities = [];
  List<ActivityElement> get activities => _activities;
  Future<void> getTeacherActivities({required int teacherId}) async {
    _isloading = true;
    // _selectedTeacherIds.clear();
    try {
      final response =
          await TeacherServices().getActivities(teacherId: teacherId);
      if (response.statusCode == 200) {
        _activities = (response.data["activities"] as List<dynamic>)
            .map((result) => ActivityElement.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // ***********Edit Teacher***********
  Future<void> editTeacher(
    BuildContext context, {
    required int teacherId,
    required String fullName,
    required String email,
    required address,
    required contactNumber,
    String? profilePhoto,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await TeacherServices().editTeacher(
        teacherId: teacherId,
        fullName: fullName,
        email: email,
        address: address,
        contactNumber: contactNumber,
        profilePhoto: profilePhoto ?? "",
      );
      if (response.statusCode == 201) {
        log("Edited teacher successfully");
        await getTeacherDetails();
        CustomSnackbar.show(
          context,
          message: " Edited Teacher Successfully",
          type: SnackbarType.success,
        );
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        CustomSnackbar.show(
          context,
          message: response.data,
          type: SnackbarType.failure,
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  //********* */ delete teacher
  Future<void> deleteTeacher(BuildContext context,
      {required int teacherId}) async {
    _isloading = true;
    try {
      final response =
          await TeacherServices().deleteTeacher(teacherId: teacherId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Teacher deleted successfully.");
        Navigator.pop(context);
        CustomSnackbar.show(context,
            message: 'Deleted successfully', type: SnackbarType.info);
        await getTeacherDetails();
      }
    } catch (e) {
      // print(e);
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
