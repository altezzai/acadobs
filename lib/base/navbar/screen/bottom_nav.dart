import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/admin_navbar/controller/admin_nav_provider.dart';
import 'package:school_app/admin/screens/duties.dart';
import 'package:school_app/admin/screens/home.dart';
import 'package:school_app/admin/screens/notice.dart';
import 'package:school_app/admin/screens/payment.dart';
import 'package:school_app/admin/screens/reports.dart';
import 'package:school_app/teacher/attendance/screens/attendance.dart';
import 'package:school_app/teacher/duties/duties.dart';
import 'package:school_app/teacher/home/homescreen.dart';
import 'package:school_app/teacher/marks/screens/marks.dart';
import 'package:school_app/utils/responsive.dart';

class BottomNavScreen extends StatelessWidget {
  final UserType userType;
  BottomNavScreen({super.key, required this.userType});

   List<Widget> _getPages(UserType userType){

       if(userType == UserType.admin){
        return [ HomeContentPage(), // Home content
    DutiesPage(), // Duties page
    ReportPage(), // Reports page
    NoticeEventPage(), // Notice page
    PaymentsPage(), // Payment Page
        ];
   }
else if(userType == UserType.teacher){
        return [  const TeacherScreen(),
    Attendance(),
    ProgressReport(),
    const DutiesScreen(),
    PaymentsPage(), // Payment Page
        ];
   }
 else{
  return [ HomeContentPage(), // Home content
    DutiesPage(), // Duties page
    ReportPage(), // Reports page
    NoticeEventPage(), // Notice page
    PaymentsPage(), // Payment Page
        ];
 }

    }

  @override
  Widget build(BuildContext context) {
    final adminNavProvider = Provider.of<AdminNavProvider>(context);
    final int currentIndex = adminNavProvider.currentIndex;
    final _pages = _getPages(userType);

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
          adminNavProvider.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'Duties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notice',
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
enum UserType {
  admin,
  teacher,
  parent,
}

