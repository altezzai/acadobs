// To parse this JSON data, do
//
//     final teacherReport = teacherReportFromJson(jsonString);

import 'dart:convert';

List<TeacherReport> teacherReportFromJson(String str) => List<TeacherReport>.from(json.decode(str).map((x) => TeacherReport.fromJson(x)));

String teacherReportToJson(List<TeacherReport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherReport {
    int? teacherId;
    String? fullName;
    int? attendanceRecordedCount;
    int? leavePendingCount;
    int? leaveApprovedCount;
    int? leaveRejectedCount;
    int? totalDuties;
    int? completedDuties;

    TeacherReport({
        this.teacherId,
        this.fullName,
        this.attendanceRecordedCount,
        this.leavePendingCount,
        this.leaveApprovedCount,
        this.leaveRejectedCount,
        this.totalDuties,
        this.completedDuties,
    });

    factory TeacherReport.fromJson(Map<String, dynamic> json) => TeacherReport(
        teacherId: json["teacher_id"],
        fullName: json["full_name"],
        attendanceRecordedCount: json["attendance_recorded_count"],
        leavePendingCount: json["leave_pending_count"],
        leaveApprovedCount: json["leave_approved_count"],
        leaveRejectedCount: json["leave_rejected_count"],
        totalDuties: json["total_duties"],
        completedDuties: json["completed_duties"],
    );

    Map<String, dynamic> toJson() => {
        "teacher_id": teacherId,
        "full_name": fullName,
        "attendance_recorded_count": attendanceRecordedCount,
        "leave_pending_count": leavePendingCount,
        "leave_approved_count": leaveApprovedCount,
        "leave_rejected_count": leaveRejectedCount,
        "total_duties": totalDuties,
        "completed_duties": completedDuties,
    };
}
