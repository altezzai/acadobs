import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class TeacherLeaveRequestServices {
  // GET request for fetching TeacherLeaveRequests
  Future<Response> getTeacherLeaveRequest() async {
    try {
      final Response response = await ApiServices.get('/teachersLeaveRequest');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // POST request for adding a TeacherLeaveRequest
  Future<Response> addNewTeacherLeaveRequest({
    required String teacherId,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reasonForLeave,
  }) async {
    // Create the data to send as JSON
    final data = {
      'teacher_id': teacherId,
      'leave_type': leaveType,
      'start_date': startDate,
      'end_date': endDate,
      'reason_for_leave': reasonForLeave,
    };

    try {
      // Call the ApiServices post method with the data as JSON
      final Response response = await ApiServices.post("/teachersLeaveRequest", data);

      return response;
    } catch (e) {
      throw Exception('Failed to add TeacherLeaveRequest: $e');
    }
  }
}
