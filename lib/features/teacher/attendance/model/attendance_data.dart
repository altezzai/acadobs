import 'package:school_app/features/teacher/attendance/screens/attendance.dart';

class AttendanceData {
  final String selectedClass;
  final String selectedPeriod;
  final String selectedDivision;
  final String selectedDate;
  final AttendanceAction action;

  AttendanceData({
    required this.selectedClass,
    required this.selectedPeriod,
    required this.selectedDivision,
    required this.selectedDate,
    required this.action
  });
}
