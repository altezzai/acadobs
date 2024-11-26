import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_app/base/services/api_services.dart';

class HomeworkServices {
  Future<Response> getHomework() async {
    final Response response = await ApiServices.get("/homework");
    return response;
  }

  // add homework
  Future<Response> addHomework(
    BuildContext context, {
    required String class_grade,
    required String section,
    required String subject,
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
    final formData = FormData.fromMap({
      'teacher_id': 1,
      'class_grade': class_grade,
      'section': section,
      'subject': subject,
      'assignment_title': assignment_title,
      'description': description,
      'assigned_date': assigned_date,
      'due_date': due_date,
      'submission_type': submission_type,
      'total_marks': total_marks,
      'status': status,
      'studentsId': studentsId

    });

    // Call the ApiServices post method with FormData and isFormData: true
    final Response response =
        await ApiServices.post("/homework", formData, isFormData: true);

    return response;
  }
}
