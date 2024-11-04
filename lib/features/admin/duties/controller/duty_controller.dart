import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
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

  Future<void> addDuty(
    BuildContext context, {
    required String duty_title,
    required String description,
    required String status,
    required String remark,
    // required List<int> teachers,
  }) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      final response = await DutyServices().addDuty(
          duty_title: duty_title,
          description: description,
          status: status,
          remark: remark,
          teachers: [1, 2, 3]);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        context.goNamed(AppRouteConst.bottomNavRouteName,
            extra: UserType.admin);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loadingProvider.setLoading(false); // End loader
      notifyListeners();
    }
  }
}
