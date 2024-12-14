import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/payments/model/donation_model.dart';
import 'package:school_app/features/admin/payments/model/payment_model.dart';
import 'package:school_app/features/admin/payments/services/payment_services.dart';

class PaymentController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Payment> _payments = [];
  List<Payment> get payments => _payments;
  List<Payment> _filteredpayments = [];
  List<Payment> get filteredpayments => _filteredpayments;

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

  // Get payments from class and division
  Future<void> getPaymentsByClassAndDivision(
      {required String className, required String section}) async {
    _isloading = true;
    _filteredpayments.clear();
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
      notifyListeners();
    }
  }

  void clearPaymentList() {
    _filteredpayments.clear();
    notifyListeners();
  }

  List<Donation> _donations = [];
  List<Donation> get donations => _donations;

  List<Donation> _studentdonations = [];
  List<Donation> get studentdonations => _studentdonations;

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
    _isloading = true;
    try {
      final response = await PaymentServices().addPayment(
        context,
        userId: userId,
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
        context.pushNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.admin);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

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
    _isloading = true;
    try {
      final response = await PaymentServices().addDonation(context,
          userId: userId,
          amount_donated: amount_donated,
          donation_date: donation_date,
          purpose: purpose,
          donation_type: donation_type,
          payment_method: payment_method,
          transaction_id: transaction_id);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        context.pushNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.admin);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
