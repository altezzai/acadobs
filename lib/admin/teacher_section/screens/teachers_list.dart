import 'package:flutter/material.dart';
import 'package:school_app/admin/teacher_section/screens/add_teacher.dart';
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
      'name': 'Ms. Kaiya Mango',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'},
    {
      'name': 'Mr. John Doe',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'},
    {
      'name': 'Mr. John Doe',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'},
    {
      'name': 'Mr. John Doe',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'},
    {
      'name': 'Mr. John Doe',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'},
    {
      'name': 'Mr. John Doe',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'},
    {
      'name': 'Mr. John Doe',
      'subject': 'Mathematics',
    },
    {
      'name': 'Ms. Jane Doe',
      'subject': 'Science',
    },
    {'name': 'Mr. John Doe', 'subject': 'Physics'},
    {'name': 'Mr. Calvin', 'subject': 'Chemistry'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomAppbar(
              title: "Teachers",
              onTap: () {
                Navigator.pop(context);
              },
            ),
            CustomTextfield(
              hintText: "Search",
              iconData: const Icon(Icons.search),
            ),
            SizedBox(
              height: Responsive.height * 3,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: teachers.length, (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Responsive.height * 1),
                        child: ProfileTile(
                            name: teachers[index]['name'] ?? "",
                            description: teachers[index]['subject'] ?? "",
                            icon: Icons.class_),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.height * 3,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomButton(
                      text: "Add Teacher",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const AddTeacher(),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Responsive.height * 5,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
