import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/loading_provider.dart';

import 'package:school_app/features/parent/leave_request/model/studentLeaveReq_model.dart';
import 'package:school_app/features/parent/leave_request/services/studentLeaveReq_services.dart';

class StudentLeaveRequestController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<StudentLeaveRequest> _studentsLeaveRequest = [];
  List<StudentLeaveRequest> get studentsLeaveRequest => _studentsLeaveRequest;

// **********Get all students*****************
  Future<void> getStudentDetails() async {
    _isloading = true;
    try {
      final response = await StudentLeaveRequestServices().getStudentLeaveRequest();
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
  Future<void> addNewStudentLeaveRequest(BuildContext context,
      {      
      required String studentId,
      required String leaveType,
      required String startDate,
      required String endDate,
      required String reasonForLeave,}) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      //  _isloading = false;
      final response = await StudentLeaveRequestServices().addNewStudentLeaveRequest(
          studentId: studentId,
          leaveType: leaveType,
          startDate: startDate,
          endDate: endDate,
          reasonForLeave: reasonForLeave,
          );
      if (response.statusCode == 201) {
      log(">>>>>>>>>>>>>Student Leave Request Added}");
      // Show success message using Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Leave request submitted successfully!'),
          backgroundColor: Colors.green, // Set color for success
        ),
      );
      // Navigate to the desired route
     context.goNamed(AppRouteConst.ParentHomeRouteName);
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
}
