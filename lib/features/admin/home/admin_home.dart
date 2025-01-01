import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_name_container.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                    context.pushNamed(AppRouteConst.logoutRouteName,
                        extra: UserType.admin);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Image.asset('assets/admin.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height * 4,
            ),
            _customContainer(
                color: Colors.red,
                text: 'Leave Requests',
                icon: Icons.assignment_add,
                ontap: () {
                  context.pushNamed(AppRouteConst.LeaveRequestScreenRouteName);
                }),
            SizedBox(
              height: Responsive.height * 1,
            ),

            _customContainer(
                color: Colors.black,
                text: 'Subjects',
                icon: Icons.assignment_add,
                ontap: () {
                  context.pushNamed(AppRouteConst.SubjectsPageRouteName);
                }),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomNameContainer(
                  text: "Students",
                  onPressed: () {
                    context.pushNamed(AppRouteConst.studentRouteName,
                        extra: UserType.admin);
                  },
                ),
                CustomNameContainer(
                  text: "Teachers",
                  onPressed: () {
                    context.pushNamed(AppRouteConst.AdminteacherRouteName);
                  },
                ),
              ],
            ),
            // ProfileTile(name: name, description: description, icon: icon)
          ],
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
