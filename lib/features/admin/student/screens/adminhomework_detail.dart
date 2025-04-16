import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/student/model/student_homework.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class AdminhomeworkDetail extends StatefulWidget {
  final HomeworkDetail homework;
  AdminhomeworkDetail({required this.homework});

  @override
  State<AdminhomeworkDetail> createState() => _AdminhomeworkDetailState();
}

class _AdminhomeworkDetailState extends State<AdminhomeworkDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(
              title: widget.homework.assignmentTitle ?? "",
              isProfileIcon: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ViewContainer(
              bcolor: Colors.green.withValues(alpha: 51),
              icolor: Colors.green,
              icon: Icons.military_tech,
            ),
            SizedBox(
              height: Responsive.height * 3,
            ),
            Text(
              widget.homework.assignmentTitle ?? "",
              style: textThemeData.headlineLarge!.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            Text(
              widget.homework.description ?? "",
              style: textThemeData.bodySmall!.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: Responsive.height * 3,
            )
          ],
        ),
      ),
    );
  }
}
