// To parse this JSON data, do
//
//     final studentHomework = studentHomeworkFromJson(jsonString);

import 'dart:convert';

StudentHomework studentHomeworkFromJson(String str) => StudentHomework.fromJson(json.decode(str));

class StudentHomework {
    String? status;
    List<HomeworkDetail>? homeworkDetails;

    StudentHomework({
        this.status,
        this.homeworkDetails,
    });

    factory StudentHomework.fromJson(Map<String, dynamic> json) => StudentHomework(
        status: json["status"],
        homeworkDetails: json["homework_details"] == null ? [] : List<HomeworkDetail>.from(json["homework_details"]!.map((x) => HomeworkDetail.fromJson(x))),
    );
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
    dynamic fileAttachment;
    int? totalMarks;
    String? status;
    String? submissionType;

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
        this.fileAttachment,
        this.totalMarks,
        this.status,
        this.submissionType,
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        assignmentTitle: json["assignment_title"],
        description: json["description"],
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        fileAttachment: json["file_attachment"],
        totalMarks: json["total_marks"],
        status: json["status"],
        submissionType: json["submission_type"],
    );

}
