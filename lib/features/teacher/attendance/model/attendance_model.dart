// To parse this JSON data, do
//
//     final attendance = attendanceFromJson(jsonString);

import 'dart:convert';

Attendance attendanceFromJson(String str) => Attendance.fromJson(json.decode(str));

String attendanceToJson(Attendance data) => json.encode(data.toJson());

class Attendance {
    List<StudentAttendance>? students;
    List<int>? completedPeriods;

    Attendance({
        this.students,
        this.completedPeriods,
    });

    factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        students: json["students"] == null ? [] : List<StudentAttendance>.from(json["students"]!.map((x) => StudentAttendance.fromJson(x))),
        completedPeriods: json["completed_periods"] == null ? [] : List<int>.from(json["completed_periods"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
        "completed_periods": completedPeriods == null ? [] : List<dynamic>.from(completedPeriods!.map((x) => x)),
    };
}

class StudentAttendance {
    int? studentId;
    String? fullName;
    int? periodNumber;
    String? attendanceStatus;
    int? recordedBy;
    int? id;

    StudentAttendance({
        this.studentId,
        this.fullName,
        this.periodNumber,
        this.attendanceStatus,
        this.recordedBy,
        this.id,
    });

    factory StudentAttendance.fromJson(Map<String, dynamic> json) => StudentAttendance(
        studentId: json["student_id"],
        fullName: json["full_name"],
        periodNumber: json["period_number"],
        attendanceStatus: json["attendance_status"],
        recordedBy: json["recorded_by"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "period_number": periodNumber,
        "attendance_status": attendanceStatus,
        "recorded_by": recordedBy,
        "id": id,
    };
}
