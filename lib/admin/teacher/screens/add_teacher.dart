import 'package:flutter/material.dart';
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
            CustomAppbar(title: "Add Teacher"),
            CustomTextfield(
              hintText: "Teacher Name",
              iconData: const Icon(Icons.person_2_outlined),
            ),
            SizedBox(
              height: Responsive.height * 2,
            )
          ],
        ),
      ),
    );
  }
}
