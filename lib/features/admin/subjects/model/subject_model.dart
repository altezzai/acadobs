// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));

String subjectToJson(Subject data) => json.encode(data.toJson());

class Subject {
  int? totalcontent;
  int? totalPages;
  int? currentPage;
  List<SubjectElement>? subjects;

  Subject({
    this.totalcontent,
    this.totalPages,
    this.currentPage,
    this.subjects,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        totalcontent: json["totalcontent"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        subjects: json["subjects"] == null
            ? []
            : List<SubjectElement>.from(
                json["subjects"]!.map((x) => SubjectElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalcontent": totalcontent,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
      };
}

class SubjectElement {
  int? id;
  String? subjectName;
  String? classRange;
  int? schoolId;
  bool? trash;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubjectElement({
    this.id,
    this.subjectName,
    this.classRange,
    this.schoolId,
    this.trash,
    this.createdAt,
    this.updatedAt,
  });

  factory SubjectElement.fromJson(Map<String, dynamic> json) => SubjectElement(
        id: json["id"],
        subjectName: json["subject_name"],
        classRange: json["class_range"],
        schoolId: json["school_id"],
        trash: json["trash"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_name": subjectName,
        "class_range": classRange,
        "school_id": schoolId,
        "trash": trash,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
