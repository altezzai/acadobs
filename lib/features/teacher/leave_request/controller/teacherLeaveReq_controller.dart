import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/teacher/leave_request/model/teacherLeaveReq_model.dart';
import 'package:school_app/features/teacher/leave_request/services/teacherLeaveReq_services.dart';

class TeacherLeaveRequestController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  List<TeacherLeaveRequest> _teachersLeaveRequest = [];
  List<TeacherLeaveRequest> get teachersLeaveRequest => _teachersLeaveRequest;

  List<TeacherLeaveRequest> _teacherIndividualLeaveRequest = [];
  List<TeacherLeaveRequest> get teacherIndividualLeaveRequest =>
      _teacherIndividualLeaveRequest;

// **********Get all teachers*****************
  Future<void> getTeacherLeaverequests() async {
    _isloading = true;
    try {
      final response =
          await TeacherLeaveRequestServices().getTeacherLeaveRequest();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
        _teachersLeaveRequest.clear();
        _teachersLeaveRequest = (response.data as List<dynamic>)
            .map((result) => TeacherLeaveRequest.fromJson(result))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Get individual teacher leave requests
  Future<void> getIndividualTeacherLeaverequests() async {
    _isloading = true;
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await TeacherLeaveRequestServices()
          .getTeacherLeaveRequestById(teacherId: teacherId);
      print("***********${response.statusCode}");
      log(response.data.toString());
      if (response.statusCode == 200) {
        _teacherIndividualLeaveRequest.clear();
        _teacherIndividualLeaveRequest = (response.data as List<dynamic>)
            .map((result) => TeacherLeaveRequest.fromJson(result))
            .toList();
        log("Teachers leaves ===== ${_teacherIndividualLeaveRequest.toString()}");
      }
    } catch (e) {
      print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Future<void> addTeacher() async {
  //   try {
  //     // Use the formData you've already defined
  //     Response response =
  //         await TeacherLeaveRequstServices().addTeacher("/teachers", formData);
  //     if (response.statusCode == 201) {
  //       print("Teacher added successfully: ${response.data}");
  //     } else {
  //       print("Failed to add teacher: ${response.statusCode}");
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

  // ********Add New Teacher************
  Future<void> addNewTeacherLeaveRequest(
    BuildContext context, {
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reasonForLeave,
  }) async {
    _isloadingTwo = true;
    try {
      //  _isloading = false;
      final teacherId = await SecureStorageService.getUserId();
      final response =
          await TeacherLeaveRequestServices().addNewTeacherLeaveRequest(
        teacherId: teacherId.toString(),
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reasonForLeave: reasonForLeave,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>>>>>>>>Teacher Leave Request Added}");
        // Show success message using Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Leave request submitted successfully!'),
            backgroundColor: Colors.green, // Set color for success
          ),
        );
        await getIndividualTeacherLeaverequests();
        // Navigate to the desired route
        context.pushNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.teacher);
      } else {
        // Handle failure case here if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit leave request. Please try again.'),
            backgroundColor: Colors.red, // Set color for error
          ),
        );
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
    try {
      final response = await TeacherLeaveRequestServices()
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
  }

  Future<void> rejectLeaveRequest(
      BuildContext context, int leaveRequestId) async {
    try {
      final response = await TeacherLeaveRequestServices()
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
  }
}
