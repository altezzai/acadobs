import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/controller/bottom_nav_controller.dart';
import 'package:school_app/features/admin/duties/screens/duties_home.dart';
import 'package:school_app/features/admin/home/admin_home.dart';
import 'package:school_app/features/admin/notices/screens/notice_home.dart';
import 'package:school_app/features/admin/payments/screens/payments_home.dart';
import 'package:school_app/features/admin/reports/screens/reports_home.dart';
import 'package:school_app/features/parent/events/screen/eventscreen.dart';
import 'package:school_app/features/parent/home/screen/homescreen.dart';
import 'package:school_app/features/parent/notices/screen/noticescreen.dart';
import 'package:school_app/features/parent/payment/screen/payment_selection.dart';
import 'package:school_app/features/teacher/attendance/screens/attendance.dart';
import 'package:school_app/features/teacher/duties/duties.dart';
import 'package:school_app/features/teacher/home/homescreen.dart';
import 'package:school_app/features/teacher/marks/screens/teacher_marks_list.dart';
import 'package:school_app/features/teacher/payment/teacher_payment.dart';

class BottomNavScreen extends StatefulWidget {
  final UserType userType;
  const BottomNavScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  DateTime? lastPressed;

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
        TeacherScreen(),
        AttendanceScreen(),
        TeacherMarksList(),
        const DutiesScreen(),
        TeacherPaymentScreen(),
      ];
    } else if (userType == UserType.parent) {
      return [
        HomePage(),
        EventsPage(),
        NoticePage(),
        PaymentSelection(),
        Center(child: Text("Chats Available Soon")),
      ];
    } else {
      return [];
    }
  }

  // Define BottomNavigationBarItems for each user type
  List<BottomNavigationBarItem> _getBottomNavItems(UserType userType) {
    if (userType == UserType.admin) {
      return [
        _bottomNavItem(icon: LucideIcons.home, label: 'Home'),
        _bottomNavItem(icon: LucideIcons.listTodo, label: 'Duties'),
        _bottomNavItem(icon: LucideIcons.fileBarChart2, label: 'Reports'),
        _bottomNavItem(icon: LucideIcons.bell, label: 'Notice'),
        _bottomNavItem(icon: LucideIcons.creditCard, label: 'Payments'),
      ];
    } else if (userType == UserType.teacher) {
      return [
        _bottomNavItem(icon: LucideIcons.home, label: 'Home'),
        _bottomNavItem(icon: LucideIcons.calendarCheck, label: 'Attendance'),
        _bottomNavItem(icon: LucideIcons.fileText, label: 'Marks'),
        _bottomNavItem(icon: LucideIcons.listTodo, label: 'Duties'),
        _bottomNavItem(icon: LucideIcons.creditCard, label: 'Payments'),
      ];
    } else if (userType == UserType.parent) {
      return [
        _bottomNavItem(icon: LucideIcons.home, label: 'Home'),
        _bottomNavItem(icon: LucideIcons.calendarDays, label: 'Events'),
        _bottomNavItem(icon: LucideIcons.bell, label: 'Notice'),
        _bottomNavItem(icon: LucideIcons.creditCard, label: 'Payment'),
        _bottomNavItem(icon: LucideIcons.messageSquare, label: 'Chat'),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavController>(context);
    final int currentIndex = bottomNavProvider.currentIndex;
    final _pages = _getPages(widget.userType);
    final _navItems = _getBottomNavItems(widget.userType);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (lastPressed == null ||
            now.difference(lastPressed!) > const Duration(seconds: 2)) {
          lastPressed = now;
          CustomSnackbar.show(context,
              message: "Press back again to exit", type: SnackbarType.warning);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: Container(
          height: Responsive.height * 8,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor:
                Colors.black, // handled by BottomNavigationBar itself
            unselectedItemColor: Color(0xFF848484),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            onTap: (index) {
              bottomNavProvider.setIndex(index);
            },
            items: _navItems,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 24),
      activeIcon: Icon(icon, size: 26),
      label: label,
    );
  }
}

enum UserType { admin, teacher, parent }
