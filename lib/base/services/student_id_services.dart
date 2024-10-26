import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class StudentIdServices {
  // students from class and division
  Future<Response> getStudentsFromClassAndDivision(
      {required String className, required String section}) async {
    final Response response = await ApiServices.get(
      "/studentsNameAndIdClass-division?class=${className}&section=${section}",
    );
    return response;
  }
}
