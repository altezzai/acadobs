import 'package:flutter/material.dart';

class AttendanceWidget extends StatelessWidget {
  final String rollNo;
  final String studentName;
  final String status;
  const AttendanceWidget(
      {super.key,
      required this.rollNo,
      required this.studentName,
      required this.status});

  // Get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Color(0xFF64F946);
      case 'Late':
        return Color.fromARGB(255, 239, 180, 71);
      case 'Absent':
        return Color(0xFFFF1C1C);
      default:
        return Color(0xFFEAEAEA);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    rollNo,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7C7C7C)),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  studentName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Row(
            children: [
              _attendanceButton(
                context: context,
                buttonStatus: "Present",
                text: "Present",
                bottomLeftRadius: 8,
              ),
              _attendanceButton(
                context: context,
                buttonStatus: "Late",
                text: "Late",
              ),
              _attendanceButton(
                context: context,
                buttonStatus: "Absent",
                text: "Absent",
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
      required String buttonStatus,
      double bottomRightRadius = 0,
      double bottomLeftRadius = 0}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 25),
          backgroundColor: status == buttonStatus
              ? getStatusColor(status)
              : Color(0xFFF4F4F4),
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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
