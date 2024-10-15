import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/homework/widgets/date_picker.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class DutyDetailScreen extends StatelessWidget {
  const DutyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: '12th  class New student Registration of 2024',
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const ViewContainer(
                bcolor: Color(0xffCEFFD3),
                icolor: Color(0xff5DD168),
                icon: Icons.class_,
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                '12th  class New student Registration of 2024',
                style: textThemeData.headlineLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'You have to complete the registration of 12th class \nstudents before 2025',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: Responsive.height * 3),
              Row(
                children: [
                  const DatePicker(title: "Start Date"),
                  SizedBox(width: Responsive.width * 2),
                  const DatePicker(title: "End Date")
                ],
              ),
              SizedBox(height: Responsive.height * 6),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff14601C),
                ),
                onPressed: () {},
                child: Text(
                  "Mark as Completed",
                  style: textThemeData.bodyMedium!.copyWith(
                    color: whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
