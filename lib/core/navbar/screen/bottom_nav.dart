import 'package:flutter/material.dart';
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
        NoticePage(
          // forNavbar: true,
        ),
        PaymentSelection(),
        // ParentChatPage()
        Center(
          child: Text("Chats Available Soon"),
        )
      ];
    } else {
      return [];
    }
  }

  // Define BottomNavigationBarItems for each user type
  List<BottomNavigationBarItem> _getBottomNavItems(UserType userType) {
    if (userType == UserType.admin) {
      return [
        _bottomNavItem(
          iconPath: 'assets/icons/home.png',
          activeIconPath: 'assets/icons/home_active.png',
          label: 'Home',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/duties.png',
          activeIconPath: 'assets/icons/duties_active.png',
          label: 'Duties',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/reports.png',
          activeIconPath: 'assets/icons/reports_active.png',
          label: 'Reports',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/notice_nav.png',
          activeIconPath: 'assets/icons/notice_nav_active.png',
          label: 'Notice',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/payment_nav.png',
          activeIconPath: 'assets/icons/payments_active.png',
          label: 'Payments',
        ),
      ];
    } else if (userType == UserType.teacher) {
      return [
        _bottomNavItem(
          iconPath: 'assets/icons/home.png',
          activeIconPath: 'assets/icons/home_active.png',
          label: 'Home',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/attendance.png',
          activeIconPath: 'assets/icons/attendance_active.png',
          label: 'Attendance',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/mark.png',
          activeIconPath: 'assets/icons/mark_active.png',
          label: 'Marks',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/duties.png',
          activeIconPath: 'assets/icons/duties_active.png',
          label: 'Duties',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/payment_nav.png',
          activeIconPath: 'assets/icons/payments_active.png',
          label: 'Payments',
        ),
      ];
    } else if (userType == UserType.parent) {
      return [
        _bottomNavItem(
          iconPath: 'assets/icons/home.png',
          activeIconPath: 'assets/icons/home_active.png',
          label: 'Home',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/event_parent_nav.png',
          activeIconPath: 'assets/icons/event_parent_active.png',
          label: 'Events',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/notice_nav.png',
          activeIconPath: 'assets/icons/notice_nav_active.png',
          label: 'Notice',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/payment_nav.png',
          activeIconPath: 'assets/icons/payments_active.png',
          label: 'Payment',
        ),
        _bottomNavItem(
          iconPath: 'assets/icons/reports.png',
          activeIconPath: 'assets/icons/reports_active.png',
          label: 'Chat',
        ),
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
          // Fluttertoast.showToast(
          //   msg: "Press back again to exit",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.black54,
          //   textColor: Colors.white,
          // );

          return false; // Prevent exiting
        }

        return true; // Exit the app
      },
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: Container(
          height: Responsive.height * 8,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor: Colors.black,
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
    required String iconPath,
    required String activeIconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Image.asset(
            iconPath,
            width: 22,
            height: 22,
          ),
          SizedBox(height: 6),
        ],
      ),
      activeIcon: Column(
        children: [
          Image.asset(
            activeIconPath,
            width: 23,
            height: 23,
          ),
          SizedBox(height: 6),
        ],
      ),
      label: label,
    );
  }
}

enum UserType { admin, teacher, parent }
