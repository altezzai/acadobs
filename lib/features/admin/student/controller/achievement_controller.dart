import 'package:flutter/material.dart';
import 'package:school_app/features/admin/student/model/achievement_model.dart';
import 'package:school_app/features/admin/student/services/achievement_service.dart';

class AchievementController extends ChangeNotifier {
  // get achievements
  bool _isloading = false;
  bool get isloading => _isloading;
  List<Achievement> _achievements = [];
  List<Achievement> get achievements => _achievements;

  Future<void> getAchievements() async {
    _isloading = true;
    try {
      final response = await AchievementService().getAchievements();
      print("***********${response.statusCode}");
      // print(response.toString());
      if (response.statusCode == 200) {
        _achievements = (response.data as List<dynamic>)
            .map((result) => Achievement.fromJson(result))
            .toList();
      }
    } catch (e) {
      // print(e);
    }
    _isloading = false;
    notifyListeners();
  }
}
