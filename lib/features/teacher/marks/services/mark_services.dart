import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class MarkServices {
  // add marks
  Future<Response>addMarks ({required String date, required String className, required String subject, required String section,required String totalMarks, required String recordedBy, required List<Map<String, dynamic>> students})async{
    final Response response = await ApiServices.post("/internalmarks", {
      "date":date,
      "class_grade":className,
      "section":section,
      "subject":subject,
      "total_marks":totalMarks,
      "recorded_by":recordedBy,
      "students":students
    });
    return response;
  }
}