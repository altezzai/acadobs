import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class TeacherDetailsPage extends StatelessWidget {
  final String name;
  final String studentClass;
  final String image;

  TeacherDetailsPage({
    required this.name,
    required this.studentClass,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06,
                color: Colors.black)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          _buildHeader(screenWidth),
          Expanded(child: _buildTabView(screenWidth, screenHeight, context)),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Column(
      children: [
        CircleAvatar(
            radius: screenWidth * 0.15,
            backgroundImage: AssetImage('assets/$image')),
        SizedBox(height: 20),
        Text(name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05)),
        Text('Class: $studentClass',
            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTabView(
      double screenWidth, double screenHeight, BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          _buildStatRow(),
          TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "Dashboard"),
              Tab(text: "Activity"),
              Tab(text: "Duty"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildDashboardContent(),
                _buildActivityContent(context),
                _buildDutiesContent(
                    context), // Use the new Duties content method
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('23', 'Presents'),
        _buildStatItem('7', 'Late'),
        _buildStatItem('3', 'Absent'),
      ],
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDashboardContent() {
    final dataMap = {"Presents": 23.0, "Late": 7.0, "Absent": 3.0};
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Attendance",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 60),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: PieChart(
              dataMap: dataMap,
              chartType: ChartType.disc,
              colorList: [Colors.green, Colors.orange, Colors.red],
              legendOptions: LegendOptions(
                showLegends: true,
                legendPosition: LegendPosition.right,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValues: true,
                showChartValuesInPercentage: true,
                chartValueBackgroundColor: Colors.transparent,
                decimalPlaces: 1,
              ),
              ringStrokeWidth: 40,
              baseChartColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityContent(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Today',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              _buildActivityCard(
                  context, "Classroom Activities", "15-06-24", "09:00 am"),
              SizedBox(height: screenHeight * 0.02),
              _buildActivityCard(
                  context, "Teacher's Meeting", "14-06-24", "11:00 am"),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Yesterday',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              _buildActivityCard(
                  context, "Science Fair", "14-06-24", "10:00 am"),
              SizedBox(height: screenHeight * 0.02),
              _buildActivityCard(context, "Sports Day", "14-06-24", "11:00 am"),
            ],
          ),
        ),
      ),
    );
  }

  // Build Activity Card Widget
  Widget _buildActivityCard(
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
              Icon(Icons.class_rounded, color: Colors.blue, size: 40),
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
                    style: TextStyle(color: Colors.grey, fontSize: 13),
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

  // New Duties Content Method
  Widget _buildDutiesContent(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Today',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              _buildDutyCard(
                  context, "Classroom Supervision", "15-06-24", true),
              SizedBox(height: screenHeight * 0.02),
              _buildDutyCard(
                  context, "Parent-Teacher Meeting", "14-06-24", true),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Yesterday',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              _buildDutyCard(context, "Lunch Duty", "14-06-24", false),
              SizedBox(height: screenHeight * 0.02),
              _buildDutyCard(context, "After School Care", "14-06-24", false),
            ],
          ),
        ),
      ),
    );
  }

// Build Duty Card Widget
  Widget _buildDutyCard(
      BuildContext context, String title, String date, bool isOngoing) {
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
              Icon(Icons.work_history, color: Colors.blue, size: 40),
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
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          Text(
            isOngoing ? "Ongoing" : "Completed",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: isOngoing
                  ? Colors.green
                  : Colors.blue, // Color based on status
            ),
          ),
        ],
      ),
    );
  }
}
