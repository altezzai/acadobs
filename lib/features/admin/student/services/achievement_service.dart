import 'package:dio/dio.dart';
import 'package:school_app/base/services/api_services.dart';

class AchievementService {
  // Get Achievements
  Future<Response> getAchievements({required int studentId}) async {
    final Response response =
        await ApiServices.get("/showAchievementsByStudentId/$studentId");
    return response;
  }

  // Add achievements
  Future<Response> addAchievement({
    required int studentId,
    required String achievement_title,
    required String description,
    required String category,
    required String level,
    required String awarding_body,
    required String date_of_achievement,
  }) async {
    // Create the form data to pass to the API
    final formData = {
      'student_id': studentId,
      'achievement_title': achievement_title,
      'description': description,
      'category': category,
      'level': level,
      'awarding_body': awarding_body,
      'date_of_achievement':
          date_of_achievement, // Make sure this date is a string
    };

    // Call the ApiServices post method with formData and isFormData: true
    final Response response =
        await ApiServices.post("/achievements", formData, isFormData: true);

    return response;
  }
}
