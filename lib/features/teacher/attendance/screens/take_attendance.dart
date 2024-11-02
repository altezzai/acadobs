import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/widgets/already_taken_tile.dart';
import 'package:school_app/features/teacher/attendance/widgets/attendance_tile.dart';

class TakeAttendance extends StatelessWidget {
  final AttendanceData attendanceData;

  TakeAttendance({super.key, required this.attendanceData});
  @override
  Widget build(BuildContext context) {
    // context.read<StudentIdController>().getStudentsFromClassAndDivision(
    //     className: attendanceData.selectedClass,
    //     section: attendanceData.selectedDivision);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<AttendanceController>(
              builder: (context, attendanceController, child) {
            final teacherId = attendanceController.attendanceList[0].recordedBy;
            return Column(
              children: [
                CustomAppbar(
                  verticalPadding: 3,
                  title:
                      "${attendanceData.selectedClass}th ${attendanceData.selectedDivision}",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      attendanceData.selectedDate,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    teacherId != null
                        ? Text(
                            "  (Attendance Already Taken)",
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(height: Responsive.height * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    10,
                    (index) {
                      final int _selectedPeriod =
                          int.parse(attendanceData.selectedPeriod);
                      return Expanded(
                        child: index + 1 == _selectedPeriod
                            ? _periodBox(context,
                                period: index + 1, isSelectedPeriod: true)
                            : _periodBox(context, period: index + 1),
                      );
                    },
                  ),
                ),
                SizedBox(height: Responsive.height * 2),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Consumer<AttendanceController>(
                          builder: (context, value, child) {
                        // if (studentController.isloading) {
                        //   return Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        final studentsList = value.attendanceList;

                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: studentsList.length,
                            itemBuilder: (context, index) {
                              final studentId = studentsList[index].id;
                              final teacherId =
                                  value.attendanceList[0].recordedBy;
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: Responsive.height * 1),
                                child: teacherId != null
                                    ? AlreadyTakenTile(
                                        studentId:
                                            studentsList[index].studentId ?? 0,
                                        studentName: capitalizeFirstLetter(
                                            studentsList[index].fullName ?? ""),
                                        rollNo: (index + 1).toString(),
                                        index: index,
                                        // currentStatus: AttendanceStatus.present,
                                      )
                                    : AttendanceTile(
                                        studentId: studentId ?? 0,
                                        rollNo: (index + 1).toString(),
                                        studentName: capitalizeFirstLetter(
                                            studentsList[index].fullName ?? ""),
                                      ),
                              );
                            });
                      }),
                      SizedBox(
                        height: Responsive.height * 2.5,
                      ),
                      Consumer<AttendanceController>(
                          builder: (context, value, child) {
                        if (value.isloading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final attendanceStatusList = value.attendanceStatusList;
                        final teacherId = value.attendanceList[0].recordedBy;
                        return teacherId != null
                            ? SizedBox()
                            : CustomButton(
                                text: "Submit",
                                onPressed: () {
                                  log(">>>>>>>>>>${value.getStatus(1)}");
                                  log(">>>>>>>>>>>>>>>>${attendanceStatusList}");
                                  context
                                      .read<AttendanceController>()
                                      .submitAttendance(context,
                                          date: attendanceData.selectedDate,
                                          classGrade:
                                              attendanceData.selectedClass,
                                          section:
                                              attendanceData.selectedDivision,
                                          periodNumber:
                                              attendanceData.selectedPeriod,
                                          recordedBy: 1,
                                          students: attendanceStatusList);
                                });
                      }),
                      SizedBox(
                        height: Responsive.height * 3,
                      ),
                    ],
                  ),
                ))
              ],
            );
          }),
        ),
      ),
    );
  }

  // Individual period box
  Widget _periodBox(context,
      {required int period, bool isSelectedPeriod = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2), // Space between boxes
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ), // Padding inside the box
      decoration: BoxDecoration(
        color: isSelectedPeriod ? Colors.blue : whiteColor, // Box color
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26, width: 1), // Optional border
      ),
      child: Center(
        child: Text(
          'P$period', // Display period number
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: isSelectedPeriod ? whiteColor : blackColor, fontSize: 12),
        ),
      ),
    );
  }
}
