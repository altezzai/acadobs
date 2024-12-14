// To parse this JSON data, do
//
//     final studentReport = studentReportFromJson(jsonString);

import 'dart:convert';

List<StudentReport> studentReportFromJson(String str) => List<StudentReport>.from(json.decode(str).map((x) => StudentReport.fromJson(x)));

String studentReportToJson(List<StudentReport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentReport {
    int? studentId;
    String? fullName;
    String? studentReportClass;
    String? section;
    String? attendancePercentage;
    int? leaveCount;
    String? marksAverage;
    int? achievementsCount;

    StudentReport({
        this.studentId,
        this.fullName,
        this.studentReportClass,
        this.section,
        this.attendancePercentage,
        this.leaveCount,
        this.marksAverage,
        this.achievementsCount,
    });

    factory StudentReport.fromJson(Map<String, dynamic> json) => StudentReport(
        studentId: json["student_id"],
        fullName: json["full_name"],
        studentReportClass: json["class"],
        section: json["section"],
        attendancePercentage: json["attendance_percentage"],
        leaveCount: json["leave_count"],
        marksAverage: json["marks_average"],
        achievementsCount: json["achievements_count"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "class": studentReportClass,
        "section": section,
        "attendance_percentage": attendancePercentage,
        "leave_count": leaveCount,
        "marks_average": marksAverage,
        "achievements_count": achievementsCount,
    };
}
