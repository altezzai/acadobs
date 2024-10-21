import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/homework/data/workdata.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';

class WorkScreen extends StatelessWidget {
  WorkScreen({super.key});

  // List<Work> work = workList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: 'Home Works',
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(
                    AppRouteConst.bottomNavRouteName,
                    extra: UserType.teacher,
                  );
                },
              ),
              Text(
                'Today',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              WorkContainer(
                bcolor: Color(0xffFFFCCE),
                icolor: Color(0xffBCB54F),
                icon: Icons.business_center_outlined,
                work: 'Homework',
                sub: 'Maths',
                onTap: () {
                  context.pushReplacementNamed(AppRouteConst.workviewRouteName);
                },
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                'Yesterday',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: workList.length,
                itemBuilder: (context, index) {
                  final workItem = workList[index];
                  return WorkContainer(
                    bcolor: workItem.backgroundColor,
                    icolor: workItem.iconColor,
                    icon: workItem.icon,
                    work: workItem.workType,
                    sub: workItem.subject,
                    onTap: () => workItem.onTap(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushReplacementNamed(AppRouteConst.addworkRouteName);
        },
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            '+',
            style: textThemeData.headlineLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
