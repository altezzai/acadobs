import 'package:flutter/material.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/teacher_section/duties/duty_detail.dart';
import 'package:school_app/teacher_section/homework/widgets/work_container.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/responsive.dart';

class DutiesScreen extends StatelessWidget {
  const DutiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(
            title: "Duties",
            isBackButton: false,
          ),
          // SizedBox(height: Responsive.height * 2),
          Text(
            'Today',
            style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
          ),
          SizedBox(
            height: Responsive.height * 2,
          ),
          WorkContainer(
            bcolor: const Color(0xffCEFFD3),
            icolor: const Color(0xff5DD168),
            icon: Icons.class_,
            work: '12th Class',
            sub: 'Maths',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const DutyDetailScreen(),
                ),
              );
            },
          ),
          SizedBox(height: Responsive.height * 2),
          Text(
            'Ongoing',
            style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
          ),
          SizedBox(
            height: Responsive.height * 2,
          ),
          const WorkContainer(
            bcolor: Color(0xffCEFFD3),
            icolor: Color(0xff5DD168),
            icon: Icons.class_,
            work: '12th Class',
            sub: 'Maths',
            prefixText: "Ongoing",
            prefixColor: Color(0xFFD68400),
          ),
          SizedBox(height: Responsive.height * 2),
          Text(
            'Yesterday',
            style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
          ),
          SizedBox(
            height: Responsive.height * 2,
          ),
          const WorkContainer(
            bcolor: Color(0xffCEFFD3),
            icolor: whiteColor,
            icon: Icons.done,
            work: '11th Class',
            sub: 'Maths',
            prefixText: "Completed",
            prefixColor: Colors.red,
          ),
          SizedBox(
            height: Responsive.height * 1,
          ),
          const WorkContainer(
            bcolor: Color(0xffFF7E7E),
            icolor: Colors.red,
            icon: Icons.stop_screen_share,
            work: 'Homework',
            sub: 'Maths',
            prefixText: "Not Attended",
            prefixColor: Colors.red,
          ),
        ],
      ),
    ));
  }
}
