import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/features/admin/student/screens/addAchivement.dart';
import 'package:school_app/features/admin/duties/screens/addDutyPage.dart';
import 'package:school_app/features/admin/payments/screens/add_donation.dart';
import 'package:school_app/features/admin/notices/screens/add_event.dart';
import 'package:school_app/features/admin/notices/screens/add_notice.dart';
import 'package:school_app/features/admin/payments/screens/add_payment.dart';
import 'package:school_app/core/authentication/login.dart';
import 'package:school_app/features/admin/student/screens/newstudent.dart';
import 'package:school_app/core/authentication/splashscreen.dart';
import 'package:school_app/features/admin/student/screens/studentdetails.dart';
import 'package:school_app/features/admin/student/screens/studentpage.dart';
import 'package:school_app/features/admin/teacher_section/screens/screens/teacherdetails.dart';
import 'package:school_app/features/admin/teacher_section/screens/screens/teachers_page.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/teacher/attendance/screens/take_attendance.dart';
import 'package:school_app/features/teacher/duties/duty_detail.dart';
import 'package:school_app/features/teacher/homework/screens/work.dart';
import 'package:school_app/features/teacher/homework/screens/work_screen.dart';
import 'package:school_app/features/teacher/homework/screens/work_view.dart';
import 'package:school_app/features/teacher/leave_request/leave_request.dart';
import 'package:school_app/features/teacher/mark_work/screens/mark_star.dart';
import 'package:school_app/features/teacher/marks/screens/student_marklist.dart';
import 'package:school_app/features/teacher/parent/screens/parents.dart';
import 'package:school_app/base/routes/app_route_const.dart';

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
        name: AppRouteConst.bottomNavRouteName,
        path: '/bottomNav',
        pageBuilder: (context, state) {
          final userType = state.extra as UserType;
          return MaterialPage(
              child: BottomNavScreen(
            userType: userType,
          ));
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
      GoRoute(
        name: AppRouteConst.AdminAddDutyRouteName,
        path: '/adminaddduty',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddDutyPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddNoticeRouteName,
        path: '/addnotice',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddNoticePage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddEventRouteName,
        path: '/addevent',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddEventPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddPaymentRouteName,
        path: '/addpayment',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddPaymentPage());
        },
      ),
      GoRoute(
        name: AppRouteConst.AddDonationRouteName,
        path: '/addDonation',
        pageBuilder: (context, state) {
          return MaterialPage(child: AddDonationPage());
        },
      ),
    ],
  );
}
