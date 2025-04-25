import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/route_constants.dart';
import 'package:school_app/features/admin/subjects/screens/add_subject.dart';
import 'package:school_app/features/admin/subjects/screens/edit_subject.dart';
import 'package:school_app/features/superadmin/bottom_nav/bottom_nav_scaffold.dart';
import 'package:school_app/features/superadmin/models/school_subject_model.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      //COMMON ROUTES - SUPER ADMIN, SCHOOL ADMIN
      GoRoute(
        name: RouteConstants.addSubject,
        path: '/addSubject',
        pageBuilder: (context, state) {
          bool fromSchoolAdmin = state.extra as bool;
          return MaterialPage(
              child: AddSubject(
            fromSchoolAdmin: fromSchoolAdmin,
          ));
        },
      ),
      GoRoute(
          name: RouteConstants.editSubject,
          path: '/editsubjectpage',
          pageBuilder: (context, state) {
            final SchoolSubject subjects = state.extra as SchoolSubject;
            return MaterialPage(child: EditSubjectPage(subjects: subjects));
          }),
      // SUPER ADMIN ROUTES
      GoRoute(
        name: RouteConstants.superAdminNavbar,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: BottomNavScaffold());
        },
      ),

      // SCHOOL ADMIN ROUTES

      // TEACHER ROUTES

      // PARENT ROUTES
    ],
  );
}
