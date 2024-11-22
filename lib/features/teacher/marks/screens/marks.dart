import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/marks/models/marks_upload_model.dart';

// ignore: must_be_immutable
class ProgressReport extends StatelessWidget {
  ProgressReport({super.key});

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _totalMarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomAppbar(
              title: "Progress Report",
              isBackButton: false,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a class";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: Responsive.width * 1),
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'division',
                    icon: Icons.access_time,
                    label: "Select Division",
                    items: ["A", "B", "C", "D", "E"],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a division";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              hintText: "Exam",
              iconData: Icon(Icons.text_fields),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomDropdown(
              dropdownKey: 'subject',
              icon: Icons.access_time,
              label: "Select Subject",
              items: ["Physics", "Chemistry", "Mathematics"],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a subject";
                }
                return null;
              },
            ),
            SizedBox(height: Responsive.height * 1),
            CustomDatePicker(
              label: "Date",
              dateController: _dateController,
              onDateSelected: (selectedDate) {
                print("Date selected: $selectedDate");
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a date";
                }
                return null;
              },
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              controller: _totalMarkController,
              hintText: "Total Mark",
              iconData: Icon(Icons.book),
            ),
            SizedBox(height: Responsive.height * 3),
            CustomButton(
                text: "Enter Marks",
                onPressed: () {
                  final selectedClass =
                      context.read<DropdownProvider>().getSelectedItem('class');
                  final selectedDivision = context
                      .read<DropdownProvider>()
                      .getSelectedItem('division');
                  final selectedSubject = context
                      .read<DropdownProvider>()
                      .getSelectedItem('subject');

                  // adding to model
                  final marksModel = MarksUploadModel(
                      classGrade: selectedClass,
                      section: selectedDivision,
                      date: _dateController.text,
                      subject: selectedSubject,
                      totalMarks: int.parse(_totalMarkController.text));
                  context.pushNamed(AppRouteConst.marksRouteName,
                      extra: marksModel);
                })
          ],
        ),
      ),
    );
  }
}
