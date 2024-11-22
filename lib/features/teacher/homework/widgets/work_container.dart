import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';

class WorkContainer extends StatelessWidget {
  final Color bcolor;
  final Color icolor;
  final IconData icon;
  final String work;
  final String sub;
  final String prefixText;
  final Color prefixColor;
  final VoidCallback? onTap;

  const WorkContainer({
    super.key,
    this.bcolor = const Color(0xffFFFCCE),
    this.icolor = const Color(0xffBCB54F),
    this.icon = Icons.business_center_outlined,
    required this.sub,
    required this.work,
    this.prefixText = "View",
    this.prefixColor = blackColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.height * 1.3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
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
              Icons.home_work_outlined,
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
                style: textThemeData.headlineMedium?.copyWith(fontSize: 16) ??
                    const TextStyle(fontSize: 16),
              ),
              Text(
                sub,
                style: textThemeData.labelSmall?.copyWith(fontSize: 12) ??
                    const TextStyle(fontSize: 12), // Null check
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Text(
              prefixText,
              style: textThemeData.headlineMedium
                      ?.copyWith(fontSize: 16, color: prefixColor) ??
                  const TextStyle(fontSize: 16),
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
