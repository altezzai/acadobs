import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/responsive.dart';
import 'package:school_app/teacher/homework/widgets/view_container.dart';

class WorkView extends StatelessWidget {
  const WorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pushReplacementNamed(AppRouteConst.homeworkRouteName);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ViewContainer(
              bcolor: Color(0xffFFCEDE),
              icolor: Color(0xffB14F6F),
              icon: Icons.text_snippet_outlined,
            ),
            SizedBox(
              height: Responsive.height * 3,
            ),
            Text(
              'Hindi Imposition',
              style: textThemeData.headlineLarge!.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            Text(
              'You have to complete the registration of 12th class \nstudents before 2025',
              style: textThemeData.bodySmall!.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: Responsive.height * 3,
            ),
            Container(
              padding: EdgeInsets.all(Responsive.width * 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: Responsive.radius * 6,
                    backgroundColor: const Color(0xffF4F4F4),
                    child: const Icon(
                      Icons.fact_check_outlined,
                      size: 25,
                    ),
                  ),
                  SizedBox(
                    width: Responsive.width * 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushReplacementNamed(
                          AppRouteConst.markstarRouteName);
                    },
                    child: Text(
                      'Mark Homework',
                      style: textThemeData.bodyMedium!.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
