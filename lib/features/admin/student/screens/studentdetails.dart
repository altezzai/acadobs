import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/calender_widget.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/widgets/daily_attendance_container.dart';

class StudentDetailPage extends StatefulWidget {
  final Student student;

  StudentDetailPage({required this.student});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  late AchievementController achievementController;
  @override
  void initState() {
    // Fetch today's attendance on page build
    achievementController = context.read<AchievementController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<StudentController>();
      controller.getDayAttendance(studentId: widget.student.id.toString());

      achievementController.getAchievements(student_id: widget.student.id ?? 0);
    });
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: context.read<StudentController>().selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 14),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      await context
          .read<StudentController>()
          .updateDate(pickedDate, studentId: widget.student.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        body: Consumer<StudentController>(builder: (context, value, child) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                          imagePath:
                              "${baseUrl}${Urls.studentPhotos}${widget.student.studentPhoto}",
                          name: capitalizeFirstLetter(
                              widget.student.fullName ?? ""),
                          description:
                              "${widget.student.studentClass} ${widget.student.section}",
                          present: "25",
                          absent: "2",
                          late: "3",
                        ),
                        // SizedBox(height: Responsive.height * 2),
                      ],
                    ),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    // automaticallyImplyLeading: false,
                    pinned: true,
                    floating: false,
                    backgroundColor: Colors.grey.shade200,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0), // Adjust height here
                      child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors
                            .black, // Optional: Customize the indicator color
                        labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        tabs: [
                          Tab(
                            text: "Dashboard",
                          ),
                          Tab(text: "Achievements"),
                          Tab(text: "Exam"),
                          Tab(text: "Homework"),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TabBarView(
                children: [
                  // First Tab Content
                  _buildDashboardContent(),
                  // Second Tab Content
                  _buildAchievementsContent(),
                  // ListView(
                  //   padding: const EdgeInsets.all(16.0),
                  //   children: [
                  //     SizedBox(height: 20),
                  //     Text("Transit Tab Content",
                  //         style: TextStyle(fontSize: 20)),
                  //   ],
                  // ),
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
          );
        }),
      ),
    );
  }

  // dashboard content
  Widget _buildDashboardContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        SizedBox(height: Responsive.height * 8),
        Text("Attendance", style: TextStyle(fontSize: 20)),
        SizedBox(height: Responsive.height * 2),
        DailyAttendanceContainer(
          studentId: widget.student.id.toString(),
          onSelectDate: () => _selectDate(context),
        ),

        SizedBox(height: Responsive.height * 3),
        CalenderWidget(),
        SizedBox(height: Responsive.height * 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 2,
              width: Responsive.width * 40,
              color: Colors.grey[400],
            ),
            Container(
              height: 3,
              width: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // shape: BoxShape.circle,
                color: Colors.grey[400],
              ),
            ),
            Container(
              height: 2,
              width: Responsive.width * 40,
              color: Colors.grey[400],
            ),
          ],
        )
        // SizedBox(height: 30),
      ],
    );
  }

  Widget _buildAchievementsContent() {
    return Consumer<AchievementController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        children: [
          SizedBox(height: Responsive.height * 3),
          ListView.builder(
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
                      DateFormatter.formatDateString(value
                          .achievements[index].dateOfAchievement
                          .toString()),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black87, // Match with StudentDetailPage
                      ),
                    ),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.military_tech, color: Colors.greenAccent),
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
          ),
        ],
      );
    });
  }
}
