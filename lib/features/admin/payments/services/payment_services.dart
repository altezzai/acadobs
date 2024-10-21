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
}
