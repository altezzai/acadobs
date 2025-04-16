import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/base/utils/urls.dart';

class SubjectServices {
  // GET request for fetching subjects
  Future<Response> getsubject() async {
    try {
      final Response response = await ApiServices.get(Urls.subject);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // POST request for adding a subject
  Future<Response> addNewSubject({
    required String subject,
    required String description,
  }) async {
    // Create the data to send as JSON
    final data = {
      'subject': subject,
      'description': description,
    };

    // Call the ApiServices post method with the data as JSON
    final Response response = await ApiServices.post("/subjects", data);

    return response;
  }

  Future<Response> editSubject({
    required int subjectid,
    required String subject,
    required String description,
  }) async {
    // Create the data to send as JSON
    final data = {
      //'subjectid':subjectid,
      'subject': subject,
      'description': description,
    };

    try {
      // Call the ApiServices post method with the data as JSON
      final Response response =
          await ApiServices.put("/subjects/$subjectid", data);

      return response;
    } catch (e) {
      throw Exception('Failed to add subject: $e');
    }
  }

  //delete subject
  Future<Response> deleteSubjects({
    required int subjectid,
  }) async {
    final Response response = await ApiServices.delete("/subjects/$subjectid");
    return response;
  }
}
