import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class AttendanceServices {
  
  // submit attendance
  Future<Response> submitAttendance(Map<String, dynamic> attendanceData) async {
    final response = await ApiServices.post(
      '/attendance',
      attendanceData,
    );
    return response;
  }
}
