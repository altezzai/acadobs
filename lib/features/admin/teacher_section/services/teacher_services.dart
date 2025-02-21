import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class TeacherServices {
  //**************** */ GET request for fetching teachers*************
  Future<Response> getTeacher() async {
    try {
      final Response response = await ApiServices.get('/teachers');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // GET individual teacher details
  Future<Response> getIndividualTeacherDetails({required int teacherId}) async {
    try {
      final Response response = await ApiServices.get('/teachers/$teacherId');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // **************Add Teacher**************
  Future<Response> addNewTeacher(
      {required String fullName,
      required String dateOfBirth,
      required String gender,
      required String address,
      required String contactNumber,
      required String emailAddress,
      required String profilePhoto}) async {
    // Create the form data to pass to the API
    final formData = {
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'address': address,
      'contact_number': contactNumber,
      'email': emailAddress,
      // Only include if the photo is provided
      "profile_photo": await MultipartFile.fromFile(profilePhoto,
          filename:
              profilePhoto.split('/').last) // Make sure this date is a string
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/teachers", formData, isFormData: true);

    return response;
  }

// *****Get teacher activities(attendance)
  Future<Response> getActivities({required int teacherId}) async {
    try {
      final Response response =
          await ApiServices.get('/getTeacherActivities/$teacherId');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
