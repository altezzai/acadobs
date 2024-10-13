import 'package:flutter/material.dart';
import 'package:school_app/features/admin/reports/widgets/report_card.dart';
import 'package:school_app/features/teacher/widgets/custom_appbar.dart';

class ReportsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
              title: "Reports",
              isBackButton: false,
            ),
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
              color: Colors.red,
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
