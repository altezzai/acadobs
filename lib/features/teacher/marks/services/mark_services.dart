import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class MarkServices {
  Future<Response> addMarks({
    required String date,
    required String className,
    required String subject,
    required String section,
    required String title,
    required int totalMarks,
    required int recordedBy,
    required List<Map<String, dynamic>> students,
  }) async {
    final data = {
      "date": date,
      "class_grade": className,
      "section": section,
      "title": title,
      "subject": subject,
      "total_marks": totalMarks,
      "recorded_by": recordedBy,
      "students": students,
    };

    final Response response = await ApiServices.post("/internalmarks", data);
    return response;
  }
}
