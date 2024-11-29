import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/homework/model/homework_model.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class WorkView extends StatefulWidget {
  final Homework work;
  WorkView({required this.work});

  @override
  State<WorkView> createState() => _WorkViewState();
}

class _WorkViewState extends State<WorkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(
              title: '',
              isProfileIcon: false,
              onTap: () {
                context.pushNamed(AppRouteConst.homeworkRouteName);
              },
            ),
            const ViewContainer(
              bcolor: Color(0xffFFFCCE),
              icolor: const Color(0xffBCB54F),
              icon: Icons.home_work_outlined,
            ),
            SizedBox(
              height: Responsive.height * 3,
            ),
            Text(
              widget.work.assignmentTitle ?? "",
              style: textThemeData.headlineLarge!.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            Text(
              widget.work.description ?? "",
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
                      context.pushNamed(AppRouteConst.markstarRouteName);
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
