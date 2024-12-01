// To parse this JSON data, do
//
//     final dayAttendanceStatus = dayAttendanceStatusFromJson(jsonString);

import 'dart:convert';

List<DayAttendanceStatus> dayAttendanceStatusFromJson(String str) => List<DayAttendanceStatus>.from(json.decode(str).map((x) => DayAttendanceStatus.fromJson(x)));


class DayAttendanceStatus {
    int? periodNumber;
    String? attendanceStatus;

    DayAttendanceStatus({
        this.periodNumber,
        this.attendanceStatus,
    });

    factory DayAttendanceStatus.fromJson(Map<String, dynamic> json) => DayAttendanceStatus(
        periodNumber: json["period_number"],
        attendanceStatus: json["attendance_status"],
    );

}