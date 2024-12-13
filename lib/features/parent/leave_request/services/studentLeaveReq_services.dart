import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class StudentLeaveRequestServices {
  // GET request for fetching TeacherLeaveRequests
  Future<Response> getStudentLeaveRequest() async {
    try {
      final Response response = await ApiServices.get('/studentsLeaveRequest');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // GET Individual student leave request
  Future<Response> getStudentLeaveRequestById({required int studentId}) async {
    final Response response = await ApiServices.get("/allLeaveRequestForAStudent/$studentId");
    return response;
  }

  // POST request for adding a TeacherLeaveRequest
  Future<Response> addNewStudentLeaveRequest({
    required String studentId,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reasonForLeave,
  }) async {
    // Create the data to send as JSON
    final data = {
      'student_id': studentId,
      'leave_type': leaveType,
      'start_date': startDate,
      'end_date': endDate,
      'reason_for_leave': reasonForLeave,
    };

    try {
      // Call the ApiServices post method with the data as JSON
      final Response response = await ApiServices.post("/studentsLeaveRequest", data);

      return response;
    } catch (e) {
      throw Exception('Failed to add StudentLeaveRequest: $e');
    }
  }
Future<Response> approveLeaveRequest(int leaveRequestId) async {
    final endpoint = '/leave-request/$leaveRequestId/approve';
    try {
      final Response response = await ApiServices.post(endpoint, null);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to approve Leave Request: $e');
    }
  }

  Future<Response> rejectLeaveRequest(int leaveRequestId) async {
    final endpoint = '/leave-request/$leaveRequestId/reject';
    try {
      final Response response = await ApiServices.post(endpoint, null);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to approve Leave Request: $e');
    }
  }

}
