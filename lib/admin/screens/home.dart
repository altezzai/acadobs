import 'package:flutter/material.dart';
import 'package:school_app/admin/screens/duties.dart';
import 'package:school_app/admin/screens/notice.dart';
import 'package:school_app/admin/screens/payment.dart';
import 'package:school_app/admin/screens/reports.dart';
import 'package:school_app/admin/screens/studentpage.dart';
import 'package:school_app/admin/screens/teachers_page.dart';
import 'package:school_app/admin/teacher_section/screens/teachers_list.dart';
import 'package:school_app/admin/widgets/button_navigation.dart';

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
    PaymentsPage(),
    StudentsPage() // Student page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
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
            padding: EdgeInsets.all(10.0), // static padding
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/admin.png'),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      // pageview to switch between pages
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // method to get the AppBar title based on the selected index
  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Duties';
      case 2:
        return 'Reports';
      case 3:
        return 'Notice / Events';
      case 4:
        return 'Payments';
      case 5:
        return 'Students';
      default:
        return 'Home';
    }
  }
}

// home content
class HomeContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.01),
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
          SizedBox(height: screenHeight * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentsPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.03), // responsive padding
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Student',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(

                        builder: (context) => TeachersPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.03), // responsive padding
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Teacher',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
