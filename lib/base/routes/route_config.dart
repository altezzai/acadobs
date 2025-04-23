import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/route_constants.dart';
import 'package:school_app/core/authentication/screens/splashscreen.dart';
import 'package:school_app/features/superadmin/bottom_nav/bottom_nav_scaffold.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
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
