import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
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
import 'package:school_app/features/teacher/marks/controller/marks_controller.dart';
import 'package:school_app/features/teacher/marks/models/marks_upload_model.dart';

// ignore: must_be_immutable
class ProgressReport extends StatelessWidget {
  ProgressReport({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _totalMarkController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomAppbar(
                title: "Progress Report",
                isBackButton: false,
                isProfileIcon: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'class',
                      icon: Icons.school_outlined,
                      label: "Select Class",
                      items: ["6", "7", "8", "9", "10"],
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
                      label: "Select Division",
                      items: ["A", "B", "C", "D", "E"],
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
                hintText: "Exam",
                iconData: Icon(Icons.text_fields),
                validator: (value) =>
                    FormValidator.validateNotEmpty(value, fieldName: "Title"),
              ),
              SizedBox(height: Responsive.height * 1),
              CustomDropdown(
                dropdownKey: 'subject',
                icon: Icons.access_time,
                label: "Select Subject",
                items: ["Physics", "Chemistry", "Mathematics"],
                validator: (value) =>
                    FormValidator.validateNotEmpty(value, fieldName: "Subject"),
              ),
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
                hintText: "Total Mark",
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
                        final selectedSubject = context
                            .read<DropdownProvider>()
                            .getSelectedItem('subject');

                        // Adding to model
                        final marksModel = MarksUploadModel(
                          classGrade: selectedClass,
                          section: selectedDivision,
                          title: _titleController.text,
                          date: _dateController.text,
                          subject: selectedSubject,
                          totalMarks: int.parse(_totalMarkController.text),
                        );

                        // Navigate to the next screen with the marks model
                        context.pushNamed(AppRouteConst.marksRouteName,
                            extra: marksModel);

                        // Clear the fields after successful submission
                        _titleController.clear();
                        _dateController.clear();
                        _totalMarkController.clear();
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
