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

  Future<Response> addPayment({
    required String userId,
    required String amount_paid,
    required String payment_date,
    required String month,
    required String year,
    required String payment_method,
    required String transaction_id,
    required String payment_status,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      'user_id': userId,
      'amount_paid': amount_paid,
      'payment_date': payment_date,
      'month': month,
      'year': year,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      'payment_status': payment_status
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/monthlyPayments", formData, isFormData: true);

    return response;
  }

  Future<Response> addDonation({
    required String amount_donated,
    required String donation_date,
    required String purpose,
    required String donation_type,
    required String payment_method,
    required String transaction_id,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      'donor_id': '1',
      'amount_donated': amount_donated,
      'donation_date': donation_date,
      'purpose': purpose,
      'donation_type': donation_type,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/donations", formData, isFormData: true);

    return response;
  }
}
