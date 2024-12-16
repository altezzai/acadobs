import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';

class DutyCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final void Function() onTap;

  const DutyCard({
    required this.title,
    required this.date,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Image.asset(
                    'assets/icons/Vector.png',
                    height: 20,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: textThemeData.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        )
                        // TextStyle(
                        //   fontWeight: FontWeight.normal,
                        //   fontSize: screenWidth * 0.04,
                        // ),
                        ),
                    // SizedBox(height: 2),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
