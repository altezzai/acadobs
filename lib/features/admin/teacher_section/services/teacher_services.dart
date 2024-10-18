import 'package:dio/dio.dart';

class TeacherServices {
  static const String baseUrl = "https://schoolmanagement.altezzai.com/api";

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // GET request for fetching teachers
  Future<Response> getTeacher(String endpoint) async {
    try {
      final Response response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // POST request for adding a teacher
  Future<Response> addTeacher(String endPoint, FormData formData) async {
    try {
      Response response = await _dio.post(
        endPoint,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to add teacher: $e');
    }
  }
}
