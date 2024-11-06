import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class TeacherLeaveRequestServices {
  // static const String baseUrl = "https://schoolmanagement.altezzai.com/api";

  // static final Dio _dio = Dio(
  //   BaseOptions(
  //     baseUrl: baseUrl,
  //     connectTimeout: const Duration(seconds: 30),
  //     receiveTimeout: const Duration(seconds: 30),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   ),
  // );

  //**************** */ GET request for fetching TeacherLeaveRequests*************
  Future<Response> getTeacherLeaveRequest() async {
    try {
      final Response response = await ApiServices.get('/teachersLeaveRequest');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // // POST request for adding a TeacherLeaveRequest
  // Future<Response> addTeacherLeaveRequest(String endPoint, FormData formData) async {
  //   try {
  //     Response response = await _dio.post(
  //       endPoint,
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "multipart/form-data",
  //         },
  //       ),
  //     );
  //     return response;
  //   } catch (e) {
  //     throw Exception('Failed to add TeacherLeaveRequest: $e');
  //   }
  // }

  // **************Add TeacherLeaveRequest**************
  Future<Response> addNewTeacherLeaveRequest(   {
      required String? teacherId,
      required String? leaveType,
      required String? startDate,
      required String? endDate,
      required String? reasonForLeave,}) async {
    // Create the form data to pass to the API
    final formData = {
      'teacher_id': teacherId,
      'leave_type': leaveType,
      'start_date': startDate,
      'end_date': endDate,
      'reason_for_leave': reasonForLeave,
       // Make sure this date is a string
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/teachersLeaveRequest", formData, isFormData: true);

    return response;
  }
}
