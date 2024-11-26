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
  TextEditingController markController = TextEditingController();

  TextEditingController gradeController = TextEditingController();

  late StudentIdController studentIdController;
  @override
  void initState() {
    super.initState();
    studentIdController = context.read<StudentIdController>();
    studentIdController.getStudentsFromClassAndDivision(
        className: widget.marksUploadModel.classGrade ?? "",
        section: widget.marksUploadModel.section ?? "");
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
                  return MarkTile(
                      studentName: capitalizeFirstLetter(student['full_name']),
                      studentNumber: (index + 1).toString(),
                      markController: markController,
                      gradeController: gradeController);
                },
              );
            }),
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomButton(text: "Submit", onPressed: () {}),
            SizedBox(
              height: Responsive.height * 2,
            ),
          ],
        ),
      ),
    ));
  }
}
