//import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';

class NoticeServices {
  // Get Notices
  Future<Response> getNotices() async {
    final Response response = await ApiServices.get("/notices");
    return response;
  }

  // Get events
  Future<Response> getEvents() async {
    final Response response = await ApiServices.get("/events");
    return response;
  }

  // Add Notices
  Future<Response> addNotice(
    BuildContext context, {
    required String audience_type,
    required String title,
    required String description,
    required String date,
    String? className,
    String? division,
  }) async {
    final fileUpload =
        context.read<FilePickerProvider>().getFile('notice file');
    final fileUploadPath = fileUpload?.path;
    final formData = FormData.fromMap({
      'audience_type': audience_type,
      'class': className,
      'division': division,
      'title': title,
      'description': description,
      'date': date,
      if (fileUploadPath != null && fileUploadPath.isNotEmpty)
        'file_upload': await MultipartFile.fromFile(
          fileUploadPath,
          filename: fileUploadPath.split('/').last,
        ),
    });
    final Response response =
        await ApiServices.post("/notices", formData, isFormData: true);

    return response;
  }

  // Edit Notice
  Future<Response> editNotice(
    BuildContext context, {
    required int noticeId,
    required String audience_type,
    required String title,
    required String description,
    required String date,
    String? className,
    String? division,
  }) async {
    final fileUpload =
        context.read<FilePickerProvider>().getFile('notice file');
    final fileUploadPath = fileUpload?.path;
    final formData = FormData.fromMap({
      'audience_type': audience_type,
      'class': className,
      'division': division,
      'title': title,
      'description': description,
      'date': date,
      "_method": "put",
      if (fileUploadPath != null && fileUploadPath.isNotEmpty)
        'file_upload': await MultipartFile.fromFile(
          fileUploadPath,
          filename: fileUploadPath.split('/').last,
        ),
    });
    final Response response = await ApiServices.post(
        "/notices/$noticeId", formData,
        isFormData: true);

    return response;
  }

// Add event
  Future<Response> addEvent(
      {required String title,
      required String description,
      required String date,
      required List<XFile> images}) async {
    // Create the form data to pass to the API
    final formData = {
      'title': title,
      'description': description,
      'event_date': date, // Make sure this date is a string
      // if (images != null)
      'images[]': await Future.wait(
        images.map(
          (image) async => await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        ),
      ),
    };
    final Response response =
        await ApiServices.post("/events", formData, isFormData: true);
    return response;
  }

  // Edit event
  Future<Response> editEvent(
      {
        required int eventId,
        required String title,
      required String description,
      required String date,
      required List<XFile> images}) async {
    // Create the form data to pass to the API
    final formData = {
      'title': title,
      'description': description,
      'event_date': date,
      "_method": "put",
      'images[]': await Future.wait(
        images.map(
          (image) async => await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        ),
      ),
    };
    final Response response =
        await ApiServices.post("/events/$eventId", formData, isFormData: true);
    return response;
  }

  // Delete Notices
  Future<Response> deleteNotices({required int noticeId}) async {
    final Response response = await ApiServices.delete("/notices/$noticeId");
    return response;
  }

  // Delete events
  Future<Response> deleteEvents({required int eventId}) async {
    final Response response = await ApiServices.delete("/events/$eventId");
    return response;
  }
}
