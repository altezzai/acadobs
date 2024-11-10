import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/calender_widget.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/screens/homeworkdetail.dart';

class StudentDetailPage extends StatefulWidget {
  // final String name;
  // final String studentClass;
  // final String image;
  final Student student;

  StudentDetailPage(
      {
      // required this.name,
      // required this.studentClass,
      // required this.image,
      required this.student});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  @override
  void initState() {
    context.read<AchievementController>().getAchievements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              name: capitalizeFirstLetter(widget.student.fullName ?? ""),
              description:
                  "${widget.student.studentClass} ${widget.student.section}",
            ),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    SizedBox(height: Responsive.height * 2),
                    TabBar(
                      isScrollable: true,
                      labelColor: Colors.black,
                      // unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      tabAlignment: TabAlignment.start,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: -16),
                      labelPadding: EdgeInsets.symmetric(horizontal: 16),
                      tabs: [
                        Tab(
                          child: Text("Dashboard"),
                        ),
                        Tab(
                          child: Text("Achievements"),
                        ),
                        Tab(
                          child: Text("Exam"),
                        ),
                        Tab(
                          child: Text("Home Work"),
                        ),
                      ],
                    ),
                    // SizedBox(height: 40),
                    Expanded(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Responsive.height * 2,
                                ),
                                Text("Attendance"),
                                SizedBox(
                                  height: Responsive.height * 2,
                                ),
                                CalenderWidget(),
                              ],
                            ),
                          ),
                          // _buildScrollableDashboardContent(),
                          Stack(
                            children: [
                              _buildScrollableAchievementsContent(),
                              Positioned(
                                bottom: 16,
                                right: 16,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    context.pushReplacementNamed(
                                        AppRouteConst.AddAchivementsRouteName);
                                  },
                                  child: Icon(Icons.add),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          _buildScrollableExamsContent(),
                          _buildScrollableHomeWorksContent(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableDashboardContent() {
    return SingleChildScrollView(
      child: _buildDashboardContent(),
    );
  }

  Widget _buildDashboardContent() {
    final Map<String, double> dataMap = {
      "Presents": 23,
      "Late": 7,
      "Absent": 3,
    };

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Attendance",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 60),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: PieChart(
              dataMap: dataMap,
              chartType: ChartType.disc,
              colorList: [Colors.green, Colors.orange, Colors.red],
              legendOptions: LegendOptions(
                showLegends: true,
                legendPosition: LegendPosition.right,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValues: true,
                showChartValuesInPercentage: true,
                chartValueBackgroundColor: Colors.transparent,
                decimalPlaces: 1,
              ),
              ringStrokeWidth: 40,
              baseChartColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableAchievementsContent() {
    return SingleChildScrollView(
      child: _buildAchievementsContent(),
    );
  }
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

Widget _buildScrollableExamsContent() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildExamCard("XIIth", "1st semester", "Mid-term Exam", [
            {"subject": "Mathematics", "mark": "86", "total": "100"},
            {"subject": "Physics", "mark": "92", "total": "100"},
            {"subject": "Chemistry", "mark": "88", "total": "100"},
          ]),
          SizedBox(height: 16),
          _buildExamCard("XIIth", "1st semester", "Final Exam", [
            {"subject": "Mathematics", "mark": "91", "total": "100"},
            {"subject": "Physics", "mark": "89", "total": "100"},
            {"subject": "Chemistry", "mark": "94", "total": "100"},
          ]),
        ],
      ),
    ),
  );
}

Widget _buildExamCard(String grade, String semester, String examName,
    List<Map<String, String>> subjects) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$grade : $semester",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 2),
                    Text(
                      examName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Icon(Icons.assessment, color: Colors.white, size: 20),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("Subject",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey[600])),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Mark",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey[600]),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey[600]),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
              Divider(),
              ...subjects
                  .map((subject) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(subject["subject"]!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(subject["mark"]!,
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(subject["total"]!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Score",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(
                    "${subjects.fold(0, (sum, subject) => sum + int.parse(subject["mark"]!))}/${subjects.fold(0, (sum, subject) => sum + int.parse(subject["total"]!))}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blue[700]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildScrollableHomeWorksContent(BuildContext context) {
  final List<Map<String, String>> homeworks = [
    {"title": "Home work", "subject": "Maths", "date": "Today"},
    {"title": "Imposition", "subject": "Hindi", "date": "Yesterday"},
    {"title": "Home work", "subject": "Maths", "date": "Yesterday"},
    {"title": "Imposition", "subject": "Malayalam", "date": "Yesterday"},
    {"title": "Imposition", "subject": "Social Science", "date": "Yesterday"},
    {"title": "Imposition", "subject": "Malayalam", "date": "Yesterday"},
  ];

  return Stack(
    children: [
      ListView.builder(
        itemCount: homeworks.length + 1, // +1 for the date header
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Text(
                "Today",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            );
          }

          final homework = homeworks[index - 1];
          final String title = homework['title']!;
          final String subject = homework['subject']!;
          final String date = homework['date']!;

          // Check if the date has changed for the header
          if (index > 1 && date != homeworks[index - 2]['date']) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                _buildHomeworkItem(context, title, subject),
              ],
            );
          }

          return _buildHomeworkItem(context, title, subject);
        },
      ),
      Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: ElevatedButton(
          onPressed: () {
            context.pushReplacementNamed(AppRouteConst.AddHomeworkRouteName);
          },
          child: Text('Add Homework'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    ],
  );
}

Widget _buildHomeworkItem(BuildContext context, String title, String subject) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              title == 'Home work' ? Colors.yellow[700] : Colors.pink[100],
          child: Icon(
            title == 'Home work' ? Icons.work : Icons.edit,
            color: title == 'Home work' ? Colors.white : Colors.pink,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subject,
          style: TextStyle(fontSize: 16),
        ),
        trailing: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    HomeworkDetails(title: '$title - $subject'),
              ),
            );
          },
          child: Text(
            'View',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
