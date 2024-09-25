import 'package:flutter/material.dart';
import 'package:school_app/teacher/homework/screens/work_view.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/responsive.dart';

class WorkContainer extends StatelessWidget {
  final Color bcolor;
  final Color icolor;
  final IconData icon;
  final String work;
  final String sub;
  final double brad;
  final String prefixText;
  final Color prefixColor;
  final VoidCallback? onTap;

  const WorkContainer({
    super.key,
    required this.bcolor,
    required this.icolor,
    required this.icon,
    required this.sub,
    required this.work,
    this.brad = 0,
    this.prefixText = "View",
    this.prefixColor = blackColor,
    this.onTap

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.height * 1.3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(brad),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            // spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.radius * 6,
            backgroundColor: bcolor,
            child: Icon(
              icon,
              color: icolor,
              size: 25,
            ),
          ),
          SizedBox(
            width: Responsive.width * 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                work,
                style: textThemeData.headlineMedium!.copyWith(fontSize: 16),
              ),
              Text(
                sub,
                style: textThemeData.labelSmall!.copyWith(fontSize: 12),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkView(),
                ),
              );
            },
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                prefixText,
                style: textThemeData.headlineMedium!.copyWith(fontSize: 16,color: prefixColor),
              ),
            ),
          ),
          SizedBox(
            width: Responsive.width * 4,
          ),
        ],
      ),
    );
  }
}
