import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';

class StudentReport extends StatefulWidget {
  const StudentReport({super.key});

  @override
  State<StudentReport> createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
              title: "Student Report",
              isBackButton: true,
              onTap: () {
                context.pop(              
                );
              },
            ),
            const SizedBox(height: 16),
          ]))
    );
  }
}