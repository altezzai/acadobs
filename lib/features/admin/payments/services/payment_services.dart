import 'dart:io';

import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class PaymentServices {
  Future<Response> getPayments() async {
    final Response response = await ApiServices.get("/monthlyPayments");
    return response;
  }

  Future<Response> getDonations() async {
    final Response response = await ApiServices.get("/donations");
    return response;
  }

// add payment
  Future<Response> addPayment({
    required int userId,
    required String amount_paid,
    required String payment_date,
    required String month,
    required String year,
    required String payment_method,
    required String transaction_id,
    required String payment_status,
    File? file, // Add file parameter
  }) async {
    // Create FormData to pass to the API
    final formData = FormData.fromMap({
      'user_id': 1,
      'amount_paid': amount_paid,
      'payment_date': payment_date,
      'month': month,
      'year': year,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      'payment_status': payment_status,
      // Add the file with the field name 'file_upload' if provided
      if (file != null)
        'file_upload': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
    });

    // Call the ApiServices post method with FormData and isFormData: true
    final Response response =
        await ApiServices.post("/monthlyPayments", formData, isFormData: true);

    return response;
  }

// add donation
  Future<Response> addDonation({
    required String amount_donated,
    required String donation_date,
    required String purpose,
    required String donation_type,
    required String payment_method,
    required String transaction_id,
    File? file, // Add the file parameter
  }) async {
    // Create FormData to pass to the API
    final formData = FormData.fromMap({
      'donor_id': '1',
      'amount_donated': amount_donated,
      'donation_date': donation_date,
      'purpose': purpose,
      'donation_type': donation_type,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      // Add the file with the field name 'file_upload'
      if (file != null)
        'file_upload': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
    });

    // Call the ApiServices post method with FormData and isFormData: true
    final Response response =
        await ApiServices.post("/donations", formData, isFormData: true);

    return response;
  }
}
