import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/admin/duties/screens/duties_home.dart';
import 'package:school_app/features/admin/home/admin_home.dart';
import 'package:school_app/features/admin/notices/screens/notice_home.dart';
import 'package:school_app/features/admin/payments/screens/payments_home.dart';
import 'package:school_app/features/admin/reports/screens/reports_home.dart';
import 'package:school_app/core/navbar/controller/bottom_nav_controller.dart';
import 'package:school_app/features/teacher/attendance/screens/attendance.dart';
import 'package:school_app/features/teacher/duties/duties.dart';
import 'package:school_app/features/teacher/home/homescreen.dart';
import 'package:school_app/features/teacher/marks/screens/marks.dart';
import 'package:school_app/base/utils/responsive.dart';

class BottomNavScreen extends StatelessWidget {
  final UserType userType;
  BottomNavScreen({super.key, required this.userType});

  // Define pages for each user type
  List<Widget> _getPages(UserType userType) {
    if (userType == UserType.admin) {
      return [
        AdminHomeScreen(),
        DutiesHomeScreen(),
        ReportsHomeScreen(),
        NoticeHomeScreen(),
        PaymentsHomeScreen(),
      ];
    } else if (userType == UserType.teacher) {
      return [
        const TeacherScreen(),
        Attendance(),
        ProgressReport(),
        const DutiesScreen(),
        PaymentsHomeScreen(),
      ];
    } else {
      return [];
    }
  }

  // Define BottomNavigationBarItems for each user type
  List<BottomNavigationBarItem> _getBottomNavItems(UserType userType) {
    if (userType == UserType.admin) {
      return [
        _bottomNavItem(icon: Icons.home_outlined, label: 'Home'),
        _bottomNavItem(icon: Icons.work_outline, label: 'Duties'),
        _bottomNavItem(icon: Icons.article_outlined, label: 'Reports'),
        _bottomNavItem(icon: Icons.notifications_outlined, label: 'Notice'),
        _bottomNavItem(icon: Icons.payment_outlined, label: 'Payments'),
      ];
    } else if (userType == UserType.teacher) {
      return [
        _bottomNavItem(icon: Icons.home_outlined, label: 'Home'),
        _bottomNavItem(icon: Icons.check_circle_outline, label: 'Attendance'),
        _bottomNavItem(icon: Icons.report_outlined, label: 'Marks'),
        _bottomNavItem(icon: Icons.work_outline, label: 'Duties'),
        _bottomNavItem(icon: Icons.payment_outlined, label: 'Payments'),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavController>(context);
    final int currentIndex = bottomNavProvider.currentIndex;
    final _pages = _getPages(userType);
    final _navItems =
        _getBottomNavItems(userType); // Get navigation items based on user type

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: Responsive.radius * 7,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        onTap: (index) {
          bottomNavProvider.setIndex(index);
        },
        items: _navItems, // Use dynamic items based on userType
      ),
    );
  }

  // Function to return a BottomNavigationBarItem
  BottomNavigationBarItem _bottomNavItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

enum UserType {
  admin,
  teacher,
  parent,
}
