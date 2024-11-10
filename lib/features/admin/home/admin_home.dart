import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
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
                    context.goNamed(AppRouteConst.loginRouteName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Image.asset('assets/admin.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomNameContainer(
                  text: "Students",
                  onPressed: () {
                    context.pushNamed(AppRouteConst.studentRouteName);
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
}
