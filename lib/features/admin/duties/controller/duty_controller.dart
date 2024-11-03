import 'package:flutter/widgets.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/admin/duties/services/duty_services.dart';

class DutyController extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Duty> _duties = [];
  List<Duty> get duties => _duties;

  Future<void> getDuties() async {
    _isloading = true;
    try {
      final response = await DutyServices().getDuties();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _duties = (response.data as List<dynamic>)
            .map((result) => Duty.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }
}
