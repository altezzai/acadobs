import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';

class SuperAdminServices {
  // **********SCHOOLS********** //
  // Get all schools
  Future<Response> getAllSchools({required int pageNo}) async {
    final response = await ApiServices.get(Urls.schools + '?page=$pageNo');
    return response;
  }

  // Add school
  Future<Response> addSchool(
    context, {
    required String name,
    required String email,
    required String phone,
    required String address,
    required String adminPassword,
  }) async {
     final fileUpload = context.read<FilePickerProvider>().getFile('logo');
    final fileUploadPath = fileUpload?.path;
    final formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "admin_password": adminPassword,
      '_method': 'put',
      if (fileUploadPath != null)
        'file_upload': await MultipartFile.fromFile(fileUploadPath,
            filename: fileUploadPath.split('/').last),
    });
    final response = await ApiServices.post(Urls.schools, formData,
        isFormData: true);
    return response;
  }

  // Edit school
  Future<Response> editSchool(
    context, {
    required int schoolId,
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    final fileUpload = context.read<FilePickerProvider>().getFile('logo');
    final fileUploadPath = fileUpload?.path;
    final formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      '_method': 'put',
      if (fileUploadPath != null)
        'file_upload': await MultipartFile.fromFile(fileUploadPath,
            filename: fileUploadPath.split('/').last),
    });
    final response = await ApiServices.put(
        Urls.schools + '/$schoolId', formData,
        isFormData: true);
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

  // Add a class
  Future<Response> addClass({
    required String year,
    required String division,
    required String classname,
  }) async {
    final response = await ApiServices.post(Urls.classes, {
      'year': year,
      'division': division,
      'classname': classname,
    });
    return response;
  }

  // Edit a class
  Future<Response> editClass({
    required int classId,
    required String year,
    required String division,
    required String classname,
  }) async {
    final response = await ApiServices.put(Urls.classes + '/$classId', {
      'year': year,
      'division': division,
      'classname': classname,
    });
    return response;
  }

  // Delete a class
  Future<Response> deleteClass({required int classId}) async {
    final response = await ApiServices.delete(Urls.classes + '/$classId');
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
