import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/calender_widget.dart';
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/widgets/daily_attendance_container.dart';

import 'core/shared_widgets/custom_appbar.dart';

class StickyTabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Responsive.height * 2,
                      ),
                      CustomAppbar(
                        title: "Students",
                        isProfileIcon: false,
                        onTap: () {
                          context.pop();
                        },
                      ),
                      ProfileContainer(
                          imagePath: "assets/staff3.png",
                          name: "name",
                          present: "25",
                          absent: "3",
                          late: "2"),
                      SizedBox(height: Responsive.height * 2),
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                pinned: true,
                floating: false,
                backgroundColor: Colors.white,
                bottom: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Dashboard"),
                    Tab(text: "Achievements"),
                    Tab(text: "Exam"),
                    Tab(text: "Homework"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              // First Tab Content
              ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  SizedBox(height: 20),
                  Text("Attendance", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  DailyAttendanceContainer(),
                  CalenderWidget(),
                  SizedBox(height: 30),
                ],
              ),
              // Second Tab Content
              _buildAchievementsContent(),
              ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  SizedBox(height: 20),
                  Text("Transit Tab Content", style: TextStyle(fontSize: 20)),
                ],
              ),
              // Third Tab Content
              ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  SizedBox(height: 20),
                  Text("Bike Tab Content", style: TextStyle(fontSize: 20)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementsContent() {
    return Consumer<AchievementController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: value.achievements.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Text(
                  DateFormatter.formatDateString(
                      value.achievements[index].dateOfAchievement.toString()),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black87, // Match with StudentDetailPage
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.military_tech, color: Colors.greenAccent),
                title: Text(
                  value.achievements[index].achievementTitle ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87, // Match with StudentDetailPage
                  ),
                ),
                subtitle: Text(
                  value.achievements[index].awardingBody ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // Keep consistent
                  ),
                ),
              ),
              Divider(thickness: 1.5, color: Colors.grey[300]),
            ],
          );
        },
      );
    });
  }
}
