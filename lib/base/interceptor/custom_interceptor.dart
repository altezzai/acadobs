import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_app/base/services/secure_storage_services.dart';

class CustomInterceptor extends Interceptor {
  CustomInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

        
    final String? token = await SecureStorageService.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (options.data is FormData) {
      options.headers['Content-Type'] = 'multipart/form-data';
    } else {
      options.headers['Content-Type'] = 'application/json';
    }

    debugPrint("Request: ${options.method} ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // loadingProvider.setLoading(false);
    debugPrint("Response: ${response.statusCode} ${response.data}");
    super.onResponse(response, handler);
  }
}
