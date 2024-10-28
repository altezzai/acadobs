import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/teacher/attendance/services/attendance_services.dart';

// Enum to represent attendance status
enum AttendanceStatus { present, late, absent, none }

class AttendanceController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  final Map<int, AttendanceStatus> _attendanceStatus = {};

  AttendanceStatus getStatus(int studentId) {
    return _attendanceStatus[studentId] ?? AttendanceStatus.none;
  }

  void updateStatus(int studentId, AttendanceStatus status) {
    _attendanceStatus[studentId] = status;
    notifyListeners();
  }

  // Method to clear previous attendance statuses
  void clearAttendanceStatus() {
    _attendanceStatus.clear();
    notifyListeners();
  }

  // Function to return a list of attendance data
  List<Map<String, dynamic>> get attendanceList {
    return _attendanceStatus.entries.map((entry) {
      return {
        'student_id': entry.key,
        'attendance_status': _statusToString(entry.value),
      };
    }).toList();
  }

  // Helper function to convert AttendanceStatus enum to string
  String _statusToString(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return "Present";
      case AttendanceStatus.late:
        return "Late";
      case AttendanceStatus.absent:
        return "Absent";
      default:
        return "None";
    }
  }

  //*************** */ submit attendance**************
  final AttendanceServices _attendanceService = AttendanceServices();
  Future<void> submitAttendance(BuildContext context,
      {required String date,
      required String classGrade,
      required String section,
      required String periodNumber,
      required int recordedBy,
      required List<Map<String, dynamic>> students}) async {
    _isloading = true;
    notifyListeners(); // Notify listeners when loading starts

    final attendanceData = {
      'date': date,
      'class_grade': classGrade,
      'section': section,
      'period_number': periodNumber,
      'recorded_by': recordedBy,
      'students': students,
    };

    try {
      final response =
          await _attendanceService.submitAttendance(attendanceData);
      if (response.statusCode == 201) {
        log("Attendance submitted successfully");
        context.pushReplacementNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.teacher);
      } else {
        log("Error submitting attendance--Status Code:${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }

    _isloading = false;
    notifyListeners(); // Notify listeners when loading ends
    clearAttendanceStatus();
  }
}
