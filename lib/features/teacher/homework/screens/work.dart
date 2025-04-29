import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
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

// ignore: must_be_immutable
class HomeWork extends StatefulWidget {
  HomeWork({super.key});

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  // final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _markController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DropdownProvider dropdownProvider;
  late StudentIdController studentIdController;
  late SubjectController subjectController;

  @override
  void initState() {
    super.initState();
    // _titleController.text = "Activity ";
    // _markController.text = "20";
    // _descriptionController.text = "One page essay";

    dropdownProvider = context.read<DropdownProvider>();
    studentIdController = context.read<StudentIdController>();
    subjectController = context.read<SubjectController>();
    // dropdownProvider.setSelectedItem("submissionType", "Online");
    // dropdownProvider.setSelectedItem("status", "Pending");
    // Clear dropdown selections when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('classGrade');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('submissionType');
      dropdownProvider.clearSelectedItem('status');
      studentIdController.clearStudentIdsSelection();
      subjectController.clearSelection();
      if (studentIdController.selectedStudentIds.isNotEmpty) {
        studentIdController.clearSelection();
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
                  height: Responsive.height * 2,
                ),
                CustomAppbar(
                  title: 'Add Homework',
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
                        label: 'Class*',
                        items: AppConstants.classNames,
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
                        validator: (value) => FormValidator.validateNotEmpty(
                            value,
                            fieldName: "Class"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomDropdown(
                        dropdownKey: 'division',
                        label: 'Division*',
                        items: AppConstants.divisions,
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
                        validator: (value) => FormValidator.validateNotEmpty(
                            value,
                            fieldName: "Division"),
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
                              ? "Select Students*"
                              : capitalizeEachWord(
                                  selectedStudentNames), // Display selected names or placeholder
                          enabled: false,
                        ),
                        //  validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Students"),
                      );
                    },
                  ),
                ),

                SizedBox(height: Responsive.height * 1),
                Row(
                  children: [
                    // Start Date Field
                    Expanded(
                      child: CustomDatePicker(
                        label: "Start Date*",
                        dateController: _startDateController,
                        lastDate: DateTime(
                            2100), // Extend to a reasonable future date
                        initialDate: DateTime.now(),
                        onDateSelected: (selectedDate) {
                          print("Start Date selected: $selectedDate");
                        },
                        validator: (value) => FormValidator.validateNotEmpty(
                            value,
                            fieldName: "Start Date"),
                      ),
                    ),
                    SizedBox(width: 10),

                    // End Date Field
                    Expanded(
                      child: CustomDatePicker(
                        label: "End Date*",
                        dateController: _endDateController,
                        lastDate: DateTime(
                            2100), // Extend to a reasonable future date
                        initialDate: DateTime.now(),
                        onDateSelected: (selectedDate) {
                          print("End Date selected: $selectedDate");
                        },
                        validator: (value) => FormValidator.validateNotEmpty(
                            value,
                            fieldName: "End Date"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height * 1),
                // Consumer<SubjectController>(
                //   builder: (context, subjectProvider, child) {
                //     return InkWell(
                //       onTap: () {
                //         context.pushNamed(
                //           AppRouteConst.subjectSelectionRouteName,
                //           extra: _subjectController,
                //         );
                //       },
                //       child: TextFormField(
                //         decoration: InputDecoration(
                //           hintText: subjectProvider.selectedSubjectId != null
                //               ? capitalizeEachWord(subjectProvider.subjects
                //                       .firstWhere((subject) =>
                //                           subject.id ==
                //                           subjectProvider.selectedSubjectId)
                //                       .subject ??
                //                   "") // Fetch the selected subject name
                //               : "Select Subject*", // Default hint text when no subject is selected
                //         ),
                //         enabled:
                //             false, // Prevent editing as it's controlled by selection
                //         // validator: (value) => FormValidator.validateNotEmpty(
                //         //     value,
                //         //     fieldName: "Subject"),
                //       ),
                //     );
                //   },
                // ),
                SizedBox(height: Responsive.height * 1),
                CustomTextfield(
                  hintText: "Total Mark*",
                  controller: _markController,
                  iconData: const Icon(Icons.book),
                  validator: (value) => FormValidator.validateNotEmpty(value,
                      fieldName: "Total Mark"),
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
                  hintText: "Title*",
                  controller: _titleController,
                  iconData: const Icon(Icons.text_fields),
                  validator: (value) =>
                      FormValidator.validateNotEmpty(value, fieldName: "Title"),
                ),
                SizedBox(
                  height: Responsive.height * 1,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Description*",
                  ),
                  validator: (value) => FormValidator.validateNotEmpty(value,
                      fieldName: "Description"),
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
                  label: 'Submission Type*',
                  items: ['Online', 'In-Class', 'Physical Copy'],
                  icon: Icons.offline_pin_outlined,
                  validator: (value) => FormValidator.validateNotEmpty(value,
                      fieldName: "Submission Type"),
                ),
                SizedBox(
                  height: Responsive.height * 1,
                ),
                CustomDropdown(
                  dropdownKey: 'status',
                  label: 'Status*',
                  items: ['Pending', 'Completed', 'Graded'],
                  icon: Icons.checklist,
                  validator: (value) => FormValidator.validateNotEmpty(value,
                      fieldName: "Status"),
                ),
                SizedBox(
                  height: Responsive.height * 1.6,
                ),
                Consumer2<StudentIdController, HomeworkController>(
                    builder: (context, value1, value2, child) {
                  return CommonButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
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
                              Provider.of<SubjectController>(context,
                                      listen: false)
                                  .selectedSubjectId;

                          log(">>>>>>>>>>>>${studentIds.toString()}");
                          context.read<HomeworkController>().addHomework(
                              context,
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
                        } catch (e) {
                          // Handle any errors and show an error message
                          CustomSnackbar.show(context,
                              message:
                                  "Failed to add Homework.Please try again",
                              type: SnackbarType.failure);
                        }
                      } else {
                        // Highlight missing fields if the form is invalid
                        CustomSnackbar.show(context,
                            message: "Please complete all required fields",
                            type: SnackbarType.warning);
                      }
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
