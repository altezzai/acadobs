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

  // List to store selected teacher IDs
  List<int> _selectedTeacherIds = [];
  List<int> get selectedTeacherIds => _selectedTeacherIds;

// **********Get all teachers*****************
  Future<void> getTeacherDetails() async {
    _isloading = true;
    try {
      final response = await TeacherServices().getTeacher();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _teachers = (response.data as List<dynamic>)
            .map((result) => Teacher.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // ********Add New Teacher************
  Future<void> addNewTeacher(BuildContext context,
      {required String fullName,
      required String dateOfBirth,
      required String gender,
      required String address,
      required String contactNumber,
      required String emailAddress,
      required String profilePhoto}) async {
    _isloadingTwo = true;
    try {
      //  _isloading = false;
      final response = await TeacherServices().addNewTeacher(
          fullName: fullName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          address: address,
          contactNumber: contactNumber,
          emailAddress: emailAddress,
          profilePhoto:profilePhoto);
          
      if (response.statusCode == 201) {
        log(">>>>>>>>>>>>>Teacher Added}");
        context.pushNamed(AppRouteConst.AdminteacherRouteName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // ***********Select teacher for duties*****
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

  // Clear the selection
  void clearSelection() {
    _selectedTeacherIds.clear();
    notifyListeners();
  }
}
