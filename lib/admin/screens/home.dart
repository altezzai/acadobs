import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/admin/screens/duties.dart';
import 'package:school_app/admin/screens/notice.dart';
import 'package:school_app/admin/screens/payment.dart';
import 'package:school_app/admin/screens/reports.dart';
import 'package:school_app/admin/widgets/button_navigation.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0; // Track the selected index
  final PageController _pageController =
      PageController(); // PageController for PageView

  // List of pages corresponding to the bottom navigation items
  final List<Widget> _pages = [
    HomeContentPage(), // Home content
    DutiesPage(), // Duties page
    ReportPage(), // Reports page
    NoticeEventPage(), // Notice page
    PaymentsPage(), // Payment Page
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      // Only update if the index changes
      setState(() {
        _selectedIndex = index; // Update the selected index
        _pageController.jumpToPage(index); // Jump to the selected page
      });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index when the page changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
        physics: const NeverScrollableScrollPhysics(), // Disable manual swiping
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: Text(
          _getAppBarTitle(_selectedIndex),
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
}

// Home content page
class HomeContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.01),
          _buildGreeting(screenWidth),
          SizedBox(height: screenHeight * 0.05),
          _buildActionButtons(screenWidth, screenHeight, context),
        ],
      ),
    );
  }

  Widget _buildGreeting(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi,',
          style: TextStyle(
            fontSize: screenWidth * 0.10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          'Vincent',
          style: TextStyle(
            fontSize: screenWidth * 0.10,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
      double screenWidth, double screenHeight, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildOutlinedButton(
          context,
          'Student',
          AppRouteConst.AdminstudentRouteName,
          screenWidth,
          screenHeight,
        ),
        SizedBox(width: screenWidth * 0.02),
        _buildOutlinedButton(
          context,
          'Teacher',
          AppRouteConst.AdminteacherRouteName,
          screenWidth,
          screenHeight,
        ),
      ],
    );
  }

  Widget _buildOutlinedButton(BuildContext context, String label,
      String routeName, double screenWidth, double screenHeight) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          context.pushReplacementNamed(routeName);
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
