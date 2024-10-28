import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/features/teacher/attendance/services/attendance_services.dart';

// Enum to represent attendance status
enum AttendanceStatus { present, late, absent, none }

class AttendanceController extends ChangeNotifier {
  // Map to hold attendance status for each student by their ID
  final Map<int, AttendanceStatus> _attendanceStatus = {};

  // Getter for attendance status of a specific student
  AttendanceStatus getStatus(int studentId) {
    return _attendanceStatus[studentId] ?? AttendanceStatus.none;
  }

  // Method to update the attendance status of a specific student
  void updateStatus(int studentId, AttendanceStatus status) {
    _attendanceStatus[studentId] = status;
    notifyListeners(); // Notify to rebuild the UI
  }

// present/late/absent toggle button


  //*************** */ submit attendance**************
  final AttendanceServices _attendanceService = AttendanceServices();
  Future<void> submitAttendance(
      {required String date,
      required String classGrade,
      required String section,
      required String periodNumber,
      required int recordedBy,
      required List<Map<String, dynamic>> students}) async {
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
        log(">>>>>>>>>>>>>>>>>>>Attendance submitted successfully");
      } else {
        log(">>>>>>>>>>>>>>>>>>>Error submitting attendance--Status Code:${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }
}
