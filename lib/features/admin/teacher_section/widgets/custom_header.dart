import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class TeacherHeader extends StatelessWidget {
  final String image;
  final String name;
  final String studentClass;

  const TeacherHeader({
    required this.image,
    required this.name,
    required this.studentClass,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.15,
          backgroundImage: AssetImage('assets/$image'),
        ),
        SizedBox(height: Responsive.height * 2),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05),
        ),
        Text(
          'Class: $studentClass',
          style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
        ),
      ],
    );
  }
}
