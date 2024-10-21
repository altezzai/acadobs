import 'package:flutter/widgets.dart';
import 'package:school_app/features/admin/payments/model/donation_model.dart';
import 'package:school_app/features/admin/payments/model/payment_model.dart';
import 'package:school_app/features/admin/payments/services/payment_services.dart';

class PaymentController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Payment> _payments = [];
  List<Payment> get payments => _payments;

  Future<void> getPayments() async {
    _isloading = true;
    try {
      final response = await PaymentServices().getPayments();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
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

  List<Donation> _donations = [];
  List<Donation> get donations => _donations;

  Future<void> getDonations() async {
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
    notifyListeners();
  }
}
