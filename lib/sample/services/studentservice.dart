import 'package:dio/dio.dart';

class SampleServices {
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

  // GET request
  Future<Response> get(String endpoint) async {
    try {
      final Response response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // POST request
  Future<Response> addStudent(String endpoint, FormData formData) async {
    try {
      Response response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
