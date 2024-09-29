import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/controller/dropdown_controller.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/global%20widgets/custom_dropdown.dart';
import 'package:school_app/teacher/data/dropdown_data.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class ProgressReport extends StatelessWidget {
  ProgressReport({super.key});

  List<DropdownMenuItem<String>> allClasses = DropdownData.allClasses;
  List<DropdownMenuItem<String>> allDivisions = DropdownData.allDivisions;
  List<DropdownMenuItem<String>> subjects = DropdownData.subjects;

  @override
  Widget build(BuildContext context) {
    final dropdownProvider = Provider.of<DropdownProvider>(context);
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
              children: [
                Expanded(
                  child: CustomDropdown(
                    title: 'Select  Class',
                    icon: Icons.school,
                    items: allClasses,
                    selectedValue: dropdownProvider.selectedClass,
                    onChanged: (value) {
                      dropdownProvider.setSelectedClass(
                          value); // Update the state using provider
                    },
                  ),
                ),
                SizedBox(width: Responsive.width * 6),
                Expanded(
                  child: CustomDropdown(
                    title: 'Select Division',
                    icon: Icons.format_shapes_sharp,
                    items: allDivisions,
                    selectedValue: dropdownProvider.selectedDivision,
                    onChanged: (value) {
                      dropdownProvider.setSelectedDivision(
                          value); // Update the state using provider
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

            // Dropdown for Selecting Subjects
            CustomDropdown(
              title: 'Select Subject',
              icon: Icons.book,
              items: subjects,
              selectedValue: dropdownProvider.selectedSubject,
              onChanged: (value) {
                dropdownProvider.setSelectedSubject(
                    value); // Update the state using provider
              },
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              hintText: "dd/mm/yyyy",
              iconData: const Icon(Icons.calendar_month),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              hintText: "Total Mark",
              iconData: Icon(Icons.book),
            ),
            SizedBox(height: Responsive.height * 3),
            CustomButton(
                text: "Enter Mark",
                onPressed: () {
                  context.pushReplacementNamed(AppRouteConst.marksRouteName);
                })
          ],
        ),
      ),
    );
  }
}
