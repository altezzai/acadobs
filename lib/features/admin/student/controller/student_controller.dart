import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/services/studentservice.dart';

class SampleController extends ChangeNotifier {
  List<StudentData> _studentData = [];
  List<StudentData> get studentData => _studentData;

  // Fetch student details (GET request)
  Future<void> getStudentDetails() async {
    try {
      final response = await SampleServices().get("/students");
      log(response.data);
      if (response.statusCode == 200) {
        _studentData = (response.data as List<dynamic>)
            .map((result) => StudentData.fromJson(result))
            .toList();

        notifyListeners(); // Notify UI about data changes
      }
    } catch (e) {
      print(e);
    }
  }

  // Add student details (POST request)
  Future<void> addStudent(StudentData student) async {
    try {
      FormData formData = FormData.fromMap({
        "full_name": student.fullName,
        "date_of_birth": student.dateOfBirth,
        "gender": student.gender,
        "class": student.studentDatumClass,
        "section": student.section,
        "roll_number": student.rollNumber,
        "admission_number": student.admissionNumber,
        "aadhaar_number": student.aadhaarNumber,
        "residential_address": student.residentialAddress,
        "contact_number": student.contactNumber,
        "email": student.email,
        "father_full_name": student.fatherFullName,
        "mother_full_name": student.motherFullName,
        "blood_group": student.bloodGroup,
        // Add other fields as needed
      });

      // Sending the POST request to add a student
      final response = await SampleServices().addStudent("/students", formData);

      // Check if the request was successful
      if (response.statusCode == 201) {
        print("Student added successfully: ${response.data}");
        // Optionally refresh the student list after adding a new student
        await getStudentDetails();
      } else {
        print("Failed to add student: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding student: $e");
    }
  }
}
