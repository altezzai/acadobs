import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
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

  // Add a new teacher
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
        context.pushNamed(AppRouteConst.AdminteacherRouteName);
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
}
