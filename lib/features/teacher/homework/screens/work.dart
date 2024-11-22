import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/homework/controller/homework_controller.dart';

// ignore: must_be_immutable
class HomeWork extends StatefulWidget {
  HomeWork({super.key});

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _markController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DropdownProvider dropdownProvider;
  late StudentIdController studentIdController;

  @override
  void initState() {
    super.initState();

    dropdownProvider = context.read<DropdownProvider>();
    studentIdController = context.read<StudentIdController>();
    // Clear dropdown selections when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('submissionType');
      dropdownProvider.clearSelectedItem('status');
      studentIdController.clearSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: 'Add Homework',
                isProfileIcon: false,
                onTap: () {
                  context.pushReplacementNamed(AppRouteConst.homeworkRouteName);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'classGrade',
                      label: 'Class',
                      items: ['8', '9', '10'],
                      icon: Icons.school,
                      onChanged: (selectedClass) {
                        final selectedDivision = context
                            .read<DropdownProvider>()
                            .getSelectedItem('division');
                        context
                            .read<StudentIdController>()
                            .getStudentsFromClassAndDivision(
                                className: selectedClass,
                                section: selectedDivision);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'division',
                      label: 'Division',
                      items: ['A', 'B', 'C'],
                      icon: Icons.group,
                      onChanged: (selectedDivision) {
                        final selectedClass = context
                            .read<DropdownProvider>()
                            .getSelectedItem('class');
                        context
                            .read<StudentIdController>()
                            .getStudentsFromClassAndDivision(
                                className: selectedClass,
                                section: selectedDivision);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 2),
              Row(
                children: [
                  // Start Date Field
                  Expanded(
                    child: CustomDatePicker(
                      label: "Start Date",
                      dateController: _startDateController,
                      onDateSelected: (selectedDate) {
                        print("Start Date selected: $selectedDate");
                      },
                    ),
                  ),
                  SizedBox(width: 10),

                  // End Date Field
                  Expanded(
                    child: CustomDatePicker(
                      label: "End Date",
                      dateController: _endDateController,
                      onDateSelected: (selectedDate) {
                        print("End Date selected: $selectedDate");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 2),
              CustomTextfield(
                hintText: "Subject",
                controller: _subjectController,
                iconData: const Icon(Icons.subject),
              ),
              SizedBox(height: Responsive.height * 2),
              CustomTextfield(
                hintText: "Total Mark",
                controller: _markController,
                iconData: const Icon(Icons.book),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                'Homework details',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: "Title",
                controller: _titleController,
                iconData: const Icon(Icons.text_fields),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                cursorHeight: 25.0, // Sets the cursor height
                style: const TextStyle(fontSize: 16),
                minLines: 4,
                maxLines: null,
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomDropdown(
                dropdownKey: 'submissionType',
                label: 'Submission Type',
                items: ['Online', 'Offline'],
                icon: Icons.offline_pin_outlined,
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomDropdown(
                dropdownKey: 'status',
                label: 'Status',
                items: ['Pending', 'Submitted', 'Graded'],
                icon: Icons.checklist,
              ),
              SizedBox(
                height: Responsive.height * 10,
              ),
              CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    final classGrade = context
                        .read<DropdownProvider>()
                        .getSelectedItem('classGrade');
                    final division = context
                        .read<DropdownProvider>()
                        .getSelectedItem('division');
                    final submissionType = context
                        .read<DropdownProvider>()
                        .getSelectedItem('submissionType');
                    final status = context
                        .read<DropdownProvider>()
                        .getSelectedItem('status');
                    final studentId = context
                        .read<StudentIdController>()
                        .getSelectedStudentId();

                    log(">>>>>>>>>>>>${studentId}");
                    context.read<HomeworkController>().addHomework(context,
                        class_grade: classGrade,
                        section: division,
                        subject: _subjectController.text,
                        assignment_title: _titleController.text,
                        description: _descriptionController.text,
                        assignment_date: _startDateController.text,
                        due_date: _endDateController.text,
                        submission_type: submissionType,
                        total_marks: _markController.text,
                        status: status,
                        studentsId: [1, 2]);
                  }),
              SizedBox(
                height: Responsive.height * 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
