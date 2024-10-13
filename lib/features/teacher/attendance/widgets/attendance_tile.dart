import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';

// Widget representing a tile for taking attendance of a student
class AttendanceTile extends StatelessWidget {
  final int studentId; // Unique ID of the student
  final String studentName; // Name of the student

  const AttendanceTile({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    // Access the AttendanceController
    final controller = Provider.of<AttendanceController>(context);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFCCCCCC),
          ),
          left: BorderSide(
            color: Color(0xFFCCCCCC),
          ),
          right: BorderSide(
            color: Color(0xFFCCCCCC),
          ),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFFD9D9D9),
                  child: Text(
                    studentId.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  studentName,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16, color: Colors.black),
                )
              ],
            ),
          ),
          Row(
            children: [
              _attendanceButton(
                context: context,
                text: "Present",
                status: AttendanceStatus.present,
                currentStatus: controller.getStatus(studentId),
                studentId: studentId,
                bottomLeftRadius: 8,
              ),
              _attendanceButton(
                context: context,
                text: "Late",
                status: AttendanceStatus.late,
                currentStatus: controller.getStatus(studentId),
                studentId: studentId,
              ),
              _attendanceButton(
                context: context,
                text: "Absent",
                status: AttendanceStatus.absent,
                currentStatus: controller.getStatus(studentId),
                studentId: studentId,
                bottomRightRadius: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget representing a button for each attendance status
  Widget _attendanceButton(
      {required BuildContext context,
      required String text,
      required AttendanceStatus status,
      required AttendanceStatus currentStatus,
      required int studentId,
      double bottomRightRadius = 0,
      double bottomLeftRadius = 0}) {
    // Access the AttendanceController
    final controller =
        Provider.of<AttendanceController>(context, listen: false);

    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // Update attendance status for the specific student
          controller.updateStatus(studentId, status);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 25),
          backgroundColor: currentStatus == status
              ? _getStatusColor(status)
              : const Color(0xFFEAEAEA),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0,
              color: Color(0xFFCCCCCC),
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(bottomRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  // Helper method to determine button color based on attendance status
  Color _getStatusColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return const Color(0xFF64F946);
      case AttendanceStatus.late:
        return Colors.orange;
      case AttendanceStatus.absent:
        return Colors.red;
      default:
        return const Color(0xFFEAEAEA);
    }
  }
}
