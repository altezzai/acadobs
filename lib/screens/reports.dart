import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReportCard(
              title: 'Payment Report',
              icon: Icons.currency_rupee,
              color: Colors.green,
              onTap: () {
                // Navigate to Payment Report page
              },
            ),
            SizedBox(height: 16),
            ReportCard(
              title: 'Student Report',
              icon: Icons.person_outline,
              color: Colors.blue,
              onTap: () {
                // Navigate to Student Report page
              },
            ),
            SizedBox(height: 16),
            ReportCard(
              title: 'Teacher Report',
              icon: Icons.person_rounded,
              color: Colors.brown,
              onTap: () {
                // Navigate to Teacher Report page
              },
            ),
            SizedBox(height: 16),
            ReportCard(
              title: 'Class Report',
              icon: Icons.school_outlined,
              color: Colors.purple,
              onTap: () {
                // Navigate to Class Report page
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ReportCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
