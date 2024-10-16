import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/data/dropdown_data.dart';
import 'package:school_app/features/teacher/widgets/custom_dropdown_2.dart';

// ignore: must_be_immutable
class ProgressReport extends StatelessWidget {
  ProgressReport({super.key});

  List<DropdownMenuItem<String>> allClasses = DropdownData.allClasses;
  List<DropdownMenuItem<String>> allDivisions = DropdownData.allDivisions;
  List<DropdownMenuItem<String>> subjects = DropdownData.subjects;

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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: CustomDropdown(
            //           icon: Icons.school,
            //           label: "Select Class",
            //           items: ["1", "2", "3", "4", "5"]),
            //     ),
            //     // SizedBox(width: Responsive.width * 6),
            //     Expanded(
            //       child: CustomDropdown(
            //           icon: Icons.school,
            //           label: "Select Period",
            //           items: ["A", "B", "C", "D", "E"]),
            //     ),
            //   ],
            // ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              hintText: "Exam",
              iconData: Icon(Icons.text_fields),
            ),
            SizedBox(height: Responsive.height * 1),

            // Dropdown for Selecting Subjects
            // CustomDropdown(icon: Icons.school, label: "Select Subject", items: [
            //   "Physics",
            //   "Chemistry",
            // ]),
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
                  context.pushNamed(AppRouteConst.marksRouteName);
                })
          ],
        ),
      ),
    );
  }
}
