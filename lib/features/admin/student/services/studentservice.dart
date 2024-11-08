import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class StudentServices {
  // GET student
  Future<Response> getStudent() async {
    try {
      final Response response = await ApiServices.get('/students');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Add student
  Future<Response> addNewStudent({
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String studentClass,
    required String section,
    required String rollNumber,
    required String admissionNumber,
    required String aadhaarNumber,
    required String residentialAddress,
    required String contactNumber,
    required String email,
    required String fatherFullName,
    required String motherFullName,
    required String bloodGroup,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      "full_name": fullName,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "class": studentClass,
      "section": section,
      "roll_number": rollNumber,
      "admission_number": admissionNumber,
      "aadhaar_number": aadhaarNumber,
      "residential_address": residentialAddress,
      "contact_number": contactNumber,
      "email": email,
      "father_full_name": fatherFullName,
      "mother_full_name": motherFullName,
      "blood_group": bloodGroup,
    };
    
    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/students", formData, isFormData: true);

    return response;
  }
}



// class SampleServices {
//   static const String baseUrl = "https://schoolmanagement.altezzai.com/api";

//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: baseUrl,
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     ),
//   );

//   // GET request
//   Future<Response> get(String endpoint) async {
//     try {
//       final Response response = await _dio.get(endpoint);
//       return response;
//     } on DioException catch (e) {
//       throw Exception('Failed to load data: $e');
//     }
//   }

//   // POST request
//   Future<Response> addStudent(String endpoint, FormData formData) async {
//     try {
//       Response response = await _dio.post(
//         endpoint,
//         data: formData,
//         options: Options(
//           headers: {
//             "Content-Type": "multipart/form-data",
//           },
//         ),
//       );
//       return response;
//     } on DioException catch (e) {
//       throw Exception('Failed to post data: $e');
//     }
//   }
// }
