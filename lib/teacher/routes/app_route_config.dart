import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/admin/screens/addAchivement.dart';
import 'package:school_app/admin/screens/home.dart';
import 'package:school_app/admin/screens/login.dart';
import 'package:school_app/admin/screens/newstudent.dart';
import 'package:school_app/admin/screens/payment.dart';
import 'package:school_app/admin/screens/splashscreen.dart';
import 'package:school_app/admin/screens/studentdetails.dart';
import 'package:school_app/admin/screens/studentpage.dart';
import 'package:school_app/admin/screens/teacherdetails.dart';
import 'package:school_app/admin/screens/teachers_page.dart';
import 'package:school_app/sample/screens/studentsample.dart';
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
          return MaterialPage(child: Studentsample());
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
      GoRoute(
        name: AppRouteConst.AdminHomeRouteName,
        path: '/adminhome',
        pageBuilder: (context, state) {
          return MaterialPage(child: AdminHomePage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminstudentRouteName,
        path: '/adminstudent',
        pageBuilder: (context, state) {
          return MaterialPage(child: StudentsPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminteacherRouteName,
        path: '/adminteacher',
        pageBuilder: (context, state) {
          return MaterialPage(child: TeachersPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminstudentdetailsRouteName,
        path: '/adminstudentdetails',
        pageBuilder: (context, state) {
          final studentData = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: StudentDetailPage(
              name: studentData['name'],
              studentClass: studentData['class'],
              image: studentData['image'],
            ),
          );
        },
      ),
      GoRoute(
        name: AppRouteConst.AddAchivementsRouteName,
        path: '/addachivement',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddAchievementPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddStudentRouteName,
        path: '/addstudent',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddStudentPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AdminteacherdetailsRouteName,
        path: '/adminteacherdetails',
        pageBuilder: (context, state) {
          final teacher = state.extra as Map<String, dynamic>;
          return MaterialPage(
            child: TeacherDetailsPage(
              name: teacher['name'],
              studentClass: teacher['class'],
              image: teacher['image'],
            ),
          );
        },
      ),
    ],
  );
}
