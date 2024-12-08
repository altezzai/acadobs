import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';

class ClassReport extends StatefulWidget {
  const ClassReport({super.key});

  @override
  State<ClassReport> createState() => _ClassReportState();
}

class _ClassReportState extends State<ClassReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
              title: "Class Report",
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