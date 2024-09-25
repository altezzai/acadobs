import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/global%20widgets/profile_tile.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class TeachersListScreen extends StatelessWidget {
  TeachersListScreen({super.key});

  List<Map<String, String>> teachers = [
    {
      'name': 'Mr. John Doe',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const CustomAppbar(title: "Teachers"),
              CustomTextfield(
                hintText: "Search",
                iconData: const Icon(Icons.search),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Responsive.height * 1),
                    child: ProfileTile(
                        name: teachers[index]['name'] ?? "",
                        description: teachers[index]['subject'] ?? "",
                        icon: Icons.class_),
                  );
                },
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              CustomButton(text: "Add Teacher", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
