import 'dart:developer';
import 'dart:io';

//import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/loading_dialog.dart';
import 'package:school_app/features/admin/payments/model/donation_model.dart';
import 'package:school_app/features/admin/payments/model/payment_model.dart';
import 'package:school_app/features/admin/payments/services/payment_services.dart';

class PaymentController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isloadingTwo = false;
  bool get isloadingTwo => _isloadingTwo;
  bool _isFiltered = false; // New flag to track filtering
  bool get isFiltered =>
      _isFiltered; // Public getter to access the filter state

  List<Payment> _payments = [];
  List<Payment> get payments => _payments;
  List<Payment> _filteredpayments = [];
  List<Payment> get filteredpayments => _filteredpayments;
  List<Payment> _studentPayments = [];
  List<Payment> get studentPayments => _studentPayments;
  List<Payment> _teacherPayments = [];
  List<Payment> get teacherPayments => _teacherPayments;
  List<Donation> _filtereddonations = [];
  List<Donation> get filtereddonations => _filtereddonations;

// Get all Payments
  Future<void> getPayments() async {
    _isloading = true;
    try {
      final response = await PaymentServices().getPayments();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _payments.clear();
        _payments = (response.data as List<dynamic>)
            .map((result) => Payment.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Get individual student payments
  Future<void> getPaymentsByStudentId({required int studentId}) async {
    _isloading = true;
    try {
      final response =
          await PaymentServices().getPaymentsByStudentId(studentId: studentId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _studentPayments.clear();
        _studentPayments = (response.data as List<dynamic>)
            .map((result) => Payment.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Get payments from class and division
  Future<void> getPaymentsByClassAndDivision(
      {required String className, required String section}) async {
    _isloading = true;
    _filteredpayments.clear();
    _isFiltered = false;
    try {
      final response = await PaymentServices().getPaymentsByClassAndDivision(
          className: className, section: section);
      log("***********${response.statusCode}");
      if (response.statusCode == 200) {
        _filteredpayments.clear();
        _filteredpayments = (response.data as List<dynamic>)
            .map((result) => Payment.fromJson(result))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      _isFiltered = true;
      notifyListeners();
    }
  }

  // Get payments by recorded id
  Future<void> getPaymentsByRecordId() async {
    _isloading = true;
    try {
      final recordId = await SecureStorageService.getUserId();
      final response =
          await PaymentServices().getPaymentsByRecordedId(recordId: recordId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _teacherPayments.clear();
        _teacherPayments = (response.data as List<dynamic>)
            .map((result) => Payment.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  void clearPaymentList() {
    _filteredpayments.clear();
    notifyListeners();
  }

  void clearDonationList() {
    _filtereddonations.clear();
    notifyListeners();
  }

  void resetFilter() {
    _isFiltered = false;
    _filteredpayments = []; // Clear the list of filtered payments
    notifyListeners(); // Notify listeners to update the UI
  }

  List<Donation> _donations = [];
  List<Donation> get donations => _donations;

  List<Donation> _studentdonations = [];
  List<Donation> get studentdonations => _studentdonations;

  List<Donation> _teacherdonations = [];
  List<Donation> get teacherdonations => _teacherdonations;

  Future<void> getDonations() async {
    _isloading = true;
    try {
      final response = await PaymentServices().getDonations();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _donations = (response.data as List<dynamic>)
            .map((result) => Donation.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Get individual student donations
  Future<void> getDonationByStudentId({required int studentId}) async {
    _isloading = true;
    try {
      final response =
          await PaymentServices().getDonationsByStudentId(studentId: studentId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _studentdonations.clear();
        _studentdonations = (response.data as List<dynamic>)
            .map((result) => Donation.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // Get donations by class and division
  Future<void> getDonationsByClassAndDivision(
      {required String className, required String section}) async {
    _isloading = true;
    _filtereddonations.clear();
    _isFiltered = false;
    try {
      final response = await PaymentServices().getDonationsByClassAndDivision(
          className: className, section: section);
      log("***********${response.statusCode}");
      if (response.statusCode == 200) {
        _filtereddonations.clear();
        _filtereddonations = (response.data as List<dynamic>)
            .map((result) => Donation.fromJson(result))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      _isFiltered = true;
      notifyListeners();
    }
  }

  // Get teacher donations
  Future<void> getDonationByRecordId() async {
    _isloading = true;
    try {
      final recordId = await SecureStorageService.getUserId();
      final response =
          await PaymentServices().getDonationsByRecordedId(recordId: recordId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _teacherdonations.clear();
        _teacherdonations = (response.data as List<dynamic>)
            .map((result) => Donation.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

// add payment
  Future<void> addPayment(
    BuildContext context, {
    required int userId,
    required String amount_paid,
    required String payment_date,
    required String month,
    required String year,
    required String payment_method,
    required String transaction_id,
    required String payment_status,
    File? file,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await PaymentServices().addPayment(
        context,
        userId: userId.toString(),
        staffId: teacherId,
        amount_paid: amount_paid,
        payment_date: payment_date,
        month: month,
        year: year,
        payment_method: payment_method,
        transaction_id: transaction_id,
        payment_status: payment_status,
      );
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        CustomSnackbar.show(context,
            message: "Payment Added Successfully", type: SnackbarType.success);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // edit payment
  Future<void> editPayment(
    BuildContext context, {
    required int paymentId,
    required int userId,
    required String amount_paid,
    required String payment_date,
    required String month,
    required String year,
    required String payment_method,
    required String transaction_id,
    required String payment_status,
    File? file,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await PaymentServices().editPayment(
        context,
        paymentId: paymentId,
        userId: userId.toString(),
        staffId: teacherId,
        amount_paid: amount_paid,
        payment_date: payment_date,
        month: month,
        year: year,
        payment_method: payment_method,
        transaction_id: transaction_id,
        payment_status: payment_status,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");
        CustomSnackbar.show(context,
            message: "Payment Edited Successfully", type: SnackbarType.success);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  //add donation
  Future<void> addDonation(
    BuildContext context, {
    required int userId,
    required String amount_donated,
    required String donation_date,
    required String purpose,
    required String donation_type,
    required String payment_method,
    required String transaction_id,
    File? file,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await PaymentServices().addDonation(context,
          userId: userId,
          staffId: teacherId,
          amount_donated: amount_donated,
          donation_date: donation_date,
          purpose: purpose,
          donation_type: donation_type,
          payment_method: payment_method,
          transaction_id: transaction_id);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        CustomSnackbar.show(context,
            message: "Donation Added Successfully", type: SnackbarType.success);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  //edit donation
  Future<void> editDonation(
    BuildContext context, {
    required int donationId,
    required int userId,
    required String amount_donated,
    required String donation_date,
    required String purpose,
    required String donation_type,
    required String payment_method,
    required String transaction_id,
    File? file,
  }) async {
    _isloadingTwo = true;
    notifyListeners();
    try {
      final teacherId = await SecureStorageService.getUserId();
      final response = await PaymentServices().editDonation(context,
          donationId: donationId,
          userId: userId,
          staffId: teacherId,
          amount_donated: amount_donated,
          donation_date: donation_date,
          purpose: purpose,
          donation_type: donation_type,
          payment_method: payment_method,
          transaction_id: transaction_id);
      if (response.statusCode == 201 || response.statusCode == 200) {
        log(">>>>>>${response.statusMessage}");
        CustomSnackbar.show(context,
            message: "Donation Edited Successfully",
            type: SnackbarType.success);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloadingTwo = false;
      notifyListeners();
    }
  }

  // Delete payment
  Future<void> deletePayment({ required BuildContext context,required int paymentId}) async {
    _isloading = true;
    notifyListeners();
    LoadingDialog.show(context, message: "Deleting payment...");
    try {
      final response = await PaymentServices().deletePayment(paymentId: paymentId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Payment deleted successfully.");
        Navigator.pop(context);
        CustomSnackbar.show(context,
            message: 'Deleted Payment successfully', type: SnackbarType.info);
      }
    } catch (e) {
     log("Deleting error: ${e.toString()}");
    } finally {
      _isloading = false;
      notifyListeners();
      LoadingDialog.hide(context);
    }
  }

   // Delete payment
  Future<void> deleteDoantion({ required BuildContext context,required int donationId}) async {
    _isloading = true;
    notifyListeners();
    LoadingDialog.show(context, message: "Deleting donation...");
    try {
      final response = await PaymentServices().deleteDonation(donationId: donationId);
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Donation deleted successfully.");
        Navigator.pop(context);
        CustomSnackbar.show(context,
            message: 'Deleted Donation successfully', type: SnackbarType.info);
      }
    } catch (e) {
     log("Deleting error: ${e.toString()}");
    } finally {
      _isloading = false;
      notifyListeners();
      LoadingDialog.hide(context);
    }
  }
}
