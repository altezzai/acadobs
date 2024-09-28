import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/screens/payment.dart';
import 'package:school_app/teacher/attendance/screens/attendance.dart';
import 'package:school_app/teacher/home/homescreen.dart';
import 'package:school_app/teacher/marks/screens/marks.dart';
import 'package:school_app/teacher/navbar/controller/navbar_provider.dart';
import 'package:school_app/teacher/duties/duties.dart';
import 'package:school_app/utils/responsive.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    return Scaffold(
      body: IndexedStack(
        index: bottomNavProvider.currentIndex,
        children: [
          const TeacherScreen(),
          Attendance(),
          ProgressReport(),
          const DutiesScreen(),
          PaymentsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavProvider.currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: Responsive.radius * 7,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        onTap: (index) {
          bottomNavProvider.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Mark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'Duties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_outlined),
            label: 'Payments',
          ),
        ],
      ),
    );
  }
}
