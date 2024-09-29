import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/responsive.dart';
import 'package:school_app/teacher/homework/data/workdata.dart';
import 'package:school_app/teacher/homework/widgets/work_container.dart';

class WorkScreen extends StatelessWidget {
  WorkScreen({super.key});

  // List<Work> work = workList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Center(
            child: Text(
          'Home Works',
          style: textThemeData.headlineMedium,
        )),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Responsive.height * 3,
            ),
            Text(
              'Today',
              style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            const WorkContainer(
              bcolor: Color(0xffFFFCCE),
              icolor: Color(0xffBCB54F),
              icon: Icons.business_center_outlined,
              work: 'Homework',
              sub: 'Maths',
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
                );
              },
            ),
          ],
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
