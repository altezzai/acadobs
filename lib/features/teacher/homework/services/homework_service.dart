import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class HomeworkServices {
  Future<Response> getHomework() async {
    final Response response = await ApiServices.get("/homework");
    return response;
  }
}
