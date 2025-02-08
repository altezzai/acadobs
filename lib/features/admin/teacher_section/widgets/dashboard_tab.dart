import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/calender_widget.dart';
import 'package:school_app/features/admin/student/widgets/daily_attendance_container.dart';

class DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final dataMap = {"Presents": 23.0, "Late": 7.0, "Absent": 3.0};
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Responsive.height * 3),
            Text(
              "Attendance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: Responsive.height * 3),
            DailyAttendanceContainer(studentId: '', onSelectDate: () => ''),
            SizedBox(height: Responsive.height * 3),
            CalenderWidget(),
            SizedBox(height: Responsive.height * 3),
          ],
        ),
      ),
    );
  }
}
