import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_model.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_record_model.dart';
import 'package:school_app/features/teacher/attendance/model/edit_attendance_request.dart';
import 'package:school_app/features/teacher/attendance/services/attendance_services.dart';

// Enum to represent attendance status
enum AttendanceStatus { present, late, absent, none }

class AttendanceController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  final Map<int, AttendanceStatus> _attendanceStatus = {};
  Map<int, String> _remarks = {}; // Stores selected remarks

  bool isAllPresent = false;

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

// Function to return attendance data with remarks (if provided)
  List<Map<String, dynamic>> get attendanceStatusList {
    return _attendanceStatus.entries.map((entry) {
      final remark =
          _remarks[entry.key]; // Fetch remark for the student (if any)
      return {
        'student_id': entry.key,
        'attendance_status': _statusToString(entry.value),
        if (remark != null && remark.isNotEmpty)
          'remarks': remark, // Include only if set
      };
    }).toList();
  }

  // Function to update the remark for a student (called from the dropdown)
  void updateRemark(int studentId, String remark) {
    _remarks[studentId] = remark;
    notifyListeners();
  }

  // Function to get the selected remark for a student
  String getSelectedRemark(int studentId) {
    return _remarks[studentId] ?? "Select Remark"; // Default value
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
        log("Attendance response::::::::::::::::: ${response.data}");
        log(_alreadyTakenPeriodList.toString());
        if (_attendanceList.isNotEmpty) {
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
        } else {
          CustomSnackbar.show(context,
              message: "No students found for this class and division.",
              type: SnackbarType.warning);
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

  //*************** */ submit attendance**************
  final AttendanceServices _attendanceService = AttendanceServices();
  Future<void> submitAttendance(BuildContext context,
      {required String date,
      required String classGrade,
      required String section,
      required String periodNumber,
      required int subject,
      // required int recordedBy,
      required List<Map<String, dynamic>> students}) async {
    _isloadingTwo = true;
    notifyListeners(); // Notify listeners when loading starts
    final teacherId = await SecureStorageService.getUserId();
    final attendanceData = {
      'date': date,
      'class_grade': classGrade,
      'section': section,
      'period_number': periodNumber,
      'recorded_by': teacherId,
      'students': students,
      "subject": subject,
    };

    try {
      final response =
          await _attendanceService.submitAttendance(attendanceData);
      if (response.statusCode == 201) {
        log("Attendance submitted successfully");
        log("Attendance response2::::::::::::::::: ${response.data}");
        context.pushReplacementNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.teacher);
            CustomSnackbar.show(context, message: "Attendance Submitted Successfully", type: SnackbarType.success);
      } else {
        log("Error submitting attendance--Status Code:${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }

    _isloadingTwo = false;
    notifyListeners(); // Notify listeners when loading ends
    clearAttendanceStatus();
  }

  // Get Attendance record
  List<AttendanceRecord> _attendanceRecord = [];
  List<AttendanceRecord> get attendanceRecord => _attendanceRecord;
  // AttendanceRecord attendanceRecord = AttendanceRecord();
  Future<void> getTeacherAttendanceRecords({required String date}) async {
    _isloading = true;
    _attendanceRecord.clear();
    notifyListeners(); // Notify listeners when loading starts
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await AttendanceServices()
          .getDailyAttendanceByTeacher(teacherId: teacherId, date: date);
      if (response.statusCode == 200) {
        _attendanceRecord =
            (response.data['attendance_records'] as List<dynamic>)
                .map((result) => AttendanceRecord.fromJson(result))
                .toList();
        // final temp = AttendanceRecord.fromJson(response.data['attendance_records']);
        // _attendanceRecord.add(temp);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  // Update Attendance
  Future<void> updateAttendance({required BuildContext context, required List<EditAttendanceRequest> attendanceData}) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final response = await AttendanceServices().updateAttendance(attendanceData);
      if (response.statusCode == 200) {
        CustomSnackbar.show(context, message: "Attendance Updated Successfully", type: SnackbarType.success);
      }
    } catch (e){
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
}
}