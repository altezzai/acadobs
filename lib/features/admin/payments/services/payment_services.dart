import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/services/api_services.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';

class PaymentServices {
  // Get payments
  Future<Response> getPayments({required int pageNo}) async {
    final Response response = await ApiServices.get("/monthlyPayments?page=$pageNo");
    return response;
  }

  // Get payments from class and division
  Future<Response> getPaymentsByClassAndDivision(
      {required String className, required String section}) async {
    final Response response = await ApiServices.get(
        "/getPaymentsByClassAndSection?class=$className&section=$section");
    return response;
  }

  // Get payments by studentId
  Future<Response> getPaymentsByStudentId({required int studentId}) async {
    final Response response =
        await ApiServices.get("/getPaymentByStudentId/$studentId");
    return response;
  }

  // Get payments by teacher
  Future<Response> getPaymentsByRecordedId({required int recordId}) async {
    final Response response =
        await ApiServices.get("/getPaymentByRecordedId/$recordId");
    return response;
  }

//  Get donations
  Future<Response> getDonations() async {
    final Response response = await ApiServices.get("/donations");
    return response;
  }

  //Get donations by class and division
  Future<Response> getDonationsByClassAndDivision(
      {required String className, required String section}) async {
    final Response response = await ApiServices.get(
        "/getDonationsByClassAndSection?class_grade=$className&section=$section");
    return response;
  }

  // Get donations by studentId
  Future<Response> getDonationsByStudentId({required int studentId}) async {
    final Response response =
        await ApiServices.get("/getDonationByStudentId/$studentId");
    return response;
  }

  // Get donations by teacher
  Future<Response> getDonationsByRecordedId({required int recordId}) async {
    final Response response =
        await ApiServices.get("/getDonationByRecordedId/$recordId");
    return response;
  }

// add payment
  Future<Response> addPayment(
    BuildContext context, {
    required String userId,
    required int staffId,
    required String amount_paid,
    required String payment_date,
    required String month,
    required String year,
    required String payment_method,
    required String transaction_id,
    required String payment_status,
    // File? file, // Add file parameter
  }) async {
    final fileUpload = context.read<FilePickerProvider>().getFile('receipt');
    final fileUploadPath = fileUpload?.path;
    final formData = FormData.fromMap({
      'student_id': userId,
      'recorded_by': staffId,
      'amount_paid': amount_paid,
      'payment_date': payment_date,
      'month': month,
      'year': year,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      'payment_status': payment_status,
      if (fileUploadPath != null)
        'file_upload': await MultipartFile.fromFile(fileUploadPath,
            filename: fileUploadPath.split('/').last),
    });
    final Response response =
        await ApiServices.post("/monthlyPayments", formData, isFormData: true);

    return response;
  }

  // edit payment
  Future<Response> editPayment(
    BuildContext context, {
    required int paymentId,
    required String studentId,
    required int staffId,
    required String amount_paid,
    required String payment_date,
    required String month,
    required String year,
    required String payment_method,
    required String transaction_id,
    required String payment_status,
    // File? file, // Add file parameter
  }) async {
    final fileUpload = context.read<FilePickerProvider>().getFile('receipt');
    final fileUploadPath = fileUpload?.path;
    final formData = FormData.fromMap({
      'student_id': studentId,
      'recorded_by': staffId,
      'amount_paid': amount_paid,
      'payment_date': payment_date,
      'month': month,
      'year': year,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      'payment_status': payment_status,
      '_method': 'put',
      if (fileUploadPath != null)
        'file_upload': await MultipartFile.fromFile(fileUploadPath,
            filename: fileUploadPath.split('/').last),
    });
    final Response response = await ApiServices.post(
        "/monthlyPayments/$paymentId", formData,
        isFormData: true);

    return response;
  }

// add donation
  Future<Response> addDonation(
    BuildContext context, {
    required int userId,
    required int staffId,
    required String amount_donated,
    required String donation_date,
    required String purpose,
    required String donation_type,
    required String payment_method,
    required String transaction_id,
  }) async {
    final receiptUpload =
        context.read<FilePickerProvider>().getFile('donation receipt');
    final receiptUploadPath = receiptUpload?.path;
    final formData = FormData.fromMap({
      'donor_id': userId,
      'recorded_by': staffId,
      'amount_donated': amount_donated,
      'donation_date': donation_date,
      'purpose': purpose,
      'donation_type': donation_type,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      if (receiptUploadPath != null)
        'receipt_upload': await MultipartFile.fromFile(receiptUploadPath,
            filename: receiptUploadPath.split('/').last),
    });
    final Response response =
        await ApiServices.post("/donations", formData, isFormData: true);

    return response;
  }

  // edit donation
  Future<Response> editDonation(
    BuildContext context, {
    required int donationId,
    required int userId,
    required int staffId,
    required String amount_donated,
    required String donation_date,
    required String purpose,
    required String donation_type,
    required String payment_method,
    required String transaction_id,
  }) async {
    final receiptUpload =
        context.read<FilePickerProvider>().getFile('donation receipt');
    final receiptUploadPath = receiptUpload?.path;
    final formData = FormData.fromMap({
      'donor_id': userId,
      'recorded_by': staffId,
      'amount_donated': amount_donated,
      'donation_date': donation_date,
      'purpose': purpose,
      'donation_type': donation_type,
      'payment_method': payment_method,
      'transaction_id': transaction_id,
      '_method': 'put',
      if (receiptUploadPath != null)
        'receipt_upload': await MultipartFile.fromFile(receiptUploadPath,
            filename: receiptUploadPath.split('/').last),
    });
    final Response response = await ApiServices.post(
        "/donations/$donationId", formData,
        isFormData: true);

    return response;
  }

  // Delete payment
  Future<Response> deletePayment({ required int paymentId}) async {
    final Response response = await ApiServices.delete("/monthlyPayments/$paymentId");
    return response;
}

 // Delete donation
  Future<Response> deleteDonation({ required int donationId}) async {
    final Response response = await ApiServices.delete("/donations/$donationId");
    return response;
}

}
