import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_model.dart';
import 'package:school_app/features/teacher/attendance/services/attendance_services.dart';

// Enum to represent attendance status
enum AttendanceStatus { present, late, absent, none }

class AttendanceController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  final Map<int, AttendanceStatus> _attendanceStatus = {};

  bool isAllPresent = false;

  // Existing code for storing student statuses...

  // void markAllPresent() {
  //   isAllPresent = true;
  //   notifyListeners();
  // }

  // void resetAllPresent() {
  //   isAllPresent = false;
  //   notifyListeners();
  // }

  // AttendanceStatus getStatus(int studentId) {
  //   if (isAllPresent && !_attendanceStatus.containsKey(studentId)) {
  //     return AttendanceStatus.present;
  //   }
  //   return _attendanceStatus[studentId] ?? AttendanceStatus.absent;
  // }

  // void updateStatus(int studentId, AttendanceStatus status) {
  //   isAllPresent = false;  // Turn off all-present mode once any status is updated
  //   _attendanceStatus[studentId] = status;
  //   notifyListeners();
  // }

// Function for get status
  AttendanceStatus getStatus(int studentId) {
    return _attendanceStatus[studentId] ?? AttendanceStatus.none;
  }

//  Function for update status
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
  List<Map<String, dynamic>> get attendanceStatusList {
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

  // Helper function to convert string to AttendanceStatus enum
  AttendanceStatus _stringToStatus(String status) {
    switch (status.toLowerCase()) {
      case "present":
        return AttendanceStatus.present;
      case "late":
        return AttendanceStatus.late;
      case "absent":
        return AttendanceStatus.absent;
      default:
        return AttendanceStatus
            .none; // Assuming `none` is a valid fallback case
    }
  }

// **********Take attendance******************
  List<StudentAttendance> _attendanceList = [];
  List<StudentAttendance> get attendanceList => _attendanceList;
  List<int> _alreadyTakenPeriodList = [];
  List<int> get alreadyTakenPeriodList => _alreadyTakenPeriodList;
  Future<void> takeAttendance(BuildContext context,
      {required AttendanceData attendanceData,
      Attendance? previousAttendance}) async {
    _alreadyTakenPeriodList.clear();
    try {
      final response = await AttendanceServices().checkAttendance(
          className: attendanceData.selectedClass,
          section: attendanceData.selectedDivision,
          date: attendanceData.selectedDate,
          period: attendanceData.selectedPeriod);
      log(response.data.toString());
      // _attendanceList.clear();

      if (response.statusCode == 200) {
        _attendanceList = (response.data['students'] as List<dynamic>)
            .map((result) => StudentAttendance.fromJson(result))
            .toList();
        _alreadyTakenPeriodList = (response.data['completed_periods'] as List)
            .map((e) => e as int)
            .toList();
        log(_alreadyTakenPeriodList.toString());
        log("attendance list ==== ${attendanceList[0].recordedBy}");
        final _teacherId = attendanceList[0].recordedBy;
        if (_teacherId != null) {
          CustomSnackbar.show(context,
              message: "Attendance Already Taken", type: SnackbarType.info);
          context.pushNamed(AppRouteConst.attendanceRouteName,
              extra: attendanceData);
        } else {
          context.pushNamed(AppRouteConst.attendanceRouteName,
              extra: attendanceData);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

// ************get already taken attenndance status*************

  AttendanceStatus getAlreadyTakenStatus(int studentId, int index) {
    final _alreadyStatus =
        _stringToStatus(_attendanceList[index].attendanceStatus ?? "");
    return _alreadyStatus;
  }

// // **********check attendance already taken**************
//   Future<void> checkAttendance(BuildContext context,
//       {required String className,
//       required String section,
//       required String date,
//       required String period,
//       required AttendanceData attendanceData}) async {
//     final response = await AttendanceServices().checkAttendance(
//         className: className, section: section, date: date, period: period);
//     if (response.statusCode == 200) {
//       final data = response.data;
//       if (data[0].length > 2) {
//         log(">>>>>>>>>>>>>>${response.data}");
//         CustomSnackbar.show(context,
//             message: "Attendance Already Taken", type: SnackbarType.warning);
//       } else {
//         context.pushNamed(AppRouteConst.attendanceRouteName,
//             extra: attendanceData);
//         log("no status>>>>>>>>>>>>>>${response.data}");
//       }
//     }
//   }

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
