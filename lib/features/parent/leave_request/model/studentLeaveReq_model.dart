// To parse this JSON data, do
//
//     final studentLeaveRequest = studentLeaveRequestFromJson(jsonString);

import 'dart:convert';

List<StudentLeaveRequest> studentLeaveRequestFromJson(String str) => List<StudentLeaveRequest>.from(json.decode(str).map((x) => StudentLeaveRequest.fromJson(x)));

String studentLeaveRequestToJson(List<StudentLeaveRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentLeaveRequest {
    int? id;
    int? studentId;
    dynamic teacherId;
    String? leaveType;
    DateTime? startDate;
    DateTime? endDate;
    String? reasonForLeave;
    String? approvalStatus;
    dynamic approvedBy;
    dynamic leaveBalance;
    dynamic remarks;
    String? userType;
    DateTime? createdAt;
    DateTime? updatedAt;

    StudentLeaveRequest({
        this.id,
        this.studentId,
        this.teacherId,
        this.leaveType,
        this.startDate,
        this.endDate,
        this.reasonForLeave,
        this.approvalStatus,
        this.approvedBy,
        this.leaveBalance,
        this.remarks,
        this.userType,
        this.createdAt,
        this.updatedAt,
    });

    factory StudentLeaveRequest.fromJson(Map<String, dynamic> json) => StudentLeaveRequest(
        id: json["id"],
        studentId: json["student_id"],
        teacherId: json["teacher_id"],
        leaveType: json["leave_type"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        reasonForLeave: json["reason_for_leave"],
        approvalStatus: json["approval_status"],
        approvedBy: json["approved_by"],
        leaveBalance: json["leave_balance"],
        remarks: json["remarks"],
        userType: json["user_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "teacher_id": teacherId,
        "leave_type": leaveType,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "reason_for_leave": reasonForLeave,
        "approval_status": approvalStatus,
        "approved_by": approvedBy,
        "leave_balance": leaveBalance,
        "remarks": remarks,
        "user_type": userType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
