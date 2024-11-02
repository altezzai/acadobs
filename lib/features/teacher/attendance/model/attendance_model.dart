// To parse this JSON data, do
//
//     final attendance = attendanceFromJson(jsonString);

import 'dart:convert';

List<Attendance> attendanceFromJson(String str) => List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendanceToJson(List<Attendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attendance {
    int? studentId;
    int? periodNumber;
    String? attendanceStatus;
    int? recordedBy;
    int? id;
    String? fullName;

    Attendance({
        this.studentId,
        this.periodNumber,
        this.attendanceStatus,
        this.recordedBy,
        this.id,
        this.fullName,
    });

    factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        studentId: json["student_id"],
        periodNumber: json["period_number"],
        attendanceStatus: json["attendance_status"],
        recordedBy: json["recorded_by"],
        id: json["id"],
        fullName: json["full_name"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "period_number": periodNumber,
        "attendance_status": attendanceStatus,
        "recorded_by": recordedBy,
        "id": id,
        "full_name": fullName,
    };
}
 