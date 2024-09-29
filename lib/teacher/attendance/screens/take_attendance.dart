import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/teacher/attendance/widgets/attendance_tile.dart';
import 'package:school_app/teacher/navbar/screens/bottom_navbar.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/responsive.dart';

class TakeAttendance extends StatelessWidget {
  TakeAttendance({
    super.key,
  });

  final students = [
    {"id": 1, "name": "Theodore T.C. Calvin"},
    {"id": 2, "name": "Rick Wright"},
    {"id": 3, "name": "Tom Selleck"},
    {"id": 4, "name": "Theodore T.C. Calvin"},
    {"id": 5, "name": "Rick Wright"},
    {"id": 6, "name": "Tom Selleck"},
    {"id": 7, "name": "Theodore T.C. Calvin"},
    {"id": 8, "name": "Rick Wright"},
    {"id": 9, "name": "Tom Selleck"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomAppbar(
                title: "9th B",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BottomNavbar(),
                    ),
                  );
                },
              ),
              Text(
                "01/09/2024",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Responsive.height * 2),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    10,
                    (index) {
                      return Expanded(
                        child: _periodBox(context, period: index + 1),
                      );
                    },
                  )),
              SizedBox(height: Responsive.height * 2),
              Consumer<AttendanceController>(
                  builder: (context, attendanceController, child) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: Responsive.height * 1),
                        child: AttendanceTile(
                          studentId: student['id'] as int,
                          studentName: student['name'] as String,
                        ),
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }

  // Individual period box
  Widget _periodBox(context, {required int period}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2), // Space between boxes
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ), // Padding inside the box
      decoration: BoxDecoration(
        color: Colors.blue, // Box color
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26, width: 1), // Optional border
      ),
      child: Center(
        child: Text(
          'P$period', // Display period number
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: whiteColor, fontSize: 12),
        ),
      ),
    );
  }
}
