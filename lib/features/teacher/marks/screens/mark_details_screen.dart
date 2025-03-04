import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/marks/controller/marks_controller.dart';
import 'package:school_app/features/teacher/marks/models/teacher_added_marks.dart';
import 'package:school_app/features/teacher/marks/widgets/MarkDetailsTile.dart';

class Markdetailsscreen extends StatefulWidget {
  final TeacherAddedMarks teacherAddedMarksModel;
  const Markdetailsscreen({super.key, required this.teacherAddedMarksModel});

  @override
  State<Markdetailsscreen> createState() => _MarkdetailsscreenState();
}

class _MarkdetailsscreenState extends State<Markdetailsscreen> {
  final Map<int, TextEditingController> markControllers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MarksController>().getTeacherMarks();
    });

    // Debug: Print student details
    print("Students List: ${widget.teacherAddedMarksModel.students}");

    // Initialize controllers
    for (var student in widget.teacherAddedMarksModel.students ?? []) {
      markControllers[student.studentId!] =
          TextEditingController(text: student.marks?.toString() ?? '');
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in markControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Responsive.height * 2),
              CustomAppbar(
                title: widget.teacherAddedMarksModel.title ?? "",
                isProfileIcon: false,
                isBackButton: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: Responsive.height * 1),
              Text(
                widget.teacherAddedMarksModel.subject ?? "",
                style: textThemeData.headlineLarge!.copyWith(fontSize: 20),
              ),
              SizedBox(height: Responsive.height * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormatter.formatDateString(
                        widget.teacherAddedMarksModel.date.toString()),
                    style: textThemeData.bodySmall!.copyWith(fontSize: 14),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Total: ${(widget.teacherAddedMarksModel.totalMarks)}',
                    style: textThemeData.bodySmall!.copyWith(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 1),
              Consumer<MarksController>(
                builder: (context, value, child) {
                  if (widget.teacherAddedMarksModel.students == null ||
                      widget.teacherAddedMarksModel.students!.isEmpty) {
                    return Center(child: Text("No students found."));
                  }

                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: widget.teacherAddedMarksModel.students?.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final student =
                            widget.teacherAddedMarksModel.students?[index];

                        // Debug: Print student name
                        print("Student $index: ${student?.studentName}");

                        if (student == null) {
                          return Text("Error: Student data is missing");
                        }

                        // Find attendance status
                        final studentMark =
                            widget.teacherAddedMarksModel.students?.firstWhere(
                          (element) => element.studentId == student.studentId,
                          orElse: () => StudentMarks(
                            studentId: student.studentId,
                            attendanceStatus: 'Present',
                          ),
                        );

                        final attendanceStatus =
                            studentMark?.attendanceStatus ?? 'Present';

                        return MarkDetailsTile(
                          studentName: capitalizeFirstLetter(
                              student.studentName ?? "No Name"),
                          studentNumber: (index + 1).toString(),
                          markController: markControllers[student.studentId]!,
                          attendanceStatus: attendanceStatus,
                          // onAttendanceChanged: (status) {
                          //   setState(() {
                          //     final studentIndex = widget
                          //         .teacherAddedMarksModel.students
                          //         ?.indexWhere((element) =>
                          //             element.studentId == student.studentId);
                          //     if (studentIndex != null && studentIndex >= 0) {
                          //       widget.teacherAddedMarksModel.students![studentIndex] =
                          //           StudentMarks(
                          //         studentId: student.studentId,
                          //         attendanceStatus: status ?? 'Present',
                          //       );
                          //     }
                          //   });
                          // },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
