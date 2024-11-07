import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class AchievementService {
  // Get Achievements
  Future<Response> getAchievements() async {
    final Response response = await ApiServices.get("/achievements");
    return response;
  }
}
