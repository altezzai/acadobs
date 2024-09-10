import 'package:flutter/material.dart';
import 'package:school_app/screens/addDutyPage.dart';
import 'package:school_app/screens/home.dart'; // Import the HomePage class

class DutiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Duties',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06, // Responsive font size
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
            child: CircleAvatar(
              radius: screenWidth * 0.07, // Responsive radius
              backgroundImage: AssetImage('assets/admin.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Wrap the body in a SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              // Add Duty Button
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // background color
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.03,
                        horizontal: screenWidth * 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddDutyPage()),
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Add Duty',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.05),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Today Section
              Text(
                'Today',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Duty Card (Today)
              _buildDutyCard(
                  context, "PTA meeting class XII", "15-06-24", "09:00 am"),
              SizedBox(height: screenHeight * 0.03),
              // Yesterday Section
              Text(
                'Yesterday',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Duty Cards (Yesterday)
              _buildDutyCard(
                  context, "PTA meeting class 09", "15-06-24", "09:00 am"),
              _buildDutyCard(
                  context, "PTA meeting class 02", "15-06-24", "09:00 am"),
              _buildDutyCard(
                  context, "PTA meeting class VII", "15-06-24", "09:00 am"),
              _buildDutyCard(
                  context, "PTA meeting class XII", "15-06-24", "09:00 am"),
              _buildDutyCard(
                  context, "PTA meeting class XII", "15-06-24", "09:00 am"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1, // Set the currently selected index
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: screenWidth * 0.07, // Responsive icon size
        selectedFontSize: screenWidth * 0.04, // Responsive selected font size
        unselectedFontSize:
            screenWidth * 0.035, // Responsive unselected font size
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          }
          // Handle other indices if needed
        },
        items: [
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

  // Build Duty Card Widget
  Widget _buildDutyCard(
      BuildContext context, String title, String date, String time) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.meeting_room, color: Colors.blue, size: 40),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
