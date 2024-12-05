// To parse this JSON data, do
//
//     final achievement = achievementFromJson(jsonString);

import 'dart:convert';

Achievement achievementFromJson(String str) =>
    Achievement.fromJson(json.decode(str));

String achievementToJson(Achievement data) => json.encode(data.toJson());

class Achievement {
  int? id;
  int? studentId;
  String? achievementTitle;
  String? description;
  String? category;
  String? level;
  DateTime? dateOfAchievement;
  String? awardingBody;
  String? certificate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Achievement({
    this.id,
    this.studentId,
    this.achievementTitle,
    this.description,
    this.category,
    this.level,
    this.dateOfAchievement,
    this.awardingBody,
    this.certificate,
    this.createdAt,
    this.updatedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        id: json["id"],
        studentId: json["student_id"],
        achievementTitle: json["achievement_title"],
        description: json["description"],
        category: json["category"],
        level: json["level"],
        dateOfAchievement: json["date_of_achievement"] == null
            ? null
            : DateTime.parse(json["date_of_achievement"]),
        awardingBody: json["awarding_body"],
        certificate: json["certificate"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "achievement_title": achievementTitle,
        "description": description,
        "category": category,
        "level": level,
        "date_of_achievement":
            "${dateOfAchievement!.year.toString().padLeft(4, '0')}-${dateOfAchievement!.month.toString().padLeft(2, '0')}-${dateOfAchievement!.day.toString().padLeft(2, '0')}",
        "awarding_body": awardingBody,
        "certificate": certificate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
