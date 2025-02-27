import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class AttendanceServices {
  // check attendance
  Future<Response> checkAttendance(
      {required String className,
      required String section,
      required String date,
      required String period}) async {
    final response = await ApiServices.get(
        "/attendanceCheck?class=${className}&section=${section}&date=${date}&period_number=${period}");
    return response;
  }

  // submit attendance
  Future<Response> submitAttendance(Map<String, dynamic> attendanceData) async {
    final response = await ApiServices.post(
      '/attendance',
      attendanceData,
    );
    return response;
  }

  //  Get daily attendance by teacherId
  Future<Response> getDailyAttendanceByTeacher({
    required int teacherId,
    required String date,
  }) async {
    final response = await ApiServices.get(
        "/getTeacherAttendanceRecords/$teacherId?date=$date");
    return response;
  }
}
