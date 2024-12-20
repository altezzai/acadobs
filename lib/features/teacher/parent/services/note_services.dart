import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class NoteServices {

  // *************Add Notes to Students/Parents*************
  Future<Response> addNotes({
    required List<int> studentId,
    required int teacherId,
    required String title,
    required String description,
  }) async {
    final formData = {
      'teacher_id': teacherId,
      'studentsId[]': studentId,
      'note_title': title,
      'note_content': description,
      //  'note_attachment':
    };
    final Response response =
        await ApiServices.post("/parentNotes", formData, isFormData: true);
    return response;
  }

  // ***********Get Notes by TeacherId**************
  Future<Response> getNotesByTeacherId({required int teacherId}) async{
    final response = await ApiServices.get("/getParentNotesByTeacherId/$teacherId");
    return response;
  }

  // **********Get Note by Id ********************
  Future<Response> getNoteById({required int noteId}) async{
    final response = await ApiServices.get("/parentNotes/$noteId");
    return response;
  }

  // **********Get Note by Student Id ********************
  Future<Response> getNoteByStudentId({required int studentId}) async{
    final response = await ApiServices.get("/getParentNotesByStudentId/$studentId");
    return response;
  }

  // **********Unviewed notes count by parent*****
   Future<Response> getUnViewedNotesCountByStudentId({required int studentId}) async{
    final response = await ApiServices.get("/countUnviewedParentNotesByStudentId/$studentId");
    return response;
  }

  // *********Mark Parent note as viewed*************
  Future<Response> markParentNoteAsViewed({required int studentId, required int parentNoteId}) async {
    final response = await ApiServices.post("/markParentNoteAsViewed", {
      "student_id":studentId,
      "parent_note_id":parentNoteId
    });
    return response;
  }
}
