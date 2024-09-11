import 'package:flutter/material.dart';
import 'package:school_app/screens/duties.dart'; // Import DutiesPage class
import 'package:school_app/screens/notice.dart'; // Import NoticePage class
import 'package:school_app/screens/payment.dart'; // Import PaymentsPage class
import 'package:school_app/screens/reports.dart'; // Import ReportsPage class
import 'package:school_app/widgets/button_navigation.dart'; // Import CustomBottomNavigationBar widget

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index
  final PageController _pageController =
      PageController(); // PageController for PageView

  // List of pages corresponding to the bottom navigation items
  final List<Widget> _pages = [
    HomeContentPage(), // Home content
    DutiesPage(), // Duties page
    ReportPage(), // Reports page
    NoticeEventPage(), // Notice page
    PaymentsPage(), // Payments page
  ];

  // This method is called when a navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index to switch pages
      _pageController.jumpToPage(index); // Navigate to the selected page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            _getAppBarTitle(
                _selectedIndex), // Update title based on selected page
            style: TextStyle(
              fontSize: 24.0, // Increase font size here
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(16.0), // Static padding
            child: CircleAvatar(
              radius: 20.0, // Static radius for avatar
              backgroundImage: AssetImage('assets/admin.png'),
            ),
          ),
        ],
        automaticallyImplyLeading: false, // Disable back arrow
      ),
      // PageView to switch between pages
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index on page change
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex, // Pass selected index
        onItemTapped: _onItemTapped, // Pass function to handle taps
      ),
    );
  }

  // Method to get the AppBar title based on the selected index
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
      default:
        return 'Home';
    }
  }
}

// Home content placeholder
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
              fontSize: screenWidth * 0.09, // Scaled text size
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Vincent',
            style: TextStyle(
              fontSize: screenWidth * 0.09, // Scaled text size
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
                    // Handle student button click
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.03), // Responsive padding
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Student',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05, // Scaled button text size
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle teacher button click
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.03), // Responsive padding
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Teacher',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05, // Scaled button text size
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
