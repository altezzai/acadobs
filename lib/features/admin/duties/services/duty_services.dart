import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class DutyServices {
  Future<Response> getDuties() async {
    final Response response = await ApiServices.get("/duties");
    return response;
  }
}
