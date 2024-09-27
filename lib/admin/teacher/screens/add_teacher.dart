import 'package:flutter/material.dart';
import 'package:school_app/admin/teacher/screens/teachers_list.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/utils/responsive.dart';

class AddTeacher extends StatelessWidget {
  const AddTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomAppbar(
              title: "Add Teacher",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => TeachersListScreen(),
                  ),
                );
              },
            ),
            Expanded(
              child: Column(
                children: [
                  CustomTextfield(
                    hintText: "Teacher Name",
                    iconData: const Icon(Icons.person_2_outlined),
                  ),
                  SizedBox(
                    height: Responsive.height * 2,
                  ),
                  CustomTextfield(
                    hintText: "ID No:",
                    iconData: const Icon(Icons.numbers),
                  ),
                  SizedBox(
                    height: Responsive.height * 2,
                  ),
                  CustomTextfield(
                    hintText: "Contact Number",
                    iconData: const Icon(Icons.phone),
                  ),
                  SizedBox(
                    height: Responsive.height * 2,
                  ),
                  CustomTextfield(
                    hintText: "Date of Joining",
                    iconData: const Icon(Icons.calendar_month),
                  ),
                  SizedBox(
                    height: Responsive.height * 2,
                  ),
                  CustomTextfield(
                    hintText: "Class in Charge",
                    iconData: const Icon(Icons.school),
                  ),
                  SizedBox(
                    height: Responsive.height * 2,
                  ),
                  CustomButton(text: "Submit", onPressed: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
