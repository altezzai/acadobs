import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/admin/screens/login.dart';
import 'package:school_app/admin/screens/payment.dart';
import 'package:school_app/admin/screens/splashscreen.dart';
import 'package:school_app/admin/screens/studentpage.dart';
import 'package:school_app/teacher/attendance/screens/take_attendance.dart';
import 'package:school_app/teacher/duties/duty_detail.dart';
import 'package:school_app/teacher/homework/screens/work.dart';
import 'package:school_app/teacher/homework/screens/work_screen.dart';
import 'package:school_app/teacher/homework/screens/work_view.dart';
import 'package:school_app/teacher/leave_request/leave_request.dart';
import 'package:school_app/teacher/mark_work/screens/mark_star.dart';
import 'package:school_app/teacher/marks/screens/student_marklist.dart';
import 'package:school_app/teacher/navbar/screens/bottom_navbar.dart';
import 'package:school_app/teacher/parent/screens/parents.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';

class Approuter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteConst.splashRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.loginRouteName,
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.homeRouteName,
        path: '/teacherhome',
        pageBuilder: (context, state) {
          return MaterialPage(child: BottomNavbar());
        },
      ),
      GoRoute(
        name: AppRouteConst.attendanceRouteName,
        path: '/attendance',
        pageBuilder: (context, state) {
          return MaterialPage(child: TakeAttendance());
        },
      ),
      GoRoute(
        name: AppRouteConst.marksRouteName,
        path: '/marks',
        pageBuilder: (context, state) {
          return MaterialPage(child: StudentMarklist());
        },
      ),
      GoRoute(
        name: AppRouteConst.dutiesRouteName,
        path: '/duties',
        pageBuilder: (context, state) {
          return MaterialPage(child: DutyDetailScreen());
        },
      ),
      GoRoute(
        name: AppRouteConst.paymentRouteName,
        path: '/payment',
        pageBuilder: (context, state) {
          return MaterialPage(child: PaymentsPage());
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
      GoRoute(
        name: AppRouteConst.leaveRouteName,
        path: '/leave',
        pageBuilder: (context, state) {
          return MaterialPage(child: LeaveRequest());
        },
      ),
      GoRoute(
        name: AppRouteConst.studentRouteName,
        path: '/student',
        pageBuilder: (context, state) {
          return MaterialPage(child: StudentsPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.parentRouteName,
        path: '/parent',
        pageBuilder: (context, state) {
          return MaterialPage(child: ParentsScreen());
        },
      ),
    ],
  );
}
