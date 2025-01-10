// import 'dart:developer';
// import 'package:dio/dio.dart';
import 'dart:developer';

//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/features/admin/student/model/day_attendance_status.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/model/student_homework.dart';
import 'package:school_app/features/admin/student/services/studentservice.dart';

class StudentController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isFiltered = false; // New flag to track filtering
  bool get isFiltered =>
      _isFiltered; // Public getter to access the filter state

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
      // print("***********${response.statusCode}");
      // print(response.toString());
      log("***********${response.statusCode}");
      log(response.data.toString());
      if (response.statusCode == 200) {
        _students.clear();
        _students = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();
        log(_students.toString());
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

// **************single child details***************
  Student? _individualStudent;
  Student? get individualStudent => _individualStudent;
  Future<void> getIndividualStudentDetails({required int studentId}) async {
    _isloading = true;
    notifyListeners(); // Notify before starting the operation

    try {
      log("Fetching individual student details...");

      // final studentId = await SecureStorageService.getUserId();
      log("Retrieved Student ID: $studentId");

      final response = await StudentServices()
          .getIndividualStudentDetails(studentId: studentId);

      log("API Response Status Code: ${response.statusCode}");
      log("API Response Data: ${response.data}");

      if (response.statusCode == 200) {
        // Assuming response.data contains the single student JSON object
        _individualStudent = Student.fromJson(response.data);
        log("Student details successfully stored in _individualStudent: ${_individualStudent.toString()}");
      } else {
        log("Failed to fetch student details. Status Code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      log("Error fetching student details: $e",
          error: e, stackTrace: stackTrace);
    } finally {
      _isloading = false;
      notifyListeners(); // Notify after completing the operation
    }
  }

  // *************Get students by parents******************
  List<Student> _studentsByParents = [];
  List<Student> get studentsByParents => _studentsByParents;
  List<int> _syudentIds = [];
  List<int> get studentIds => _syudentIds;
  Future<void> getStudentsByParentEmail() async {
    _isloading = true;
    final parentEmail = await SecureStorageService.getUserEmail();
    try {
      final response = await StudentServices()
          .getStudentsByParentEmail(parentEmail: parentEmail ?? "");
      log("***********${response.statusCode}");
      log(response.data.toString());
      if (response.statusCode == 200) {
        _studentsByParents.clear();
        _syudentIds.clear(); // Clear the studentIds list before adding new ones

        _studentsByParents = (response.data as List<dynamic>)
            .map((result) => Student.fromJson(result))
            .toList();

        // Extract student IDs and store them in _syudentIds
        _syudentIds.addAll(
            _studentsByParents.map((student) => student.id ?? 0).toList());

        log("Student IDs: $_syudentIds");
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // ***************GET student homework

  List<HomeworkDetail> _homeworks = [];
  List<HomeworkDetail> get homeworks => _homeworks;
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
  Future<void> addNewStudent(BuildContext context,
      {required String fullName,
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
      required String guardianFullName,
      required String bloodGroup,
      required String parentEmail,
      required String fatherContactNumber,
      required String motherContactNumber,
      required String studentPhoto,
      String? aadharPhoto,
      required String fatherMotherPhoto}) async {
    _isloading = true;

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
          guardianFullName: guardianFullName,
          parentEmail: parentEmail,
          bloodGroup: bloodGroup,
          fatherContactNumber: fatherContactNumber,
          motherContactNumber: motherContactNumber,
          studentPhotoPath: studentPhoto,
          aadhaarCard: aadharPhoto,
          fatherMotherPhoto: fatherMotherPhoto);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>>>>>>>>Student Added}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Student Added successfully!'),
            backgroundColor: Colors.green, // Set color for success
          ),
        );
        // Navigate to the desired route

        Navigator.pop(context);
      } else {
        // Handle failure case here if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add student. Please try again.'),
            backgroundColor: Colors.red, // Set color for error
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  //update student details

  Future<void> updateStudent(
    BuildContext context, {
    required int studentId,
    required String fullName,
    required String studentClass,
    required String section,
    required String contactNumber,
    required String email,
    // required String parentEmail,
    required String fatherContactNumber,
    required String motherContactNumber,
    required String studentPhoto,
    required String fatherMotherPhoto,
  }) async {
    _isloading = true;

    try {
      final response = await StudentServices().updateStudent(
        studentId: studentId,
        fullName: fullName,
        studentClass: studentClass,
        section: section,
        contactNumber: contactNumber,
        email: email,
        // parentEmail: parentEmail,
        fatherContactNumber: fatherContactNumber,
        motherContactNumber: motherContactNumber,
        studentPhotoPath: studentPhoto,
        fatherMotherPhoto: fatherMotherPhoto,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        await getIndividualStudentDetails(studentId: studentId);
        log(">>>>>>>>>>>>>Student Details updated}");
        log('Response: ${response.data}');
        CustomSnackbar.show(context,
            message: 'Student Updated successfully!', type: SnackbarType.info);
        // Navigate to the desired route
        Navigator.pop(context);
      } else {
        // Handle failure case here if needed
        CustomSnackbar.show(context,
            message: 'Failed to update student. Please try again.',
            type: SnackbarType.info);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // Fetch student class and division details (GET request)
  Future<void> getStudentsClassAndDivision({
    required String classname,
    required String section,
  }) async {
    _isloading = true; // Set loading state to true
    _isFiltered = false;
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
      _isFiltered = true;
      notifyListeners();
    }
  }

// Clear the filtered students list
  void clearStudentList() {
    _filteredstudents.clear();
    notifyListeners();
  }

  void resetFilter() {
    _isFiltered = false;

    notifyListeners(); // Notify listeners to update the UI
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
    _isFiltered = false;
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
    _isFiltered = true;
    notifyListeners();
  }

  void clearParentList() {
    _filteredparents.clear();
    notifyListeners();
  }

  // ****************DAILY ATTENDANCE STATUS*************************

  // Day Attendance Status List
  List<DayAttendanceStatus> _dayAttendanceStatus = [];
  List<DayAttendanceStatus> get dayAttendanceStatus => _dayAttendanceStatus;

  // Selected Date
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ); // Current date with time set to 00:00:00.000

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
  Future<void> updateDate(DateTime newDate,
      {required String studentId, bool forBuildScreen = false}) async {
    _isloading = true;
    _selectedDate = newDate;
    notifyListeners();
    await getDayAttendance(
        studentId: studentId); // Automatically fetch attendance
    _isloading = false;
    notifyListeners();
  }

  // Fetch Attendance Data
  Future<void> getDayAttendance(
      {required String studentId, bool forBuildScreen = false}) async {
    _isLoadingTwo = true;
    notifyListeners();
    final date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    try {
      final response = await StudentServices().getDayAttendance(
        studentId: studentId,
        date:
            forBuildScreen ? date.toString() : _selectedDate.toIso8601String(),
      );
      log("Attendance Response: ${response.data} with date: ${_selectedDate.toString()}");

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
  // ***********END OF DAILY ATTENDANCE STATUS********************//
}
