import 'package:dio/dio.dart';
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

// Add event
  Future<Response> addEvent(
      {required String title,
      required String description,
      required String date}) async {
    // Create the form data to pass to the API
    final formData = {
      'title': title,
      'description': description,
      'event_date': date, // Make sure this date is a string
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/events", formData, isFormData: true);

    return response;
  }
}
