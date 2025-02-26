import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_app/base/services/api_services.dart';

class HomeworkServices {
  Future<Response> getHomework() async {
    final Response response = await ApiServices.get("/homework");
    return response;
  }

  // Add homework
  Future<Response> addHomework(
    BuildContext context, {
    required int teacherId,
    required String class_grade,
    required String section,
    required int subjectId,
    required String assignment_title,
    required String description,
    required String assigned_date,
    required String due_date,
    required String submission_type,
    required String total_marks,
    required String status,
    required List<int> studentsId,
  }) async {
    // Create FormData to pass to the API
    final formData = {
      'teacher_id': teacherId,
      'class_grade': class_grade,
      'section': section,
      'subject': subjectId,
      'assignment_title': assignment_title,
      'description': description,
      'assigned_date': assigned_date,
      'due_date': due_date,
      'submission_type': submission_type,
      'total_marks': total_marks,
      'status': status,
      'studentsId[]': studentsId
    };

    // Call the ApiServices post method with FormData and isFormData: true
    final Response response =
        await ApiServices.post("/homework", formData, isFormData: true);

    return response;
  }

  // Edit homework
  Future<Response> editHomework(
    BuildContext context, {
      required int homeworkId,
    required int teacherId,
    required String class_grade,
    required String section,
    required int subjectId,
    required String assignment_title,
    required String description,
    required String assigned_date,
    required String due_date,
    required String submission_type,
    required String total_marks,
    required String status,
    required List<int> studentsId,
  }) async {
    // Create FormData to pass to the API
    final formData = {
      'teacher_id': teacherId,
      'class_grade': class_grade,
      'section': section,
      'subject': subjectId,
      'assignment_title': assignment_title,
      'description': description,
      'assigned_date': assigned_date,
      'due_date': due_date,
      'submission_type': submission_type,
      'total_marks': total_marks,
      'status': status,
      'studentsId[]': studentsId,
      '_method':'put',
    };

    // Call the ApiServices post method with FormData and isFormData: true
    final Response response =
        await ApiServices.post("/homework/$homeworkId", formData, isFormData: true);

    return response;
  }

  // ********** get homework by teacherid*****************
   Future<Response> getHomeworkByTeacherId({required String teacherId}) async {
    final Response response = await ApiServices.get("/getHomeworkByTeacher/$teacherId");
    return response;
  }

  // Delete Homework
   Future<Response> deleteHomework({required int homeworkId}) async {
    final Response response = await ApiServices.delete("/homework/$homeworkId");
    return response;
  }

}
