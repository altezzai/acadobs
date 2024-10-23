import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/loading_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';
import 'package:school_app/features/admin/notices/models/notice_model.dart';
import 'package:school_app/features/admin/notices/services/notice_services.dart';

class NoticeController extends ChangeNotifier {
  // get notices
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Notice> _notices = [];
  List<Notice> get notices => _notices;

  Future<void> getNotices() async {
    _isloading = true;
    try {
      final response = await NoticeServices().getNotices();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _notices = (response.data as List<dynamic>)
            .map((result) => Notice.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // get events
  List<Event> _events = [];
  List<Event> get events => _events;

  Future<void> getEvents() async {
    try {
      final response = await NoticeServices().getEvents();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _events = (response.data as List<dynamic>)
            .map((result) => Event.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    notifyListeners();
  }

  // add events
  Future<void> addNotice(BuildContext context,
      {required String audience_type,
      required String title,
      required String description,
      required String date}) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      final response = await NoticeServices().addNotice(
          title: title,
          description: description,
          date: date,
          audience_type: audience_type);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
        context.goNamed(AppRouteConst.NoticePageRouteName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loadingProvider.setLoading(false); // End loader
      notifyListeners();
    }
  }

  // add events
  Future<void> addEvent(BuildContext context,
      {required String title,
      required String description,
      required String date, String? coverPhoto}) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false); //loading provider
    loadingProvider.setLoading(true); //start loader
    try {
      final response = await NoticeServices()
          .addEvent(title: title, description: description, date: date);
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
