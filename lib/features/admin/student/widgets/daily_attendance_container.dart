import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/day_attendance_status.dart';

class DailyAttendanceContainer extends StatelessWidget {
  final String studentId;
  final VoidCallback onSelectDate;
  const DailyAttendanceContainer({
    Key? key,
    required this.studentId,
    required this.onSelectDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formattedDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text("${controller.dayAttendanceStatus.length}/10"),
                  Row(
                    children: [
                      const Text(
                        "Date",
                        style: TextStyle(
                          color: Color(0xFF7C7C7C),
                        ),
                      ),
                      InkWell(
                        onTap: onSelectDate,
                        child: const Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 1),
              // Period Status Row
              Consumer<StudentController>(builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    10, // Number of periods
                    (index) => _periodStatus(
                      periodNumber: index + 1,
                      dayAttendanceStatus: value.dayAttendanceStatus,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _periodStatus({
    required int periodNumber,
    required List<DayAttendanceStatus> dayAttendanceStatus,
  }) {
    final status = dayAttendanceStatus.firstWhere(
      (item) => item.periodNumber == periodNumber,
      orElse: () => DayAttendanceStatus(attendanceStatus: "Not Taken"),
    );

    final color = _getStatusColor(status.attendanceStatus);

    return Container(
      height: 60,
      width: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Present":
        return const Color(0xFF07C3A2); // Green
      case "Late":
        return const Color.fromARGB(255, 226, 204, 82); // Yellow
      case "Absent":
        return const Color(0xFFF15754); // Red
      case "Not Taken":
      default:
        return const Color(0xFFB0B0B0); // Grey
    }
  }
}
