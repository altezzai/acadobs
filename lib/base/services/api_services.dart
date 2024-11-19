import 'package:dio/dio.dart';
import 'package:school_app/base/utils/urls.dart';

class ApiServices {
  static const String baseUrl = "https://schoolmanagement.altezzai.com/api";

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      followRedirects: true, // Follow redirects automatically
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // GET request
  static Future<Response> get(String endpoint,{dynamic data}) async {
    try {
      final Response response = await _dio.get(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // POST request with dynamic data type (JSON or FormData)
  static Future<Response> post(String endpoint, dynamic data,
      {bool isFormData = false}) async {
    try {
      dynamic requestData = isFormData && data is Map<String, dynamic>
          ? FormData.fromMap(data)
          : data;

      final Response response = await _dio.post(endpoint, data: requestData);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  // PUT request with dynamic data type (JSON or FormData)
  static Future<Response> put(String endpoint, dynamic data,
      {bool isFormData = false}) async {
    try {
      dynamic requestData = isFormData && data is Map<String, dynamic>
          ? FormData.fromMap(data)
          : data;

      final response = await _dio.put(endpoint, data: requestData);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  // DELETE request
  static Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}


