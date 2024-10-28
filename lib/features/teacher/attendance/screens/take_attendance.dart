import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/widgets/attendance_tile.dart';

class TakeAttendance extends StatelessWidget {
  final AttendanceData attendanceData;

  TakeAttendance({super.key, required this.attendanceData});

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
    context.read<StudentIdController>().getStudentsFromClassAndDivision(
        className: attendanceData.selectedClass,
        section: attendanceData.selectedDivision);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomAppbar(
                title:
                    "${attendanceData.selectedClass}th ${attendanceData.selectedDivision}",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                attendanceData.selectedDate,
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
              Consumer2<AttendanceController, StudentIdController>(builder:
                  (context, attendanceController, studentController, child) {
                final student = studentController.students
                    .map((student) => '${student['full_name']}')
                    .toList();
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: student.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Responsive.height * 1),
                        child: AttendanceTile(
                          studentId: 1,
                          studentName: student[index],
                        ),
                      );
                    });
              }),
              CustomButton(
                  text: "Submit",
                  onPressed: () {
                    List<Map<String, dynamic>> students = [
                      {
                        'student_id': 1,
                        'attendance_status': 'Present',
                        'remarks': 'On time',
                      },
                      {
                        'student_id': 4,
                        'attendance_status': 'Absent',
                        'remarks': 'Sick leave',
                      },
                      {
                        'student_id': 2,
                        'attendance_status': 'Late',
                        'remarks': 'Came late',
                      }
                    ];
                    context.read<AttendanceController>().submitAttendance(
                        date: attendanceData.selectedDate,
                        classGrade: attendanceData.selectedClass,
                        section: attendanceData.selectedDivision,
                        periodNumber: attendanceData.selectedPeriod,
                        recordedBy: 1,
                        students: students);
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
