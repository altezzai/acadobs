import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/calender_widget.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/widgets/daily_attendance_container.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';
import 'package:intl/intl.dart';

class StudentDetailPage extends StatefulWidget {
  final Student student;

  const StudentDetailPage({required this.student, Key? key}) : super(key: key);

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  late AchievementController achievementController;

  @override
  void initState() {
    super.initState();
    achievementController = context.read<AchievementController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final studentController = context.read<StudentController>();
      studentController.getDayAttendance(
          studentId: widget.student.id.toString());
      achievementController.getAchievements(student_id: widget.student.id ?? 0);
      studentController.getStudentHomework(studentId: widget.student.id ?? 0);
    });
  }

  /// Utility to group items by date into "Today," "Yesterday," and specific dates
  Map<String, List<T>> groupItemsByDate<T>(
      List<T> items, DateTime Function(T) getDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    Map<String, List<T>> groupedItems = {};

    for (var item in items) {
      final itemDate =
          DateTime(getDate(item).year, getDate(item).month, getDate(item).day);
      String formattedDate;

      if (itemDate == today) {
        formattedDate = "Today";
      } else if (itemDate == yesterday) {
        formattedDate = "Yesterday";
      } else {
        formattedDate = DateFormat.yMMMMd().format(itemDate);
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
      }
      groupedItems[formattedDate]!.add(item);
    }

    // Sort categories, with "Today" and "Yesterday" on top
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey("Today")) {
      sortedEntries.add(MapEntry("Today", groupedItems["Today"]!));
      groupedItems.remove("Today");
    }
    if (groupedItems.containsKey("Yesterday")) {
      sortedEntries.add(MapEntry("Yesterday", groupedItems["Yesterday"]!));
      groupedItems.remove("Yesterday");
    }

    sortedEntries.addAll(
        groupedItems.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));

    return Map.fromEntries(sortedEntries);
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
            textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14)),
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
                        SizedBox(height: Responsive.height * 2),
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
                      ],
                    ),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.grey.shade200,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        tabs: const [
                          Tab(text: "Dashboard"),
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
                  _buildDashboardContent(),
                  _buildAchievementsContent(),
                  Center(child: Text("Exam Content")),
                  _buildHomeworkContent(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        SizedBox(height: Responsive.height * 8),
        const Text("Attendance", style: TextStyle(fontSize: 20)),
        SizedBox(height: Responsive.height * 2),
        DailyAttendanceContainer(
          studentId: widget.student.id.toString(),
          onSelectDate: () => _selectDate(context),
        ),
        SizedBox(height: Responsive.height * 3),
        CalenderWidget(),
        SizedBox(height: Responsive.height * 8),
      ],
    );
  }

  Widget _buildAchievementsContent() {
    return Consumer<AchievementController>(builder: (context, value, child) {
      if (value.isloading) {
        return const Center(child: CircularProgressIndicator());
      }

      final groupedAchievements = groupItemsByDate(
        value.achievements,
        (achievement) =>
            DateTime.parse(achievement.dateOfAchievement.toString()),
      );

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        itemCount: groupedAchievements.length,
        itemBuilder: (context, index) {
          final entry = groupedAchievements.entries.elementAt(index);
          final dateGroup = entry.key;
          final achievements = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                dateGroup,
                style: textThemeData.bodyMedium,
              ),
              const SizedBox(height: 10),
              ...achievements.map((achievement) => WorkContainer(
                    sub: achievement.awardingBody ?? "",
                    work: achievement.category ?? "",
                    icon: Icons.military_tech,
                    icolor: Colors.green,
                    bcolor: Colors.green.withOpacity(0.2),
                    onTap: () {
                      context.pushNamed(
                        AppRouteConst.AchivementDetailRouteName,
                        extra: achievement,
                      );
                    },
                  )),
              const SizedBox(height: 20),
            ],
          );
        },
      );
    });
  }

  Widget _buildHomeworkContent() {
    return Consumer<StudentController>(builder: (context, value, child) {
      if (value.isloading) {
        return const Center(child: CircularProgressIndicator());
      }

      final groupedHomework = groupItemsByDate(
        value.homeworks,
        (homework) => DateTime.parse(homework.dueDate.toString()),
      );

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        itemCount: groupedHomework.length,
        itemBuilder: (context, index) {
          final entry = groupedHomework.entries.elementAt(index);
          final dateGroup = entry.key;
          final homeworks = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                dateGroup,
                style: textThemeData.bodyMedium,
              ),
              const SizedBox(height: 10),
              ...homeworks.map((homework) => WorkContainer(
                    sub: homework.status ?? "",
                    work: homework.assignmentTitle ?? "",
                    icon: Icons.home_work_outlined,
                    onTap: () {
                      context.pushNamed(
                        AppRouteConst.workviewRouteName,
                        extra: homework,
                      );
                    },
                  )),
              const SizedBox(height: 20),
            ],
          );
        },
      );
    });
  }
}
