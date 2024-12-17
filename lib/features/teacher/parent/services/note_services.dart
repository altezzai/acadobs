import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class NoteServices {
  Future<Response> addNotes({required List<int> studentId, required int teacherId, required String title, required String description,}) async {
    final formData = {
      'teacher_id':teacherId,
      'studentsId':studentId,
      'note_title': title,
      'note_content': description,
      //  'note_attachment':
    };
    final Response response = await ApiServices.post("/parentNotes", formData, isFormData: true);
    return response;
  }
}