import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class ExamServices {
  // Get Exam marks
  Future<Response> getExamMarks({required int studentId}) async {
    final Response response =
        await ApiServices.get("/getAStudentmarks/$studentId");
    return response;
  }
}
