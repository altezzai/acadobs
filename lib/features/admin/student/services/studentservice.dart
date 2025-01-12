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

// GET individual student details
  Future<Response> getIndividualStudentDetails({required int studentId}) async {
    try {
      final Response response = await ApiServices.get('/students/$studentId');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Get students by parent email
  Future<Response> getStudentsByParentEmail(
      {required String parentEmail}) async {
    final Response response =
        await ApiServices.get("/showByParenteEmail/$parentEmail");
    return response;
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
    required String guardianFullName,
    required String bloodGroup,
    required String parentEmail,
    required String fatherContactNumber,
    required String motherContactNumber,
    required String studentPhotoPath,
    String? aadhaarCard,
    required String fatherMotherPhoto,
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
      "guardian_full_name": guardianFullName,
      "blood_group": bloodGroup,
      "parent_email": parentEmail,
      "father_contact_number": fatherContactNumber,
      "mother_contact_number": motherContactNumber,
      // Only include if the photo is provided
      "student_photo": await MultipartFile.fromFile(studentPhotoPath,
          filename: studentPhotoPath.split('/').last),
      if (aadhaarCard != null)
        "aadhaar_card": await MultipartFile.fromFile(aadhaarCard,
            filename: aadhaarCard.split('/').last),
      "father_mother_photo": await MultipartFile.fromFile(fatherMotherPhoto,
          filename: fatherMotherPhoto.split('/').last)
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/students/", formData, isFormData: true);

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
        "/getStudentAttendanceADay/?student_id=$studentId&date=$date");
    return response;
  }

  // Update student
  Future<Response> updateStudent({
    required int studentId,
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String studentClass,
    required String section,
    required String rollNumber,
    // required String admissionNumber,
    required String aadhaarNumber,
    required String residentialAddress,
    required String contactNumber,
    required String email,
    required String fatherFullName,
    required String motherFullName,
    required String guardianFullName,
    // required String bloodGroup,
    required String parentEmail,
    // required String fatherContactNumber,
    // required String motherContactNumber,

    // required String studentPhotoPath,
    // String? aadhaarCard,
    required String fatherMotherPhoto,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      "full_name": fullName,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "class": studentClass,
      "section": section,
      "roll_number": rollNumber,
      // "admission_number": admissionNumber,
      "aadhaar_number": aadhaarNumber,
      "residential_address": residentialAddress,
      "contact_number": contactNumber,
      "email": email,
      "father_full_name": fatherFullName,
      "mother_full_name": motherFullName,
      "guardian_full_name": guardianFullName,
      // "blood_group": bloodGroup,
      "parent_email": parentEmail,
      // "father_contact_number":fatherContactNumber,
      // "mother_contact_number":motherContactNumber,
      // // Only include if the photo is provided
      // "student_photo": await MultipartFile.fromFile(studentPhotoPath,
      //     filename: studentPhotoPath.split('/').last),
      // if (aadhaarCard!= null)"aadhaar_card": await MultipartFile.fromFile(aadhaarCard,
      //     filename: aadhaarCard.split('/').last),
      "father_mother_photo": await MultipartFile.fromFile(fatherMotherPhoto,
          filename: fatherMotherPhoto.split('/').last)
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response = await ApiServices.put(
        "/students/$studentId", formData,
        isFormData: true);

    return response;
  }

  // *****Check Parent Email Usage************
  Future<Response> checkParentEmailUsage({required String email}) async {
    final response =
        await ApiServices.get("/checkParentEmailUsage?parent_email=$email");
    return response;
  }
}
