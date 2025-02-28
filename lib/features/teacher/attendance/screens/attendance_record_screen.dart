import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_record_model.dart';
import 'package:school_app/features/teacher/attendance/widgets/attendance_widget.dart';

class AttendanceRecordScreen extends StatelessWidget {
  final AttendanceRecord attendanceRecord;
  final bool forEditScreen;
  const AttendanceRecordScreen(
      {super.key, required this.attendanceRecord, required this.forEditScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: forEditScreen
            ? "Edit Attendance"
            : " ${attendanceRecord.classGrade} ${attendanceRecord.section} - Period NO: ${attendanceRecord.periodNumber}",
        isBackButton: true,
        actions: [
          CustomPopupMenu(
              onEdit: () {
                context.pushNamed(AppRouteConst.attendanceRecordRouteName,
                    extra: AttendanceRecordArguments(
                        forEditScreen: true,
                        attendanceRecord: attendanceRecord));
              },
              onDelete: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.height * 3,
              ),
              forEditScreen
                  ? Text(
                      " ${attendanceRecord.classGrade} ${attendanceRecord.section} - Period NO: ${attendanceRecord.periodNumber}")
                  : SizedBox.shrink(),
              Text(
                  "Date: ${DateFormatter.formatDateTime(attendanceRecord.date ?? DateTime.now())}"),
              Text(
                  "Subject: ${capitalizeEachWord(attendanceRecord.subjectName ?? "")} "),
              SizedBox(
                height: Responsive.height * 2,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: attendanceRecord.students?.length,
                  itemBuilder: (context, index) {
                    final student = attendanceRecord.students?[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AttendanceWidget(
                          status: student?.attendanceStatus ?? "",
                          rollNo: (student?.studentId).toString(),
                          studentName: "Student Name"),
                    );
                  }),
              SizedBox(
                height: Responsive.height * 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
