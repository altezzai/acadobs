import 'package:school_app/features/teacher/attendance/utils/attendance_action.dart';

class AttendanceData {
  final String selectedClass;
  final String selectedPeriod;
  final String selectedDivision;
  final String selectedDate;
  final int subject;
  final AttendanceAction action;
  final List<int>? completedPeriods;

  AttendanceData(
      {required this.selectedClass,
      required this.selectedPeriod,
      required this.selectedDivision,
      required this.selectedDate,
      required this.action,
      required this.subject,
      this.completedPeriods});
}
