// To parse this JSON data, do
//
//     final teacherAddedMarks = teacherAddedMarksFromJson(jsonString);

import 'dart:convert';

List<TeacherAddedMarks> teacherAddedMarksFromJson(String str) => List<TeacherAddedMarks>.from(json.decode(str).map((x) => TeacherAddedMarks.fromJson(x)));

String teacherAddedMarksToJson(List<TeacherAddedMarks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherAddedMarks {
    DateTime? date;
    String? classGrade;
    String? section;
    String? subject;
    String? title;
    int? totalMarks;
    List<StudentMarks>? students;

    TeacherAddedMarks({
        this.date,
        this.classGrade,
        this.section,
        this.subject,
        this.title,
        this.totalMarks,
        this.students,
    });

    factory TeacherAddedMarks.fromJson(Map<String, dynamic> json) => TeacherAddedMarks(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        classGrade: json["class_grade"],
        section: json["section"],
        subject: json["subject"],
        title: json["title"],
        totalMarks: json["total_marks"],
        students: json["students"] == null ? [] : List<StudentMarks>.from(json["students"]!.map((x) => StudentMarks.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "class_grade": classGrade,
        "section": section,
        "subject": subject,
        "title": title,
        "total_marks": totalMarks,
        "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
    };
}

class StudentMarks {
    int? studentId;
    dynamic studentName;
    String? attendanceStatus;
    int? marks;

    StudentMarks({
        this.studentId,
        this.studentName,
        this.attendanceStatus,
        this.marks,
    });

    factory StudentMarks.fromJson(Map<String, dynamic> json) => StudentMarks(
        studentId: json["student_id"],
        studentName: json["student_name"],
        attendanceStatus: json["attendance_status"],
        marks: json["marks"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "student_name": studentName,
        "attendance_status": attendanceStatus,
        "marks": marks,
    };
}
