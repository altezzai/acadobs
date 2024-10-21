import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class PaymentServices {
  Future<Response> getPayments() async {
    final Response response = await ApiServices.get("/monthlyPayments");
    return response;
  }

  // Add event
  // Future<Response> addNotice(
  //     {
  //       required String audience_type,
  //       required String title,
  //     required String description,
  //     required String date}) async {
  //   // Create the form data to pass to the API
  //   final formData = {
  //     'audience_type': audience_type,
  //     'title': title,
  //     'description': description,
  //     'date': date, // Make sure this date is a string
  //   };

  //   // Call the ApiServices post method with formData and isFormData: true
  //   final Response response =
  //       await ApiServices.post("/notices", formData, isFormData: true);

  //   return response;
  // }
}
