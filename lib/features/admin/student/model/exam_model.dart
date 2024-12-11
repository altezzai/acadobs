import 'dart:convert';

List<Exam> examFromJson(String str) =>
    List<Exam>.from(json.decode(str).map((x) => Exam.fromJson(x)));

String examToJson(List<Exam> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exam {
  int? id;
  int? studentId;
  DateTime? date;
  String? classGrade;
  String? section;
  String? title;
  String? subject;
  int? totalMarks;
  int? marks;
  String? attendanceStatus;
  int? recordedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Exam({
    this.id,
    this.studentId,
    this.date,
    this.classGrade,
    this.section,
    this.title,
    this.subject,
    this.totalMarks,
    this.marks,
    this.attendanceStatus,
    this.recordedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        studentId: json["student_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        classGrade: json["class_grade"],
        section: json["section"],
        title: json["title"],
        subject: json["subject"],
        totalMarks: json["total_marks"],
        marks: json["marks"],
        attendanceStatus: json["attendance_status"],
        recordedBy: json["recorded_by"],
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
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "class_grade": classGrade,
        "section": section,
        "title": title,
        "subject": subject,
        "total_marks": totalMarks,
        "marks": marks,
        "attendance_status": attendanceStatus,
        "recorded_by": recordedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
