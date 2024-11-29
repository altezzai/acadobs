import 'dart:developer';

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
    final fileProvider =
        Provider.of<FilePickerProvider>(context, listen: false);
    // Create the form data to pass to the API
    final formData = FormData.fromMap({
      'audience_type': audience_type,
      'class': className,
      'division': division,
      'title': title,
      'description': description,
      'date': date, // Make sure this date is a string
      'file_upload':
          await MultipartFile.fromFile(fileProvider.selectedFile!.path!)
    });

    // Log the file details
    if (fileProvider.selectedFile != null) {
      log('File selected: ${fileProvider.selectedFile!.path}');
      log('File name: ${fileProvider.selectedFile!.name}');
    } else {
      log('No file selected');
    }

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/notices", formData, isFormData: true);

    return response;
  }

// Add event
  Future<Response> addEvent(
      {required String title,
      required String description,
      required String date,
      required List<XFile> images}) async {
    // Create the form data to pass to the API
    final formData = FormData.fromMap({
      'title': title,
      'description': description,
      'event_date': date, // Make sure this date is a string
      // if (images != null)
        'images': await Future.wait(
          images.map(
            (image) async => await MultipartFile.fromFile(
              image.path,
              filename: image.name,
            ),
          ),
        ),
    });
    // Log formData for debugging

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/events", formData, isFormData: true);

    return response;
  }
}
