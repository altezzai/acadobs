// To parse this JSON data, do
//
//     final attendanceRecordModel = attendanceRecordModelFromJson(jsonString);

import 'dart:convert';

AttendanceRecordModel attendanceRecordModelFromJson(String str) => AttendanceRecordModel.fromJson(json.decode(str));

String attendanceRecordModelToJson(AttendanceRecordModel data) => json.encode(data.toJson());

class AttendanceRecordModel {
    String? status;
    List<AttendanceRecord>? attendanceRecords;

    AttendanceRecordModel({
        this.status,
        this.attendanceRecords,
    });

    factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) => AttendanceRecordModel(
        status: json["status"],
        attendanceRecords: json["attendance_records"] == null ? [] : List<AttendanceRecord>.from(json["attendance_records"]!.map((x) => AttendanceRecord.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "attendance_records": attendanceRecords == null ? [] : List<dynamic>.from(attendanceRecords!.map((x) => x.toJson())),
    };
}

class AttendanceRecord {
    DateTime? date;
    String? classGrade;
    String? section;
    int? periodNumber;
    String? subjectName;
    List<StudentData>? students;

    AttendanceRecord({
        this.date,
        this.classGrade,
        this.section,
        this.periodNumber,
        this.subjectName,
        this.students,
    });

    factory AttendanceRecord.fromJson(Map<String, dynamic> json) => AttendanceRecord(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        classGrade: json["class_grade"],
        section: json["section"],
        periodNumber: json["period_number"],
        subjectName: json["subject_name"],
        students: json["students"] == null ? [] : List<StudentData>.from(json["students"]!.map((x) => StudentData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "class_grade": classGrade,
        "section": section,
        "period_number": periodNumber,
        "subject_name": subjectName,
        "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
    };
}

class StudentData {
    int? id;
    int? studentId;
    String? fullName;
    String? attendanceStatus;
    dynamic remarks;

    StudentData({
        this.id,
        this.studentId,
        this.fullName,
        this.attendanceStatus,
        this.remarks,
    });

    factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
        id: json["id"],
        studentId: json["student_id"],
        fullName: json["full_name"],
        attendanceStatus: json["attendance_status"],
        remarks: json["remarks"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "full_name": fullName,
        "attendance_status": attendanceStatus,
        "remarks": remarks,
    };
}
