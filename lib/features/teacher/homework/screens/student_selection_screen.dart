import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/features/teacher/homework/widgets/student_selection_card.dart';

class StudentSelectionScreen extends StatefulWidget {
  final ClassAndDivision classAndDivision;
  const StudentSelectionScreen({super.key, required this.classAndDivision});

  @override
  State<StudentSelectionScreen> createState() => _StudentSelectionState();
}

class _StudentSelectionState extends State<StudentSelectionScreen> {
  late StudentIdController studentIdController;
  @override
  void initState() {
    studentIdController = context.read<StudentIdController>();
    studentIdController.getStudentsFromClassAndDivision(
        className: widget.classAndDivision.className,
        section: widget.classAndDivision.section);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Students"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Consumer<StudentIdController>(builder: (context, value, child) {
            return Column(
              children: [
                SizedBox(
                  height: Responsive.height * 2,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.students.length,
                    itemBuilder: (context, index) {
                      final student = value.students[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: StudentSelectionCard(
                            name: student['full_name'],
                            studentId: student['id'],
                            index: index),
                      );
                    }),
                SizedBox(
                  height: Responsive.height * 10,
                ),
              ],
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Consumer<StudentIdController>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
              text: "Select",
              onPressed: () {
                if (value.selectedStudentIds.isEmpty) {
                  CustomSnackbar.show(context,
                      message: "Select Students to Continue",
                      type: SnackbarType.warning,
                      bottomPadding: Responsive.height * 10);
                } else {
                  Navigator.pop(context);
                }
              }),
        );
      }),
    );
  }
}
