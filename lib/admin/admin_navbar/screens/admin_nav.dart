import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/admin_navbar/controller/admin_nav_provider.dart';
import 'package:school_app/admin/screens/duties.dart';
import 'package:school_app/admin/screens/home.dart';
import 'package:school_app/admin/screens/notice.dart';
import 'package:school_app/admin/screens/payment.dart';
import 'package:school_app/admin/screens/reports.dart';
import 'package:school_app/utils/responsive.dart';

class AdminNav extends StatelessWidget {
  AdminNav({super.key});

  final List<Widget> _pages = [
    HomeContentPage(), // Home content
    DutiesPage(), // Duties page
    ReportPage(), // Reports page
    NoticeEventPage(), // Notice page
    PaymentsPage(), // Payment Page
  ];

  AppBar _buildAppBar(int index) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: Text(
          _getAppBarTitle(index),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 20.0,
            backgroundImage: AssetImage('assets/admin.png'),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  String _getAppBarTitle(int index) {
    const titles = [
      'Home',
      'Duties',
      'Reports',
      'Notice / Events',
      'Payments',
    ];
    return titles[index];
  }

  @override
  Widget build(BuildContext context) {
    final adminNavProvider = Provider.of<AdminNavProvider>(context);
    final int currentIndex = adminNavProvider.currentIndex;

    return Scaffold(
      appBar: _buildAppBar(currentIndex), // Add the app bar here
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
            icon: Icon(Icons.home),
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
