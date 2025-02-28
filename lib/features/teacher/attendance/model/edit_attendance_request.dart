class EditAttendanceRequest {
  int id;
  String attendanceStatus;
  String remarks;

  EditAttendanceRequest({
    required this.id,
    required this.attendanceStatus,
    required this.remarks,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "attendance_status": attendanceStatus,
      "remarks": remarks,
    };
  }
}
