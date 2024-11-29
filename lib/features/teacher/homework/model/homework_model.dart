// To parse this JSON data, do
//
//     final homework = homeworkFromJson(jsonString);

import 'dart:convert';

List<Homework> homeworkFromJson(String str) =>
    List<Homework>.from(json.decode(str).map((x) => Homework.fromJson(x)));

String homeworkToJson(List<Homework> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Homework {
  int? id;
  int? teacherId;
  String? classGrade;
  String? section;
  String? subject;
  String? assignmentTitle;
  String? description;
  DateTime? assignedDate;
  DateTime? dueDate;
  String? submissionType;
  String? fileAttachment;
  int? totalMarks;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Homework({
    this.id,
    this.teacherId,
    this.classGrade,
    this.section,
    this.subject,
    this.assignmentTitle,
    this.description,
    this.assignedDate,
    this.dueDate,
    this.submissionType,
    this.fileAttachment,
    this.totalMarks,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
        id: json["id"],
        teacherId: json["teacher_id"],
        classGrade: json["class_grade"],
        section: json["section"],
        subject: json["subject"],
        assignmentTitle: json["assignment_title"],
        description: json["description"],
        assignedDate: json["assigned_date"] == null
            ? null
            : DateTime.parse(json["assigned_date"]),
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        submissionType: json["submission_type"],
        fileAttachment: json["file_attachment"],
        totalMarks: json["total_marks"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "class_grade": classGrade,
        "section": section,
        "subject": subject,
        "assignment_title": assignmentTitle,
        "description": description,
        "assigned_date":
            "${assignedDate!.year.toString().padLeft(4, '0')}-${assignedDate!.month.toString().padLeft(2, '0')}-${assignedDate!.day.toString().padLeft(2, '0')}",
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "submission_type": submissionType,
        "file_attachment": fileAttachment,
        "total_marks": totalMarks,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
