import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/features/teacher/marks/models/marks_upload_model.dart';
import 'package:school_app/features/teacher/marks/widgets/mark_tile.dart';

// ignore: must_be_immutable
class StudentMarklist extends StatefulWidget {
  final MarksUploadModel marksUploadModel;
  StudentMarklist({
    super.key,
    required this.marksUploadModel,
  });

  @override
  State<StudentMarklist> createState() => _StudentMarklistState();
}

class _StudentMarklistState extends State<StudentMarklist> {
// Maps to hold controllers for each student
  final Map<int, TextEditingController> markControllers = {};
  final Map<int, TextEditingController> gradeControllers = {};

  // List to store final data
  final List<Map<String, dynamic>> studentMarksList = [];

  late StudentIdController studentIdController;
  @override
  void initState() {
    super.initState();
    studentIdController = context.read<StudentIdController>();
    studentIdController.getStudentsFromClassAndDivision(
        className: widget.marksUploadModel.classGrade ?? "",
        section: widget.marksUploadModel.section ?? "");
  }

  void collectStudentData() {
    studentMarksList.clear(); // Clear previous data

    for (int index = 0; index < studentIdController.students.length; index++) {
      final student = studentIdController.students[index];
      final marks = markControllers[index]?.text ?? "";
      final attendanceStatus = "Present"; // You can make this dynamic if needed

      studentMarksList.add({
        "student_id": student['id'],
        "marks": marks,
        "attendance_status": attendanceStatus,
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
              onTap: () {
                Navigator.pop(context);
              },
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
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Total: ${widget.marksUploadModel.totalMarks}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold, color: blackColor),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Consumer<StudentIdController>(builder: (context, value, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.students.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final student = value.students[index];
                  // Initialize controllers for each student if not already done
                  markControllers.putIfAbsent(
                      index, () => TextEditingController());
                  gradeControllers.putIfAbsent(
                      index, () => TextEditingController());
                  return MarkTile(
                    studentName: capitalizeFirstLetter(student['full_name']),
                    studentNumber: (index + 1).toString(),
                    markController: markControllers[index]!,
                    gradeController: gradeControllers[index]!,
                  );
                },
              );
            }),
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomButton(
                text: "Submit",
                onPressed: () {
                  collectStudentData();
                }),
            SizedBox(
              height: Responsive.height * 2,
            ),
          ],
        ),
      ),
    ));
  }
}
