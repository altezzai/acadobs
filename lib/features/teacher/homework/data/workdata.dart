import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/features/teacher/homework/models/work.dart';
import 'package:school_app/base/routes/app_route_const.dart';

List<Work> workList = [
  Work(
    workType: 'Imposition',
    subject: 'Hindi',
    backgroundColor: const Color(0xffFFCEDE),
    iconColor: const Color(0xffB14F6F),
    icon: Icons.text_snippet_outlined,
    onTap: (BuildContext context) {
      context.pushReplacementNamed(AppRouteConst.workviewRouteName);
    },
  ),
  Work(
    workType: 'Imposition',
    subject: 'Malayalam',
    backgroundColor: const Color(0xffFFCEDE),
    iconColor: const Color(0xffB14F6F),
    icon: Icons.text_snippet_outlined,
    onTap: (BuildContext context) {
      context.pushReplacementNamed(AppRouteConst.workviewRouteName);
    },
  ),
  Work(
    workType: 'Imposition',
    subject: 'Social Science',
    backgroundColor: const Color(0xffFFCEDE),
    iconColor: const Color(0xffB14F6F),
    icon: Icons.text_snippet_outlined,
    onTap: (BuildContext context) {
      context.pushReplacementNamed(AppRouteConst.workviewRouteName);
    },
  ),
  Work(
    workType: 'Homework',
    subject: 'Science',
    backgroundColor: const Color(0xffFFFCCE),
    iconColor: const Color(0xffBCB54F),
    icon: Icons.business_center_outlined,
    onTap: (BuildContext context) {
      context.pushReplacementNamed(AppRouteConst.workviewRouteName);
    },
  ),
];
