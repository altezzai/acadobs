// To parse this JSON data, do
//
//     final studentHomework = studentHomeworkFromJson(jsonString);

import 'dart:convert';

StudentHomework studentHomeworkFromJson(String str) =>
    StudentHomework.fromJson(json.decode(str));

String studentHomeworkToJson(StudentHomework data) =>
    json.encode(data.toJson());

class StudentHomework {
  String? status;
  List<HomeworkDetail>? homeworkDetails;

  StudentHomework({
    this.status,
    this.homeworkDetails,
  });

  factory StudentHomework.fromJson(Map<String, dynamic> json) =>
      StudentHomework(
        status: json["status"],
        homeworkDetails: json["homework_details"] == null
            ? []
            : List<HomeworkDetail>.from(json["homework_details"]!
                .map((x) => HomeworkDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "homework_details": homeworkDetails == null
            ? []
            : List<dynamic>.from(homeworkDetails!.map((x) => x.toJson())),
      };
}

class HomeworkDetail {
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
  String? assignmentTitle;
  String? description;
  DateTime? dueDate;
  DateTime? assignedDate;
  dynamic fileAttachment;
  int? totalMarks;
  String? status;
  String? subject;
  String? submissionType;
  String? fullName;

  HomeworkDetail({
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
    this.assignmentTitle,
    this.description,
    this.dueDate,
    this.assignedDate,
    this.fileAttachment,
    this.totalMarks,
    this.status,
    this.subject,
    this.submissionType,
    this.fullName,
  });

  factory HomeworkDetail.fromJson(Map<String, dynamic> json) => HomeworkDetail(
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
        assignmentTitle: json["assignment_title"],
        description: json["description"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        assignedDate: json["assigned_date"] == null
            ? null
            : DateTime.parse(json["assigned_date"]),
        fileAttachment: json["file_attachment"],
        totalMarks: json["total_marks"],
        status: json["status"],
        subject: json["subject"],
        submissionType: json["submission_type"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "homework_id": homeworkId,
        "student_id": studentId,
        "submission_status": submissionStatus,
        "submission_date": submissionDate,
        "grade": grade,
        "remarks": remarks,
        "homework_file": homeworkFile,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "assignment_title": assignmentTitle,
        "description": description,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "assigned_date":
            "${assignedDate!.year.toString().padLeft(4, '0')}-${assignedDate!.month.toString().padLeft(2, '0')}-${assignedDate!.day.toString().padLeft(2, '0')}",
        "file_attachment": fileAttachment,
        "total_marks": totalMarks,
        "status": status,
        "subject": subject,
        "submission_type": submissionType,
        "full_name": fullName,
      };
}
