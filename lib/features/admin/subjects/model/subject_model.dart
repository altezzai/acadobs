// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

List<Subject> subjectFromJson(String str) => List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
    int? id;
    String? subject;
    String? description;
    int? trash;
    DateTime? createdAt;
    DateTime? updatedAt;

    Subject({
        this.id,
        this.subject,
        this.description,
        this.trash,
        this.createdAt,
        this.updatedAt,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        trash: json["trash"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "trash": trash,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
