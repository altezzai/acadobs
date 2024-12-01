import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';

class PaymentServices {
  // Get payments
  Future<Response> getPayments() async {
    final Response response = await ApiServices.get("/monthlyPayments");
    return response;
  }

  // Get payments from class and division
  Future<Response> getPaymentsByClassAndDivision({required String className, required String section}) async {
    final Response response = await ApiServices.get("/getPaymentsByClassAndSection?class=$className&section=$section");
    return response;
  }

  Future<Response> getDonations() async {
    final Response response = await ApiServices.get("/donations");
    return response;
  }


// add payment
  Future<Response> addPayment(
    BuildContext context, {
    required int userId,
    required String amount_paid,
    required String payment_date,
    required String month,
    required String year,
    required String payment_method,
    required String transaction_id,
    required String payment_status,
    // File? file, // Add file parameter
  }) async {
    // Create FormData to pass to the API
    final fileProvider =
        Provider.of<FilePickerProvider>(context, listen: false);
    final formData = FormData.fromMap({
      'user_id': userId,
      'amount_paid': amount_paid,
      'payment_date': payment_date,
      'month': month,
      'year': year,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      'payment_status': payment_status,
      'file_upload':
          await MultipartFile.fromFile(fileProvider.selectedFile!.path!)
    });

    // Call the ApiServices post method with FormData and isFormData: true
    final Response response =
        await ApiServices.post("/monthlyPayments", formData, isFormData: true);

    return response;
  }

// add donation
  Future<Response> addDonation(
    BuildContext context, {
      required int userId,
    required String amount_donated,
    required String donation_date,
    required String purpose,
    required String donation_type,
    required String payment_method,
    required String transaction_id,
    // File? file, // Add the file parameter
  }) async {
    final fileProvider =
        Provider.of<FilePickerProvider>(context, listen: false);
    // Create FormData to pass to the API
    final formData = FormData.fromMap({
      'donor_id': userId,
      'amount_donated': amount_donated,
      'donation_date': donation_date,
      'purpose': purpose,
      'donation_type': donation_type,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      'file_upload':
          await MultipartFile.fromFile(fileProvider.selectedFile!.path!)
    });

    // Call the ApiServices post method with FormData and isFormData: true
    final Response response =
        await ApiServices.post("/donations", formData, isFormData: true);

    return response;
  }
}
