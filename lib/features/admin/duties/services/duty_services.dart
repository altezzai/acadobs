import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class DutyServices {
  Future<Response> getDuties() async {
    final Response response = await ApiServices.get("/duties");
    return response;
  }

// get assigned teachers
  Future<Response> getAssignedDuties({required String dutyid}) async {
    final Response response = await ApiServices.get("/duties/$dutyid");
    return response;
  }

  // get teacher duties
  Future<Response> getTeacherDuties({required int teacherid}) async {
    final Response response =
        await ApiServices.get("/getTeacherDuties/$teacherid");
    return response;
  }

   // get teacher Single duty
  Future<Response> getTeacherSingleDuty({required int teacherId, required int dutyId}) async {
    final Response response =
        await ApiServices.get("/getTeacher/$teacherId/sigleDuty/$dutyId");
    return response;
  }

  Future<Response> addDuty({
    required String duty_title,
    required String description,
    required String status,
    required String remark,
    required List<int> teachers,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      'duty_title': duty_title,
      'description': description,
      'status': status,
      'remark': remark,
      'teachers[]': teachers
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/duties", formData, isFormData: true);

    return response;
  }

  Future<Response> progressDuty({
    required int duty_id,
  }) async {
    // Create the form data to pass to the API
    final formData = {'duty_id': duty_id};

    // Call the ApiServices post method with formData and isFormData: true
    final Response response = await ApiServices.post(
        "/inProgressTeacherDuty/$duty_id", formData,
        isFormData: true);

    return response;
  }

  Future<Response> completeDuty({
    required int duty_id,
  }) async {
    // Create the form data to pass to the API
    final formData = {'duty_id': duty_id};

    // Call the ApiServices post method with formData and isFormData: true
    final Response response = await ApiServices.post(
        "/completeTeacherDuty/$duty_id", formData,
        isFormData: true);

    return response;
  }
}
