import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/features/admin/duties/widgets/staff_selection_card.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';

class TeacherSelectionScreen extends StatefulWidget {
  const TeacherSelectionScreen({super.key});

  @override
  State<TeacherSelectionScreen> createState() => _TeacherSelectionScreenState();
}

class _TeacherSelectionScreenState extends State<TeacherSelectionScreen> {
  late TeacherController teacherController;
  @override
  void initState() {
    teacherController = context.read<TeacherController>();
    teacherController.getTeacherDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Select Staffs",
        isBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<TeacherController>(builder: (context, value, child) {
            return value.isloading
                ? Column(
                    children: [
                      SizedBox(
                        height: Responsive.height * 38,
                      ),
                      Loading(
                        color: Colors.grey,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: Responsive.height * 2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: value.teachers.length,
                          itemBuilder: (context, index) {
                            final teacher = value.teachers[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: StaffSelectionCard(
                                  name: teacher.fullName ?? "",
                                  staffId: teacher.id ?? 0,
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
          Consumer<TeacherController>(builder: (context, value, child) {
        return Padding(
            padding: const EdgeInsets.all(16),
            child: CommonButton(
              onPressed: () {
                if (value.selectedTeacherIds.isEmpty) {
                  CustomSnackbar.show(context,
                      message: "Select Staffs to Continue",
                      type: SnackbarType.warning,
                      bottomPadding: Responsive.height * 10);
                } else {
                  Navigator.pop(context);
                }
              },
              widget: Text('Select'),
            )
            //  CustomButton(
            //     text: "Select",
            //     onPressed: () {
            //       if (value.selectedTeacherIds.isEmpty) {
            //         CustomSnackbar.show(context,
            //             message: "Select Staffs to Continue",
            //             type: SnackbarType.warning,
            //             bottomPadding: Responsive.height * 10);
            //       } else {
            //         Navigator.pop(context);
            //       }
            //     }),
            );
      }),
    );
  }
}
