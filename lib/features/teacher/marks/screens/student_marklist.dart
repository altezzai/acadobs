import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/marks/controller/marks_controller.dart';
import 'package:school_app/features/teacher/marks/models/marks_upload_model.dart';
import 'package:school_app/features/teacher/marks/widgets/mark_tile.dart';

class StudentMarklist extends StatefulWidget {
  final MarksUploadModel marksUploadModel;

  const StudentMarklist({
    super.key,
    required this.marksUploadModel,
  });

  @override
  State<StudentMarklist> createState() => _StudentMarklistState();
}

class _StudentMarklistState extends State<StudentMarklist> {
  final Map<int, TextEditingController> markControllers = {};
  final Map<int, TextEditingController> gradeControllers = {};

  final List<Map<String, dynamic>> studentMarksList = [];

  late StudentIdController studentIdController;

  @override
  void initState() {
    super.initState();
    studentIdController = context.read<StudentIdController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentIdController.getStudentsFromClassAndDivision(
        className: widget.marksUploadModel.classGrade ?? "",
        section: widget.marksUploadModel.section ?? "",
      );
    });
  }

  // Collects all the student data with marks and attendance
  void collectStudentData(BuildContext context) {
    studentMarksList.clear();

    for (int index = 0; index < studentIdController.students.length; index++) {
      final student = studentIdController.students[index];
      final marks = int.tryParse(markControllers[index]?.text ?? "0") ?? 0;

      // Find the updated studentMark using the correct studentId
      final studentMark = widget.marksUploadModel.students?.firstWhere(
          (element) => element.studentId == student['id'],
          orElse: () => StudentMark(
              studentId: student['id'], attendanceStatus: 'Present'));

      if (marks == 0) {
        log("Error: Marks not entered for student ${student['id']}");
        continue;
      }

      // Add the student data to the list, ensuring attendance status is correct
      studentMarksList.add({
        "student_id": student['id'],
        "marks": marks,
        "attendance_status": studentMark?.attendanceStatus ?? 'Present',
      });
    }

    log("Collected Student Data: $studentMarksList");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomAppbar(
                title:
                    "${widget.marksUploadModel.classGrade}th ${widget.marksUploadModel.section}",
                isBackButton: true,
                onTap: () => Navigator.pop(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.marksUploadModel.date}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Total: ${widget.marksUploadModel.totalMarks}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold, color: blackColor),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 2),
              Consumer<StudentIdController>(
                builder: (context, value, child) {
                  if (value.students.isEmpty) {
                    return Center(child: Text("No students found."));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.students.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final student = value.students[index];
                      markControllers.putIfAbsent(
                          index, () => TextEditingController());
                      gradeControllers.putIfAbsent(
                          index, () => TextEditingController());

                      // Find the attendance status from MarksUploadModel
                      final studentMark = widget.marksUploadModel.students
                          ?.firstWhere(
                              (element) => element.studentId == student['id'],
                              orElse: () => StudentMark(
                                  studentId: student['id'],
                                  attendanceStatus: 'Present'));

                      final attendanceStatus =
                          studentMark?.attendanceStatus ?? 'Present';

                      return MarkTile(
                        studentName:
                            capitalizeFirstLetter(student['full_name']),
                        studentNumber: (index + 1).toString(),
                        markController: markControllers[index]!,
                        gradeController: gradeControllers[index]!,
                        attendanceStatus: attendanceStatus,
                        onAttendanceChanged: (status) {
                          // Update the attendance status directly in the list
                          setState(() {
                            final studentIndex = widget
                                .marksUploadModel.students
                                ?.indexWhere((element) =>
                                    element.studentId == student['id']);
                            if (studentIndex != null && studentIndex >= 0) {
                              widget.marksUploadModel.students![studentIndex] =
                                  StudentMark(
                                studentId: student['id'],
                                attendanceStatus: status ?? 'Present',
                              );
                            }
                          });
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: Responsive.height * 2),
              Consumer<MarksController>(builder: (context, marksController, _) {
                return CommonButton(
                  onPressed: () {
                    collectStudentData(context); // Prepare the data

                    if (studentMarksList.isNotEmpty) {
                      marksController.addMarks(
                        context: context,
                        date: widget.marksUploadModel.date ?? "",
                        title: widget.marksUploadModel.title ?? "",
                        className: widget.marksUploadModel.classGrade ?? "",
                        subject: widget.marksUploadModel.subject ?? "",
                        section: widget.marksUploadModel.section ?? "",
                        totalMarks: widget.marksUploadModel.totalMarks ?? 0,
                        students: studentMarksList, // Pass the list here
                      );
                    } else {
                      log("No valid student data to submit.");
                    }
                  },
                  widget: marksController.isloadingTwo
                      ? ButtonLoading()
                      : Text('Submit'),
                );
              }),
              SizedBox(height: Responsive.height * 2),
            ],
          ),
        ),
      ),
    );
  }
}
