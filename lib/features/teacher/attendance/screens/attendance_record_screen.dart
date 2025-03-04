import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_record_model.dart';
import 'package:school_app/features/teacher/attendance/model/edit_attendance_request.dart';
import 'package:school_app/features/teacher/attendance/widgets/attendance_widget.dart';

class AttendanceRecordScreen extends StatefulWidget {
  final AttendanceRecord attendanceRecord;
  final bool forEditScreen;
  const AttendanceRecordScreen(
      {super.key, required this.attendanceRecord, required this.forEditScreen});

  @override
  State<AttendanceRecordScreen> createState() => _AttendanceRecordScreenState();
}

class _AttendanceRecordScreenState extends State<AttendanceRecordScreen> {
  List<EditAttendanceRequest> attendanceList = [];

  void updateAttendanceStatus(int id, String newStatus) {
    setState(() {
      var existingIndex = attendanceList.indexWhere((item) => item.id == id);

      if (existingIndex != -1) {
        // Update existing entry
        attendanceList[existingIndex].attendanceStatus = newStatus;
      } else {
        // Add new entry with a default remark
        attendanceList.add(EditAttendanceRequest(
          id: id,
          attendanceStatus: newStatus,
          remarks: "Updated", // Set a default remark
        ));
      }
    });
  }

  // Future<void> submitAttendance(BuildContext context) async {
  //   // Call API function with the updated list
  //   await AttendanceController().updateAttendance(
  //       context: context,
  //       attendanceData: attendanceList,
  //       date: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: widget.forEditScreen
            ? "Edit Attendance"
            : " ${widget.attendanceRecord.classGrade} ${widget.attendanceRecord.section} - Period NO: ${widget.attendanceRecord.periodNumber}",
        isBackButton: true,
        actions: [
          CustomPopupMenu(
              onEdit: () {
                context.pushNamed(AppRouteConst.attendanceRecordRouteName,
                    extra: AttendanceRecordArguments(
                        forEditScreen: true,
                        attendanceRecord: widget.attendanceRecord));
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
              widget.forEditScreen
                  ? Text(
                      " ${widget.attendanceRecord.classGrade} ${widget.attendanceRecord.section} - Period NO: ${widget.attendanceRecord.periodNumber}")
                  : SizedBox.shrink(),
              Text(
                  "Date: ${DateFormatter.formatDateTime(widget.attendanceRecord.date ?? DateTime.now())}"),
              Text(
                  "Subject: ${capitalizeEachWord(widget.attendanceRecord.subjectName ?? "")} "),
              SizedBox(
                height: Responsive.height * 2,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.attendanceRecord.students?.length,
                  itemBuilder: (context, index) {
                    final student = widget.attendanceRecord.students?[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: widget.forEditScreen
                          ? AttendanceWidget(
                              forEditScreen: true,
                              initialStatus: student?.attendanceStatus ?? "",
                              rollNo: (student?.studentId).toString(),
                              studentName:
                                  capitalizeEachWord(student?.fullName ?? ""),
                              attendanceId: student?.id ?? 0,
                              onStatusChanged: updateAttendanceStatus,
                            )
                          : AttendanceWidget(
                              initialStatus: student?.attendanceStatus ?? "",
                              rollNo: (student?.studentId).toString(),
                              studentName:
                                  capitalizeEachWord(student?.fullName ?? ""),
                              attendanceId: student?.id ?? 0,
                              onStatusChanged: (value, value2) {}),
                    );
                  }),
              SizedBox(
                height: Responsive.height * 2,
              ),
              widget.forEditScreen
                  ? Consumer<AttendanceController>(
                      builder: (context, value, child) {
                      return CommonButton(
                          onPressed: () {
                            context
                                .read<AttendanceController>()
                                .updateAttendance(
                                    context: context,
                                    attendanceData: attendanceList,
                                    date: DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now()));
                          },
                          widget: value.isloadingTwo
                              ? ButtonLoading()
                              : Text("Submit"));
                    })
                  : SizedBox.shrink(),
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
