import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/superadmin/bottom_nav/bottom_navbar_controller.dart';
import 'package:school_app/features/superadmin/school_classes/presentation/school_classes_screen.dart';
import 'package:school_app/features/superadmin/school_subjects/presentation/school_subjects_screen.dart';
import 'package:school_app/features/superadmin/schools/presentation/schools_list_screen.dart';
import 'bottom_nav_widget.dart';

class BottomNavScaffold extends StatelessWidget {
  const BottomNavScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<BottomNavbarController>().currentIndex;

    final pages = [
      const SchoolsListScreen(),
      const SchoolClassesScreen(),
      const SchoolSubjectsScreen(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}
