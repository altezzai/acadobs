import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:school_app/base/services/api_services.dart';

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
  Future<Response> addNotice({
    required String audience_type,
    required String title,
    required String description,
    required String date,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      'audience_type': audience_type,
      'title': title,
      'description': description,
      'date': date, // Make sure this date is a string
    };

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
      List<XFile>? images}) async {
    // Create the form data to pass to the API
    final formData = {
      'title': title,
      'description': description,
      'event_date': date, // Make sure this date is a string
      'images': await Future.wait(images!.map((image) async {
        // Convert each image to MultipartFile
        return await MultipartFile.fromFile(image.path, filename: image.name);
      })),
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/events", formData, isFormData: true);

    return response;
  }
}
