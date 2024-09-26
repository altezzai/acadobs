import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/teacher/homework/screens/work.dart';
import 'package:school_app/teacher/homework/screens/work_screen.dart';
import 'package:school_app/teacher/homework/screens/work_view.dart';
import 'package:school_app/teacher/mark_work/screens/mark_star.dart';
import 'package:school_app/teacher/navbar/screens/bottom_navbar.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';

class Approuter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteConst.homeRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: BottomNavbar());
        },
      ),
      GoRoute(
        name: AppRouteConst.homeworkRouteName,
        path: '/homework',
        pageBuilder: (context, state) {
          return MaterialPage(child: WorkScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.workviewRouteName,
        path: '/workview',
        pageBuilder: (context, state) {
          return MaterialPage(child: WorkView());
        },
      ),
      GoRoute(
        name: AppRouteConst.addworkRouteName,
        path: '/addwork',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeWork());
        },
      ),
      GoRoute(
        name: AppRouteConst.markstarRouteName,
        path: '/markstar',
        pageBuilder: (context, state) {
          return MaterialPage(child: MarkStar());
        },
      ),
    ],
    // errorPageBuilder: (context, state) {
    //   return MaterialPage(child: child)
    // },
  );
}
