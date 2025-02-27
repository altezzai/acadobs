import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class TeacherServices {
  //**************** / GET request for fetching teachers************
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

// **********Add teacher
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
  Future<Response> getActivities({required int teacherId, required String date}) async {
    try {
      final Response response =
          await ApiServices.get('/getTeacherActivities/$teacherId?date=$date');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  //********** */ Edit Teacher

  Future<Response> editTeacher({
    required int teacherId,
    required String fullName,
    required String email,
    required String address,
    required String contactNumber,
    String? profilePhoto,
  }) async {
    // Define formData as Map<String, dynamic> to allow multiple types.
    final Map<String, dynamic> formData = {
      'full_name': fullName,
      'email': email,
      'address': address,
      'contact_number': contactNumber,
      "_method": "put",
    };

    // If profilePhoto is provided and not empty, add it as a MultipartFile.
    if (profilePhoto != null && profilePhoto.isNotEmpty) {
      formData['profile_photo'] = await MultipartFile.fromFile(
        profilePhoto,
        filename: profilePhoto.split('/').last,
      );
    }

    // Call the ApiServices.put method with the form data.
    final Response response = await ApiServices.post(
      "/teachers/$teacherId",
      formData,
      isFormData: true,
    );

    return response;
  }

  // **********8Delete teacher
  Future<Response> deleteTeacher({required int teacherId}) async {
    final Response response = await ApiServices.delete("/teachers/$teacherId");
    return response;
  }
}
