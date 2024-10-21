import 'package:flutter/widgets.dart';
import 'package:school_app/features/admin/notices/services/notice_services.dart';
import 'package:school_app/features/admin/payments/model/payment_model.dart';

class PaymentController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Payment> _payments = [];
  List<Payment> get payments => _payments;

  Future<void> getNotices() async {
    _isloading = true;
    try {
      final response = await NoticeServices().getNotices();
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

  // add events
  // Future<void> addNotice(BuildContext context,
  //     {required String audience_type,
  //     required String title,
  //     required String description,
  //     required String date}) async {
  //   final loadingProvider =
  //       Provider.of<LoadingProvider>(context, listen: false); //loading provider
  //   loadingProvider.setLoading(true); //start loader
  //   try {
  //     final response = await NoticeServices().addNotice(
  //         title: title,
  //         description: description,
  //         date: date,
  //         audience_type: audience_type);
  //     if (response.statusCode == 201) {
  //       log(">>>>>>${response.statusMessage}");
  //       context.goNamed(AppRouteConst.NoticePageRouteName);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   } finally {
  //     loadingProvider.setLoading(false); // End loader
  //     notifyListeners();
  //   }
  // }
}
