import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';

// Widget representing a tile for taking attendance of a student
class AttendanceTile extends StatefulWidget {
  final int studentId; // Unique ID of the student
  final String studentName; // Name of the student
  final String rollNo;
  // final bool isAllPresent;

  const AttendanceTile({
    super.key,
    required this.studentId,
    required this.studentName,
    required this.rollNo,
    // this.isAllPresent = false,
  });

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  String? selectedRemark; // Stores the selected remark

  final List<String> remarksList = [
    "On Leave",
    "Medical Leave",
    "Other",
  ];
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
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFF4F4F4),
                  child: Text(
                    widget.rollNo,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7C7C7C)),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  widget.studentName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                // Dropdown for remarks
                DropdownButton<String>(
                  value: controller.getSelectedRemark(widget.studentId) ==
                          "Select Remark"
                      ? null
                      : controller.getSelectedRemark(widget.studentId),
                  hint: Row(
                    children: [
                      Text("Remarks",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  underline: const SizedBox(), // Removes the default underline
                  items: remarksList.map((String remark) {
                    return DropdownMenuItem<String>(
                      value: remark,
                      child: Text(
                        remark,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.updateRemark(widget.studentId, newValue);
                    }
                  },
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
                currentStatus: controller.getStatus(widget.studentId),
                studentId: widget.studentId,
                bottomLeftRadius: 8,
              ),
              _attendanceButton(
                context: context,
                text: "Late",
                status: AttendanceStatus.late,
                currentStatus: controller.getStatus(widget.studentId),
                studentId: widget.studentId,
              ),
              _attendanceButton(
                context: context,
                text: "Absent",
                status: AttendanceStatus.absent,
                currentStatus: controller.getStatus(widget.studentId),
                studentId: widget.studentId,
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
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal),
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
