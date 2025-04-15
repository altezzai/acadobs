import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/features/parent/leave_request/model/studentLeaveReq_model.dart';
import 'package:school_app/features/parent/leave_request/services/studentLeaveReq_services.dart';

class StudentLeaveRequestController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  List<StudentLeaveRequest> _studentsLeaveRequest = [];
  List<StudentLeaveRequest> get studentsLeaveRequest => _studentsLeaveRequest;

  List<StudentLeaveRequest> _studentsIndividualLeaveRequest = [];
  List<StudentLeaveRequest> get studentsIndividualLeaveRequest =>
      _studentsIndividualLeaveRequest;

// **********Get all students Leave request*****************
  Future<void> getStudentLeaveRequests() async {
    _isloading = true;
    try {
      final response =
          await StudentLeaveRequestServices().getStudentLeaveRequest();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _studentsLeaveRequest = (response.data as List<dynamic>)
            .map((result) => StudentLeaveRequest.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  //************Get individual student leaverequest*****************
  Future<void> getIndividualStudentLeaveRequests(
      {required int studentId}) async {
    _isloading = true;
    try {
      final response = await StudentLeaveRequestServices()
          .getStudentLeaveRequestById(studentId: studentId);
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        // _studentsIndividualLeaveRequest.clear();
        _studentsIndividualLeaveRequest = (response.data as List<dynamic>)
            .map((result) => StudentLeaveRequest.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Future<void> addStudent() async {
  //   try {
  //     // Use the formData you've already defined
  //     Response response =
  //         await StudentLeaveRequstServices().addStudent("/students", formData);
  //     if (response.statusCode == 201) {
  //       print("Student added successfully: ${response.data}");
  //     } else {
  //       print("Failed to add Student: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // FormData formData = FormData.fromMap({
  //   "name": "Soorya",
  //   "date_of_birth": "1980-05-15",
  //   "gender": "female",
  //   "address": "123 Elm Street, Springfield",
  //   "phone_number": "458734567368",
  //   "email": "soo@example.com",
  // });

  // ********Add New Student************
  Future<void> addNewStudentLeaveRequest(
    BuildContext context, {
    required String studentId,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reasonForLeave,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      //  _isloading = false;
      final response =
          await StudentLeaveRequestServices().addNewStudentLeaveRequest(
        studentId: studentId,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reasonForLeave: reasonForLeave,
      );
      if (response.statusCode == 201) {
        log(">>>>>>>>>>>>>Student Leave Request Added}");
        // Show success message using Snackbar
         CustomSnackbar.show(context,
            message: "Leave request submitted successfully!", type: SnackbarType.success);
       
        await getIndividualStudentLeaveRequests(
            studentId: int.parse(studentId));
        Navigator.pop(context);
      } else {
        // Handle failure case here if needed
        CustomSnackbar.show(context,
            message: "Failed to submit leave request.Please try again", type: SnackbarType.failure);
       
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  Future<void> approveLeaveRequest(
      BuildContext context, int leaveRequestId) async {
        _isloadingTwo = true;
    try {
      final response = await StudentLeaveRequestServices()
          .approveLeaveRequest(leaveRequestId);
      if (response.statusCode == 200) {
        log("Leave request approved successfully!");
        // Show success message
        CustomSnackbar.show(context,
            message: "Leave request approved successfully", type: SnackbarType.success);
        Navigator.pop(context);
      } 
    } catch (e) {
      log(e.toString());
      CustomSnackbar.show(context,
            message: "Failed to approve leave request", type: SnackbarType.failure);
    }
    finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  Future<void> rejectLeaveRequest(
      BuildContext context, int leaveRequestId) async {
        _isloadingTwo = true;
    try {
      final response = await StudentLeaveRequestServices()
          .rejectLeaveRequest(leaveRequestId);
      if (response.statusCode == 200) {
        log("Leave request rejected successfully!");
        // Show success message
        CustomSnackbar.show(context,
            message: "Leave request rejected successfully", type: SnackbarType.success);
        Navigator.pop(context);
      } 
    } catch (e) {
      log(e.toString());
     CustomSnackbar.show(context,
            message: "Failed to reject leave request", type: SnackbarType.failure);
    }
    finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }
}
