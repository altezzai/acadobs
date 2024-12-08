// import 'dart:developer';
// import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/features/admin/student/model/day_attendance_status.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/model/student_homework.dart';
import 'package:school_app/features/admin/student/services/studentservice.dart';

class StudentController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  List<Student> _students = [];
  List<Student> get students => _students;
  List<Student> _filteredstudents = [];
  List<Student> get filteredstudents => _filteredstudents;

  List<Student> _parents = [];
  List<Student> get parents => _parents;
  List<Student> _filteredparents = [];
  List<Student> get filteredparents => _filteredparents;

  // Fetch student details (GET request)
  Future<void> getStudentDetails() async {
    _isloading = true;
    try {
      final response = await StudentServices().getStudent();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _students.clear();
        _students = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  List<HomeworkDetail> _homeworks = [];
  List<HomeworkDetail> get homeworks => _homeworks;

  // GET student homework
  Future<void> getStudentHomework({required int studentId}) async {
    _isloading = true;
    try {
      final response =
          await StudentServices().getStudentHomework(studentId: studentId);
      log("***********${response.statusCode}");
      log("***********${response.data.toString()}");
      if (response.statusCode == 200) {
        log("Started");
        _homeworks.clear();
        log("One");

        // Check if data is a single object
        if (response.data["homework_details"] is Map<String, dynamic>) {
          _homeworks.add(HomeworkDetail.fromJson(response.data));
        } else if (response.data["homework_details"] is List<dynamic>) {
          _homeworks = (response.data["homework_details"] as List<dynamic>)
              .map((result) => HomeworkDetail.fromJson(result))
              .toList();
        }

        log("Two");
        log("Achievement list***********${_homeworks.toString()}");
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // ********Add New Student************
  Future<void> addNewStudent(
    BuildContext context, {
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String studentClass,
    required String section,
    required String rollNumber,
    required String admissionNumber,
    required String aadhaarNumber,
    required String residentialAddress,
    required String contactNumber,
    required String email,
    required String fatherFullName,
    required String motherFullName,
    required String bloodGroup,
  }) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      final response = await StudentServices().addNewStudent(
          fullName: fullName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          studentClass: studentClass,
          section: section,
          rollNumber: rollNumber,
          admissionNumber: admissionNumber,
          aadhaarNumber: aadhaarNumber,
          residentialAddress: residentialAddress,
          contactNumber: contactNumber,
          email: email,
          fatherFullName: fatherFullName,
          motherFullName: motherFullName,
          bloodGroup: bloodGroup);
      if (response.statusCode == 201) {
        log(">>>>>>>>>>>>>Student Added}");
        context.pushNamed(AppRouteConst.AdminstudentRouteName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loadingProvider.setLoading(false); // End loader
      notifyListeners();
    }
  }

  // Fetch student class and division details (GET request)
Future<void> getStudentsClassAndDivision({
  required String classname,
  required String section,
}) async {
  _isloading = true; // Set loading state to true
  notifyListeners(); // Notify listeners to update the UI

  try {
    // Call the API to fetch student data
    final response = await StudentServices().getStudentsClassAndDivision(
      classname: classname,
      section: section,
    );

    // Log the response for debugging purposes
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.data}");

    if (response.statusCode == 200 && response.data is List) {
      // Successfully received data, map and update the filtered students list
      _filteredstudents = (response.data as List<dynamic>)
          .map((student) => Student.fromJson(student))
          .toList();
    } else {
      // Handle unexpected response format or status
      _filteredstudents.clear(); // Clear the list if response is invalid
      print("Unexpected response: ${response.statusCode}");
    }
  } catch (e) {
    // Log the error and clear the student list on failure
    print("Error fetching student data: $e");
    _filteredstudents.clear();
  } finally {
    // Reset the loading state and notify listeners
    _isloading = false;
    notifyListeners();
  }
}
// Clear the filtered students list
void clearStudentList() {
  _filteredstudents.clear();
  notifyListeners();
}


  // Fetch Parent details (GET request)
  Future<void> getParentDetails() async {
    _isloading = true;
    try {
      final response = await StudentServices().getParent();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _parents.clear();
        _parents = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Fetch parent class and division details (GET request)
  Future<void> getParentByClassAndDivision(
      {required String classname, required String section}) async {
    _isloading = true;
    try {
      final response = await StudentServices().getParentByClassAndDivision(
        classname: classname,
        section: section,
      );
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _filteredparents.clear();
        _filteredparents = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Day Attendance Status List
  List<DayAttendanceStatus> _dayAttendanceStatus = [];
  List<DayAttendanceStatus> get dayAttendanceStatus => _dayAttendanceStatus;

  // Selected Date
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  // Loading State
  bool _isLoadingTwo = false;
  bool get isLoadingTwo => _isLoadingTwo;

  // Formatted Date (Today, Yesterday, or Date String)
  String get formattedDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final selectedDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );

    if (selectedDay == today) {
      return "Today";
    } else if (selectedDay == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM yyyy').format(_selectedDate);
    }
  }

  // Update Date and Fetch Data
  Future<void> updateDate(DateTime newDate, {required String studentId}) async {
    _selectedDate = newDate;
    await getDayAttendance(
        studentId: studentId); // Automatically fetch attendance
  }

  // Fetch Attendance Data
  Future<void> getDayAttendance({required String studentId}) async {
    _isLoadingTwo = true;
    notifyListeners();

    try {
      final response = await StudentServices().getDayAttendance(
        studentId: studentId,
        date: _selectedDate.toIso8601String(),
      );
      log("Attendance Response: ${response.data}");

      if (response.statusCode == 200) {
        // Map API Response to Model
        _dayAttendanceStatus = (response.data as List<dynamic>)
            .map((result) => DayAttendanceStatus.fromJson(result))
            .toList();
      } else {
        // Handle non-200 response
        _dayAttendanceStatus = [];
        log("Non-200 response: ${response.statusCode}");
      }
    } catch (e) {
      // Handle API Errors
      log("Error fetching attendance: $e");
      _dayAttendanceStatus = [];
    } finally {
      _isLoadingTwo = false;
      notifyListeners(); // Notify listeners once at the end
    }
  }

  // get today attendance
  Future<void> getTodayAttendance({required String studentId}) async {
    // _selectedDate = DateTime.now();
    try {
      final response = await StudentServices().getDayAttendance(
        studentId: studentId,
        date: DateTime.now().toString(),
      );
      log("Attendance Response: ${response.data}");

      if (response.statusCode == 200) {
        // Map API Response to Model
        _dayAttendanceStatus = (response.data as List<dynamic>)
            .map((result) => DayAttendanceStatus.fromJson(result))
            .toList();
        notifyListeners();
      } else {
        // Handle non-200 response (optional)
        _dayAttendanceStatus = [];
        log("Non-200 response: ${response.statusCode}");
      }
    } catch (e) {
      // Handle API Errors
      log("Error fetching attendance: $e");
      _dayAttendanceStatus = [];
    } finally {
      // Notify Listeners after every attempt
      notifyListeners();
    }
  }
}
