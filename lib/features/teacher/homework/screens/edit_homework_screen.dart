import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/form_validators.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/features/teacher/homework/controller/homework_controller.dart';
import 'package:school_app/features/teacher/homework/model/homework_student_model.dart';

// ignore: must_be_immutable
class EditHomeworkScreen extends StatefulWidget {
  final HomeworkWithStudentsModel homeworkStudent;
  EditHomeworkScreen({
    super.key,
    required this.homeworkStudent,
  });

  @override
  State<EditHomeworkScreen> createState() => _EditHomeWorkScreenState();
}

class _EditHomeWorkScreenState extends State<EditHomeworkScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _markController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DropdownProvider dropdownProvider;
  late StudentIdController studentIdController;
  late SubjectController subjectController;

  @override
  void initState() {
    super.initState();
    _titleController.text =
        widget.homeworkStudent.homework?.assignmentTitle ?? "";
    _subjectController.text =
        widget.homeworkStudent.homework?.subjectName ?? "";
    _markController.text =
        widget.homeworkStudent.homework?.totalMarks.toString() ?? "0";
    _descriptionController.text =
        widget.homeworkStudent.homework?.description ?? "";
    _startDateController.text = widget.homeworkStudent.homework?.assignedDate !=
            null
        ? DateFormat('yyyy-MM-dd')
            .format(widget.homeworkStudent.homework?.assignedDate as DateTime)
        : "";

    _endDateController.text = widget.homeworkStudent.homework?.dueDate != null
        ? DateFormat('yyyy-MM-dd')
            .format(widget.homeworkStudent.homework?.dueDate as DateTime)
        : "";

    dropdownProvider = context.read<DropdownProvider>();
    studentIdController = context.read<StudentIdController>();
    subjectController = context.read<SubjectController>();
    // dropdownProvider.setSelectedItem("submissionType", "Online");
    // dropdownProvider.setSelectedItem("status", "Pending");

    // Clear dropdown selections when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // dropdownProvider.clearSelectedItem('submissionType');
      // dropdownProvider.clearSelectedItem('status');
      studentIdController.clearStudentIdsSelection();
      subjectController.clearSelection();
      if (studentIdController.selectedStudentIds.isNotEmpty) {
        studentIdController.clearSelection();
      }
      if (widget.homeworkStudent.assignedStudents?[0].assignedStudentClass !=
          null) {
        dropdownProvider.setSelectedItem(
            'classGrade',
            widget.homeworkStudent.assignedStudents?[0].assignedStudentClass ??
                "");
      }
      if (widget.homeworkStudent.assignedStudents?[0].section != null) {
        dropdownProvider.setSelectedItem('division',
            widget.homeworkStudent.assignedStudents?[0].section ?? "");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Responsive.height * 1,
                ),
                CustomAppbar(
                  title: 'Edit Homework',
                  isProfileIcon: false,
                  onTap: () {
                    Navigator.pop(context);
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
                SizedBox(height: Responsive.height * 1),
                Text("Selected students:"),
                SizedBox(height: 10),
                // Select Staffs
                InkWell(
                  onTap: () {
                    final classGrade = context
                        .read<DropdownProvider>()
                        .getSelectedItem('classGrade');
                    final division = context
                        .read<DropdownProvider>()
                        .getSelectedItem('division');
                    final classAndDivision = ClassAndDivision(
                        className: classGrade, section: division);
                    context.pushNamed(AppRouteConst.studentSelectionRouteName,
                        extra: classAndDivision);
                  },
                  child: Consumer<StudentIdController>(
                    builder: (context, value, child) {
                      // Get names of selected teachers
                      String selectedStudentNames = value.selectedStudentIds
                          .map((id) => value.students.firstWhere(
                              (student) => student['id'] == id)['full_name'])
                          .join(", "); // Concatenate names with a comma

                      return TextFormField(
                        decoration: InputDecoration(
                          hintText: value.selectedStudentIds.isEmpty
                              ? "Select Students"
                              : capitalizeEachWord(
                                  selectedStudentNames), // Display selected names or placeholder
                          enabled: false,
                        ),
                        validator: (value) => FormValidator.validateNotEmpty(
                            value,
                            fieldName: "Students"),
                      );
                    },
                  ),
                ),

                SizedBox(height: Responsive.height * 1.5),
                Row(
                  children: [
                    // Start Date Field
                    Expanded(
                      child: CustomDatePicker(
                        label: "Start Date",
                        dateController: _startDateController,
                        lastDate: DateTime(
                            2100), // Extend to a reasonable future date
                        initialDate: DateTime.now(),
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
                        lastDate: DateTime(
                            2100), // Extend to a reasonable future date
                        initialDate: DateTime.now(),
                        onDateSelected: (selectedDate) {
                          print("End Date selected: $selectedDate");
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height * 1),
                // TextFormField()

                Consumer<SubjectController>(
                  builder: (context, subjectProvider, child) {
                    return InkWell(
                      onTap: () {
                        context.pushNamed(
                          AppRouteConst.subjectSelectionRouteName,
                          extra: _subjectController,
                        );
                      },
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: subjectProvider.selectedSubjectId != null
                              ? capitalizeEachWord(subjectProvider.subjects
                                      .firstWhere((subject) =>
                                          subject.id ==
                                          subjectProvider.selectedSubjectId)
                                      .subject ??
                                  "") // Fetch the selected subject name
                              : "Select Subject", // Default hint text when no subject is selected
                        ),
                        enabled:
                            false, // Prevent editing as it's controlled by selection
                        validator: (value) => FormValidator.validateNotEmpty(
                            value,
                            fieldName: "Subject"),
                      ),
                    );
                  },
                ),
                SizedBox(height: Responsive.height * 1),
                CustomTextfield(
                  hintText: "Total Mark",
                  controller: _markController,
                  iconData: const Icon(Icons.book),
                ),
                SizedBox(
                  height: Responsive.height * 1,
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
                  items: ['Online', 'In-Class', 'Physical Copy'],
                  icon: Icons.offline_pin_outlined,
                ),
                SizedBox(
                  height: Responsive.height * 1,
                ),
                CustomDropdown(
                  dropdownKey: 'status',
                  label: 'Status',
                  items: ['Pending', 'Completed', 'Graded'],
                  icon: Icons.checklist,
                ),
                SizedBox(
                  height: Responsive.height * 1.6,
                ),
                Consumer2<StudentIdController, HomeworkController>(
                    builder: (context, value1, value2, child) {
                  return CommonButton(
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
                      final studentIds = value1.selectedStudentIds;
                      final selectedSubjectId =
                          Provider.of<SubjectController>(context, listen: false)
                              .selectedSubjectId;

                      log(">>>>>>>>>>>>${studentIds.toString()}");
                      context.read<HomeworkController>().editHomework(context,
                          homeworkId: widget.homeworkStudent.homework?.id ?? 0,
                          class_grade: classGrade,
                          section: division,
                          subjectId: selectedSubjectId ?? 0,
                          assignment_title: _titleController.text,
                          description: _descriptionController.text,
                          assigned_date: _startDateController.text,
                          due_date: _endDateController.text,
                          submission_type: submissionType,
                          total_marks: _markController.text,
                          status: status,
                          studentsId: studentIds);
                    },
                    widget:
                        value2.isloadingTwo ? ButtonLoading() : Text('Submit'),
                  );
                }),
                SizedBox(
                  height: Responsive.height * 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
