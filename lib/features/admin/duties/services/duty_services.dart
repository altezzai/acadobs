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
      'teachers': teachers
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/duties", formData, isFormData: true);

    return response;
  }
}
