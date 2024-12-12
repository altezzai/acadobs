import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class TeacherReportServices {

  Future<Response> getTeacherReport() async{
    final Response response= await ApiServices.get("/teacherReport");
    return response;
  }

 Future<Response> getTeacherReportByNameAndDate({required String teacherName, required String startDate,required String endDate}) async {
    final Response response = await ApiServices.get("/teacherReport/?teacher_name=$teacherName&start_date=$startDate&end_date=$endDate");
    return response;
  }

  
}