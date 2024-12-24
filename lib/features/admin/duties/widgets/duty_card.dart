import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';

class DutyCard extends StatelessWidget {
  final String title;
  final String description;
  final String fileUpload;
  final String date;
  final String time;
  final double bottomRadius;
  final double topRadius;
  final void Function() onTap;

  const DutyCard({
    required this.title,
    required this.description,
    required this.fileUpload,
    required this.date,
    required this.time,
    required this.onTap,
    required this.bottomRadius,
    required this.topRadius,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      // onTap: onTap,
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomRadius),
              bottomRight: Radius.circular(bottomRadius),
              topLeft: Radius.circular(topRadius),
              topRight: Radius.circular(topRadius)),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade300,
          //     blurRadius: 4,
          //     spreadRadius: 1,
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFFCEF2FF),
                  child: Image.asset(
                    'assets/icons/Vector.png',
                    height: 18,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(capitalizeEachWord(title),
                        style: textThemeData.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )
                        // TextStyle(
                        //   fontWeight: FontWeight.normal,
                        //   fontSize: screenWidth * 0.04,
                        // ),
                        ),
                    SizedBox(height: 2),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFCEF2FF)),
                      child: Text(
                        date,
                        style: TextStyle(
                          color: Color(0xFF378AA8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Responsive.height * 3),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
