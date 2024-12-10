import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
import 'package:school_app/features/admin/teacher_section/widgets/tab_section.dart';

class TeacherDetailsPage extends StatelessWidget {
  // final String name;
  // final String studentClass;
  // final String image;
  final Teacher teacher;

  TeacherDetailsPage({
    // required this.name,
    // required this.studentClass,
    // required this.image,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomAppbar(
              title: 'Teachers',
              isProfileIcon: false,
              onTap: () {
                context.pushNamed(AppRouteConst.AdminteacherRouteName);
              },
            ),
            ProfileContainer(
              imagePath: "assets/staff3.png",
              name: capitalizeFirstLetter(teacher.fullName ?? ""),
              present: '27',
              absent: '7',
              late: '3',
              description: teacher.classGradeHandling,
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Expanded(
              child: TabSection(
                teacherId: teacher.id ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, double screenWidth) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(teacher.fullName ?? "",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.06,
              color: Colors.black)),
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              context.pushNamed(AppRouteConst.AdminteacherRouteName)),
    );
  }
}
