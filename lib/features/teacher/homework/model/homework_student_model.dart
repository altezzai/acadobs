// To parse this JSON data, do
//
//     final homeworkWithStudentsModel = homeworkWithStudentsModelFromJson(jsonString);

import 'dart:convert';

HomeworkWithStudentsModel homeworkWithStudentsModelFromJson(String str) =>
    HomeworkWithStudentsModel.fromJson(json.decode(str));

String homeworkWithStudentsModelToJson(HomeworkWithStudentsModel data) =>
    json.encode(data.toJson());

class HomeworkWithStudentsModel {
  String? status;
  Homework? homework;
  List<AssignedStudent>? assignedStudents;

  HomeworkWithStudentsModel({
    this.status,
    this.homework,
    this.assignedStudents,
  });

  factory HomeworkWithStudentsModel.fromJson(Map<String, dynamic> json) =>
      HomeworkWithStudentsModel(
        status: json["status"],
        homework: json["homework"] == null
            ? null
            : Homework.fromJson(json["homework"]),
        assignedStudents: json["assigned_students"] == null
            ? []
            : List<AssignedStudent>.from(json["assigned_students"]!
                .map((x) => AssignedStudent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "homework": homework?.toJson(),
        "assigned_students": assignedStudents == null
            ? []
            : List<dynamic>.from(assignedStudents!.map((x) => x.toJson())),
      };
}

class AssignedStudent {
  int? studentId;
  String? fullName;
  String? assignedStudentClass;
  String? section;
  String? studentPhoto;

  AssignedStudent({
    this.studentId,
    this.fullName,
    this.assignedStudentClass,
    this.section,
    this.studentPhoto,
  });

  factory AssignedStudent.fromJson(Map<String, dynamic> json) =>
      AssignedStudent(
        studentId: json["student_id"],
        fullName: json["full_name"],
        assignedStudentClass: json["class"],
        section: json["section"],
        studentPhoto: json["student_photo"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "class": assignedStudentClass,
        "section": section,
        "student_photo": studentPhoto,
      };
}

class Homework {
  int? id;
  String? assignmentTitle;
  DateTime? assignedDate;
  int? totalMarks;
  String? description;
  DateTime? dueDate;
  DateTime? createdAt;
  String? subjectName;

  Homework({
    this.id,
    this.assignmentTitle,
    this.assignedDate,
    this.totalMarks,
    this.description,
    this.dueDate,
    this.createdAt,
    this.subjectName,
  });

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
        id: json["id"],
        assignmentTitle: json["assignment_title"],
        assignedDate: json["assigned_date"] == null
            ? null
            : DateTime.parse(json["assigned_date"]),
        totalMarks: json["total_marks"],
        description: json["description"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        subjectName: json["subject_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_title": assignmentTitle,
        "assigned_date":
            "${assignedDate!.year.toString().padLeft(4, '0')}-${assignedDate!.month.toString().padLeft(2, '0')}-${assignedDate!.day.toString().padLeft(2, '0')}",
        "total_marks": totalMarks,
        "description": description,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "subject_name": subjectName,
      };
}
