import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:school_app/admin/screens/addAchivement.dart';
import 'package:school_app/admin/screens/addhomwork.dart';

class StudentDetailPage extends StatelessWidget {
  final String name;
  final String studentClass;
  final String image;

  StudentDetailPage({
    required this.name,
    required this.studentClass,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.15,
                  backgroundImage: AssetImage('assets/$image'),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                Text(
                  'Class: $studentClass',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        indicatorPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01),
                        tabs: [
                          Tab(text: "Dashboard"),
                          Tab(text: "Achievements"),
                          Tab(text: "Exam"),
                          Tab(text: "Home Work"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildScrollableDashboardContent(),
                        Stack(
                          children: [
                            _buildScrollableAchievementsContent(),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: FloatingActionButton(
                                onPressed: () {
                                  _showAddAchievementDialog(context);
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
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
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

  Widget _buildAchievementsContent() {
    final List<Map<String, String>> achievements = [
      {"position": "1st place", "event": "Quiz Competition", "date": "Today"},
      {
        "position": "2nd place",
        "event": "Independence day Quiz",
        "date": "Yesterday"
      },
      {
        "position": "Participate",
        "event": "Quiz Competition - District level",
        "date": "Yesterday"
      },
      {
        "position": "1st place",
        "event": "Quiz Competition",
        "date": "Yesterday"
      },
      {
        "position": "1st place",
        "event": "Quiz Competition",
        "date": "Yesterday"
      },
      {
        "position": "1st place",
        "event": "Quiz Competition",
        "date": "Yesterday"
      },
    ];

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        final String position = achievement['position']!;
        final String event = achievement['event']!;
        final String date = achievement['date']!;

        Color medalColor;
        if (position.contains("1st")) {
          medalColor = Colors.yellow;
        } else if (position.contains("2nd")) {
          medalColor = Colors.green;
        } else if (position.contains("Participate")) {
          medalColor = Colors.blue;
        } else {
          medalColor = Colors.grey;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 || achievements[index - 1]['date'] != date)
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                child: Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ListTile(
              leading: Icon(Icons.military_tech, color: medalColor),
              title: Text(
                position,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                event,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Divider(thickness: 1.5, color: Colors.grey[300]),
          ],
        );
      },
    );
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
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
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        examName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.assessment, color: Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Subject",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600])),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Mark",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600]),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                Divider(),
                ...subjects
                    .map((subject) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(subject["subject"]!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(subject["mark"]!,
                                    style: TextStyle(
                                        color: Colors.green[700],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(subject["total"]!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Score",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "${subjects.fold(0, (sum, subject) => sum + int.parse(subject["mark"]!))}/${subjects.fold(0, (sum, subject) => sum + int.parse(subject["total"]!))}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue[700]),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            }

            final homework = homeworks[index - 1];
            final String title = homework['title']!;
            final String subject = homework['subject']!;
            final String date = homework['date']!;

            if (index > 1 && date != homeworks[index - 2]['date']) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 16.0, bottom: 8.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _buildHomeworkItem(title, subject),
                ],
              );
            }

            return _buildHomeworkItem(title, subject);
          },
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddHomeworkPage(),
                ),
              );
            },
            child: Text('Add Home work'),
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

  Widget _buildHomeworkItem(String title, String subject) {
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            subject,
            style: TextStyle(fontSize: 16),
          ),
          trailing: TextButton(
            onPressed: () {
              // TODO: Implement view functionality
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

  void _showAddAchievementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Achievement',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Would you like to add an achievement?',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddAchievementPage(),
                  ),
                );
              },
              child: Text('Add',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
