import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/student/model/achievement_model.dart';
import 'package:school_app/features/admin/student/services/achievement_service.dart';

class AchievementController extends ChangeNotifier {
  // get achievements
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Achievement> _achievements = [];
  List<Achievement> get achievements => _achievements;

  Future<void> getAchievements({required int studentId}) async {
    _isloading = true;
    try {
      final response =
          await AchievementService().getAchievements(studentId: studentId);
      log("***********${response.statusCode}");
      log("***********${response.data.toString()}");
      if (response.statusCode == 200) {
        log("Started");
        _achievements.clear();
        log("One");

        // Check if data is a single object
        if (response.data is Map<String, dynamic>) {
          _achievements.add(Achievement.fromJson(response.data));
        } else if (response.data is List<dynamic>) {
          _achievements = (response.data as List<dynamic>)
              .map((result) => Achievement.fromJson(result))
              .toList();
        }

        log("Two");
        log("Achievement list***********${_achievements.toString()}");
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }

  // add achievement
  Future<void> addAchievement(
    BuildContext context, {
    required String studentId,
    required String achievement_title,
    required String description,
    required String category,
    required String level,
    required String date_of_achievement,
  }) async {
    _isloading = true;
    try {
      final response = await AchievementService().addAchievement(
        studentId: studentId,
        achievement_title: achievement_title,
        description: description,
        category: category,
        level: level,
        date_of_achievement: date_of_achievement,
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
}
