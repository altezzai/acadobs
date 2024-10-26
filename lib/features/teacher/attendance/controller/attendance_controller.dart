import 'package:flutter/material.dart';

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

  // get students
  
}
