import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/teacher/attendance/widgets/custom_dropdown.dart';
import 'package:school_app/utils/responsive.dart';

class ProgressReport extends StatelessWidget {
  const ProgressReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: Responsive.height * 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Responsive.width * 30,
                ),
                Text(
                  "Attendance",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/admin.png'),
                ),
              ],
            ),
            SizedBox(height: Responsive.height * 5),
            Row(
              children: [
                const Expanded(
                  child: CustomDropdown(title: "Class", icon: Icons.school),
                ),
                SizedBox(width: Responsive.width * 6),
                const Expanded(
                  child: CustomDropdown(
                      title: "Division", icon: Icons.filter_list),
                ),
              ],
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              hintText: "Exam",
              iconData: Icon(Icons.text_fields),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomDropdown(title: "Select Subject", icon: Icons.note),
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
            CustomButton(text: "Enter Mark", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
