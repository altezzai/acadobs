import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      final token = await SecureStorageService.getAccessToken();
      final userType = await SecureStorageService.getUserType();
      if (token == null) {
        // ignore: use_build_context_synchronously
        context.pushReplacementNamed(AppRouteConst.loginRouteName);
      } else {
        if (userType == "student") {
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.parent);
        } else if (userType == "teacher") {
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.teacher);
        } else if (userType == "admin") {
          context.goNamed(AppRouteConst.bottomNavRouteName,
              extra: UserType.admin);
        } else {
          log("Error ===No user type specified");
        }
      }
    });
    // context.pushReplacementNamed(AppRouteConst.loginRouteName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/school_logo.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
