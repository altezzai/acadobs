import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';
import 'package:school_app/features/admin/notices/models/notice_model.dart';
import 'package:school_app/features/admin/notices/services/notice_services.dart';

class NoticeController extends ChangeNotifier {
  // get notices
  List<Notice> _notices = [];
  List<Notice> get notices => _notices;

  Future<void> getNotices() async {
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
  Future<void> addEvent(
      {required String title,
      required String description,
      required String date}) async {
    try {
      final response = await NoticeServices()
          .addEvent(title: title, description: description, date: date);
      if (response.statusCode == 201) {
        log(">>>>>>${response.statusMessage}");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
