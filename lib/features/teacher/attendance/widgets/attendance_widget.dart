import 'package:flutter/material.dart';

class AttendanceWidget extends StatefulWidget {
  final String rollNo;
  final String studentName;
  final String initialStatus;
  final bool forEditScreen;
  final int attendanceId; // Add student ID to identify records
  final Function(int id, String newStatus) onStatusChanged; // Callback function

  const AttendanceWidget({
    super.key,
    required this.rollNo,
    required this.studentName,
    required this.initialStatus,
    required this.attendanceId,
    required this.onStatusChanged,
    this.forEditScreen = false,
  });

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  late String status;

  @override
  void initState() {
    super.initState();
    status = widget.initialStatus;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return const Color(0xFF64F946);
      case 'Late':
        return const Color.fromARGB(255, 239, 180, 71);
      case 'Absent':
        return const Color(0xFFFF1C1C);
      default:
        return const Color(0xFFEAEAEA);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFCCCCCC)),
          left: BorderSide(color: Color(0xFFCCCCCC)),
          right: BorderSide(color: Color(0xFFCCCCCC)),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFF4F4F4),
                  child: Text(
                    widget.rollNo,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF7C7C7C),
                        ),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  widget.studentName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _attendanceButton(context, "Present", 8, 0),
              _attendanceButton(context, "Late", 0, 0),
              _attendanceButton(context, "Absent", 0, 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _attendanceButton(BuildContext context, String buttonStatus,
      double bottomLeftRadius, double bottomRightRadius) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (widget.forEditScreen) {
            setState(() {
              status = buttonStatus;
            });
            widget.onStatusChanged(widget.attendanceId, buttonStatus); // Notify parent
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 25),
          backgroundColor:
              status == buttonStatus ? getStatusColor(status) : const Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0, color: Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius),
            ),
          ),
        ),
        child: Text(
          buttonStatus,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

