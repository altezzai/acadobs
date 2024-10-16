import 'package:flutter/material.dart';

class DutiesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.05,
              ),
            ),
            DutyCard(
                title: "Classroom Supervision",
                date: "15-06-24",
                isOngoing: true),
            SizedBox(height: 20),
            Text(
              'Yesterday',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.05,
              ),
            ),
            DutyCard(title: "Lunch Duty", date: "14-06-24", isOngoing: false),
          ],
        ),
      ),
    );
  }
}

class DutyCard extends StatelessWidget {
  final String title;
  final String date;
  final bool isOngoing;

  const DutyCard({
    required this.title,
    required this.date,
    required this.isOngoing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 10),
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
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(date,
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),
          Text(
            isOngoing ? "Ongoing" : "Completed",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isOngoing ? Colors.green : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
