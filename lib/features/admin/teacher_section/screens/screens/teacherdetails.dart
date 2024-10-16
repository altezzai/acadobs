import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/features/admin/teacher_section/widgets/custom_header.dart';
import 'package:school_app/features/admin/teacher_section/widgets/tab_section.dart';

class TeacherDetailsPage extends StatelessWidget {
  final String name;
  final String studentClass;
  final String image;

  TeacherDetailsPage({
    required this.name,
    required this.studentClass,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _buildAppBar(context, screenWidth),
      body: Column(
        children: [
          TeacherHeader(image: image, name: name, studentClass: studentClass),
          Expanded(
            child: TabSection(),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, double screenWidth) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.06,
              color: Colors.black)),
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context
              .pushReplacementNamed(AppRouteConst.AdminteacherRouteName)),
    );
  }
}
