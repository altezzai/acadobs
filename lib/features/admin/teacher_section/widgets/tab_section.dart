import 'package:flutter/material.dart';
import 'package:school_app/features/admin/teacher_section/widgets/activity_tab.dart';
import 'package:school_app/features/admin/teacher_section/widgets/dashboard_tab.dart';
import 'package:school_app/features/admin/teacher_section/widgets/duties_tab.dart';

class TabSection extends StatelessWidget {
  final int teacherId;
  const TabSection({
    super.key,
    required this.teacherId,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // StatRow(),
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
                DashboardTab(),
                ActivityTab(),
                DutiesTab(
                  teacherId: teacherId,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
