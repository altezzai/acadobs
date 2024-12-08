import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';

class TeacherReport extends StatefulWidget {
  const TeacherReport({super.key});

  @override
  State<TeacherReport> createState() => _TeacherReportState();
}

class _TeacherReportState extends State<TeacherReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
              title: "Teacher Report",
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