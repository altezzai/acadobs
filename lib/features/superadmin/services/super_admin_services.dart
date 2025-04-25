import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/base/utils/urls.dart';

class SuperAdminServices {
  // **********SCHOOLS********** //
  // Get all schools
  Future<Response> getAllSchools({required int pageNo}) async {
    final response = await ApiServices.get(Urls.schools + '?page=$pageNo');
    return response;
  }

  // Delete a school
  Future<Response> deleteSchool({required int schoolId}) async {
    final response = await ApiServices.delete(Urls.schools + '/$schoolId');
    return response;
  }

  // **********CLASSES********* //
  // Get all classes
  Future<Response> getAllClasses({required int pageNo}) async {
    final response = await ApiServices.get(Urls.classes + '?page=$pageNo');
    return response;
  }

  // **********SUBJECTS********* //
  // Get all subjects
  Future<Response> getAllSubjects({required int pageNo}) async {
    final response = await ApiServices.get(Urls.subjects + '?page=$pageNo');
    return response;
  }
  // Add a subject
  Future<Response> addSubject({
    required String subjectName,
    required String classRange,
    
  }) async {
    final response = await ApiServices.post(Urls.subjects, {
      'subject_name': subjectName,
      'class_range': classRange,
    });
    return response;
  }
  // Edit a subject
  Future<Response> editSubject({
    required int subjectId,
    required String subjectName,
    required String classRange,
  }) async {
    final response = await ApiServices.put(Urls.subjects + '/$subjectId', {
      'subject_name': subjectName,
      'class_range': classRange,
    });
    return response;
  }
   // Delete a subject
  Future<Response> deleteSubject({required int subjectId}) async {
    final response = await ApiServices.delete(Urls.subjects + '/$subjectId');
    return response;
  }
}
