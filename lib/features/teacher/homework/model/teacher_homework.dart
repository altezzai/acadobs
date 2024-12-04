// To parse this JSON data, do
//
//     final teacherHomework = teacherHomeworkFromJson(jsonString);

import 'dart:convert';

TeacherHomework teacherHomeworkFromJson(String str) =>
    TeacherHomework.fromJson(json.decode(str));

class TeacherHomework {
  String? status;
  Homework? homework;
  List<AssignedStudent>? assignedStudents;

  TeacherHomework({
    this.status,
    this.homework,
    this.assignedStudents,
  });

  factory TeacherHomework.fromJson(Map<String, dynamic> json) =>
      TeacherHomework(
        status: json["status"],
        homework: json["homework"] == null
            ? null
            : Homework.fromJson(json["homework"]),
        assignedStudents: json["assigned_students"] == null
            ? []
            : List<AssignedStudent>.from(json["assigned_students"]!
                .map((x) => AssignedStudent.fromJson(x))),
      );
}

class AssignedStudent {
  int? id;
  int? homeworkId;
  int? studentId;
  String? submissionStatus;
  dynamic submissionDate;
  dynamic grade;
  dynamic remarks;
  dynamic homeworkFile;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullName;
  String? assignedStudentClass;
  String? section;
  dynamic studentPhoto;

  AssignedStudent({
    this.id,
    this.homeworkId,
    this.studentId,
    this.submissionStatus,
    this.submissionDate,
    this.grade,
    this.remarks,
    this.homeworkFile,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.assignedStudentClass,
    this.section,
    this.studentPhoto,
  });

  factory AssignedStudent.fromJson(Map<String, dynamic> json) =>
      AssignedStudent(
        id: json["id"],
        homeworkId: json["homework_id"],
        studentId: json["student_id"],
        submissionStatus: json["submission_status"],
        submissionDate: json["submission_date"],
        grade: json["grade"],
        remarks: json["remarks"],
        homeworkFile: json["homework_file"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fullName: json["full_name"],
        assignedStudentClass: json["class"],
        section: json["section"],
        studentPhoto: json["student_photo"],
      );
}

class Homework {
  int? id;
  String? assignmentTitle;
  String? description;
  DateTime? dueDate;
  DateTime? createdAt;

  Homework({
    this.id,
    this.assignmentTitle,
    this.description,
    this.dueDate,
    this.createdAt,
  });

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
        id: json["id"],
        assignmentTitle: json["assignment_title"],
        description: json["description"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );
}
