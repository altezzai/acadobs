//import 'dart:io';

import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class StudentServices {
  // GET student
  Future<Response> getStudent() async {
    try {
      final Response response = await ApiServices.get('/students');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> getIndividualStudentDetails({required int studentId}) async {
    try {
      final Response response = await ApiServices.get('/students/$studentId');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

// GET homework
  Future<Response> getStudentHomework({required int studentId}) async {
    final Response response =
        await ApiServices.get("/getStudentHomeworks/$studentId");
    return response;
  }

  // Add student
  Future<Response> addNewStudent({
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
    String? studentPhotoPath,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      "full_name": fullName,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "class": studentClass,
      "section": section,
      "roll_number": rollNumber,
      "admission_number": admissionNumber,
      "aadhaar_number": aadhaarNumber,
      "residential_address": residentialAddress,
      "contact_number": contactNumber,
      "email": email,
      "father_full_name": fatherFullName,
      "mother_full_name": motherFullName,
      "blood_group": bloodGroup,
      if (studentPhotoPath != null) // Only include if the photo is provided
        "student_photo": await MultipartFile.fromFile(studentPhotoPath, filename: studentPhotoPath.split('/').last),
    

    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/students", formData, isFormData: true);

    return response;
  }

  // student by class division
  Future<Response> getStudentsClassAndDivision(
      {required String classname, required String section}) async {
    try {
      final Response response = await ApiServices.get(
          '/studentsByClassDivision?class=$classname&section=$section');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // GET parent
  Future<Response> getParent() async {
    try {
      final Response response = await ApiServices.get('/searchParents');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // student by class division
  Future<Response> getParentByClassAndDivision(
      {required String classname, required String section}) async {
    try {
      final Response response = await ApiServices.get(
          '/getParentNameAndImageByClsAnDiv?class=$classname&section=$section');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // day attendance status
  Future<Response> getDayAttendance(
      {required String studentId, required String date}) async {
    final Response response = await ApiServices.get(
        "/getStudentAttendanceADay/$studentId?date=$date");
    return response;
  }
}
