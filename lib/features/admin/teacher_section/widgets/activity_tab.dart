import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class ActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.height * 2),
            Text(
              'Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.05,
              ),
            ),
            ActivityCard(
                title: "Classroom Activities",
                date: "15-06-24",
                time: "09:00 am"),
            ActivityCard(
                title: "Teacher's Meeting", date: "14-06-24", time: "11:00 am"),
            SizedBox(height: Responsive.height * 2),
            Text(
              'Yesterday',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.05,
              ),
            ),
            ActivityCard(
                title: "Science Fair", date: "14-06-24", time: "10:00 am"),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const ActivityCard({
    required this.title,
    required this.date,
    required this.time,
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
              Icon(Icons.class_rounded, color: Colors.blue, size: 40),
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
          Text(time, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
