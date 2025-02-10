import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/urls.dart';
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
              imagePath:
                  "${baseUrl}${Urls.teacherPhotos}${teacher.profilePhoto}",
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
}
