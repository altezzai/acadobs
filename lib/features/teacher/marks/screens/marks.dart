import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/button_loading.dart';
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
import 'package:school_app/features/teacher/marks/controller/marks_controller.dart';
import 'package:school_app/features/teacher/marks/models/marks_upload_model.dart';

// ignore: must_be_immutable
class ProgressReport extends StatefulWidget {
  ProgressReport({super.key});

  @override
  State<ProgressReport> createState() => _ProgressReportState();
}

class _ProgressReportState extends State<ProgressReport> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _totalMarkController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  late DropdownProvider dropdownProvider;

  @override
  void initState() {
    super.initState();
    dropdownProvider = context.read<DropdownProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: Responsive.height * 2),
              CustomAppbar(
                title: "Marks",
                onTap: () {
                  Navigator.pop(context);
                },
                isProfileIcon: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'class',
                      icon: Icons.school_outlined,
                      label: "Class*",
                      items: AppConstants.classNames,
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Class"),
                    ),
                  ),
                  SizedBox(width: Responsive.width * 1),
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'division',
                      icon: Icons.access_time,
                      label: "Division*",
                      items: AppConstants.divisions,
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Division"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 1),
              CustomTextfield(
                controller: _titleController,
                hintText: "Exam*",
                iconData: Icon(Icons.text_fields),
                validator: (value) =>
                    FormValidator.validateNotEmpty(value, fieldName: "Title"),
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
              //       ),
              //     );
              //   },
              // ),
              SizedBox(height: Responsive.height * 1),
              CustomDatePicker(
                label: "Date",
                dateController: _dateController,
                onDateSelected: (selectedDate) {
                  print("Date selected: $selectedDate");
                },
                validator: (value) =>
                    FormValidator.validateNotEmpty(value, fieldName: "Date"),
              ),
              SizedBox(height: Responsive.height * 1),
              CustomTextfield(
                controller: _totalMarkController,
                hintText: "Total Mark*",
                iconData: Icon(Icons.book),
                validator: (value) => FormValidator.validateNotEmpty(value,
                    fieldName: "Total Mark"),
              ),
              SizedBox(height: Responsive.height * 3),
              Consumer<MarksController>(builder: (context, value, child) {
                return CommonButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        final selectedClass = context
                            .read<DropdownProvider>()
                            .getSelectedItem('class');
                        final selectedDivision = context
                            .read<DropdownProvider>()
                            .getSelectedItem('division');
                        // final selectedSubject = context
                        //     .read<DropdownProvider>()
                        //     .getSelectedItem('subject');
                        final selectedSubjectId =
                            Provider.of<SubjectController>(context,
                                    listen: false)
                                .selectedSubjectId;

                        // Adding to model
                        final marksModel = MarksUploadModel(
                          classGrade: selectedClass,
                          section: selectedDivision,
                          title: _titleController.text,
                          date: _dateController.text,
                          subject: selectedSubjectId.toString(),
                          totalMarks: int.parse(_totalMarkController.text),
                        );

                        // Navigate to the next screen with the marks model
                        context.pushNamed(AppRouteConst.marksRouteName,
                            extra: marksModel);

                        // Clear the fields after successful submission
                        _titleController.clear();
                        _dateController.clear();
                        _totalMarkController.clear();
                        _subjectController.clear();
                        context
                            .read<DropdownProvider>()
                            .clearSelectedItem('class');
                        context
                            .read<DropdownProvider>()
                            .clearSelectedItem('division');
                        context
                            .read<DropdownProvider>()
                            .clearSelectedItem('subject');
                      } catch (e) {
                        // Handle any errors
                        CustomSnackbar.show(context,
                            message: "Failed to upload marks. Please try again",
                            type: SnackbarType.failure);
                      }
                    } else {
                      CustomSnackbar.show(context,
                          message: "Please complete all required fields",
                          type: SnackbarType.warning);
                    }
                  },
                  widget:
                      value.isloading ? ButtonLoading() : Text('Enter Marks'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
