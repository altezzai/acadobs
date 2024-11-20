import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_name_container.dart';

class TeacherScreen extends StatelessWidget {
  TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Responsive.height * 7,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi ,',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 48),
                      ),
                      Text(
                        'Vincent',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: const Color(0xff555555)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(AppRouteConst.logoutRouteName,
                          extra: UserType.teacher);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Image.asset('assets/admin.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * 20,
              ),
              _customContainer(
                color: Colors.green,
                text: 'Homework',
                icon: Icons.note_alt,
                ontap: () {
                  context.pushNamed(AppRouteConst.homeworkRouteName);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              _customContainer(
                  color: Colors.red,
                  text: 'Leave Request',
                  icon: Icons.assignment_add,
                  ontap: () {
                    context.pushNamed(
                        AppRouteConst.AddTeacherLeaveRequestRouteName);
                  }),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomNameContainer(
                    horizontalWidth: 14.2,
                    text: "Students",
                    onPressed: () {
                      context.pushNamed(AppRouteConst.studentRouteName);
                    },
                  ),
                  CustomNameContainer(
                    horizontalWidth: 14.2,
                    text: "Parents",
                    onPressed: () {
                      context.pushNamed(AppRouteConst.parentRouteName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customContainer({
    required Color color,
    required String text,
    IconData icon = Icons.dashboard_customize_outlined,
    required VoidCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Responsive.height * 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
