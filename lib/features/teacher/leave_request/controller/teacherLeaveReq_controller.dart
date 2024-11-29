import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/teacher/leave_request/model/teacherLeaveReq_model.dart';
import 'package:school_app/features/teacher/leave_request/services/teacherLeaveReq_services.dart';

class TeacherLeaveRequestController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<TeacherLeaveRequest> _teachersLeaveRequest = [];
  List<TeacherLeaveRequest> get teachersLeaveRequest => _teachersLeaveRequest;

// **********Get all teachers*****************
  Future<void> getTeacherLeaverequests() async {
    _isloading = true;
    try {
      final response =
          await TeacherLeaveRequestServices().getTeacherLeaveRequest();
      print("***********${response.statusCode}");
      print(response.toString());
      if (response.statusCode == 200) {
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
    required String teacherId,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reasonForLeave,
  }) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      //  _isloading = false;
      final response =
          await TeacherLeaveRequestServices().addNewTeacherLeaveRequest(
        teacherId: teacherId,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reasonForLeave: reasonForLeave,
      );
      if (response.statusCode == 201) {
        log(">>>>>>>>>>>>>Teacher Leave Request Added}");
        // Show success message using Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Leave request submitted successfully!'),
            backgroundColor: Colors.green, // Set color for success
          ),
        );
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
      loadingProvider.setLoading(false); // End loader
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Leave request approved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to approve leave request.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while approving leave request.'),
          backgroundColor: Colors.red,
        ),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Leave request rejected successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to reject leave request.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while rejecting leave request.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
