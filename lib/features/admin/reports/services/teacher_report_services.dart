import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class TeacherReportServices {

  Future<Response> getTeacherReports() async{
    final Response response= await ApiServices.get("/teacherReport");
    return response;
  }

 
  
}