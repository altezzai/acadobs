import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/calender_widget.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/controller/exam_controller.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/screens/achievements_list.dart';
import 'package:school_app/features/admin/student/screens/homework_list.dart';
import 'package:school_app/features/admin/student/widgets/daily_attendance_container.dart';
import 'package:school_app/features/admin/student/widgets/date_group_function.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class StudentDetailPage extends StatefulWidget {
  final Student student;
  final UserType userType;

  const StudentDetailPage(
      {super.key, required this.student, required this.userType});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  late AchievementController achievementController;
  late ExamController examController;

  @override
  void initState() {
    super.initState();
    achievementController = context.read<AchievementController>();
    examController = context.read<ExamController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final studentController = context.read<StudentController>();
      studentController.getDayAttendance(
          studentId: widget.student.id.toString());
      achievementController.getAchievements(studentId: widget.student.id ?? 0);
      studentController.getStudentHomework(studentId: widget.student.id ?? 0);
      examController.getExamMarks(studentId: widget.student.id ?? 0);
    });
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
                            Navigator.pop(context);
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
                        tabAlignment: TabAlignment.start,
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
                  AchievementsList(
                    userType: widget.userType,
                    onPressed: () {
                      context.pushNamed(AppRouteConst.AddAchivementsRouteName,
                          extra: widget.student.id);
                    },
                  ),
                  _buildExamContent(),
                  HomeworkList(),
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

  Widget _buildExamContent() {
    return Consumer<ExamController>(
      builder: (context, value, child) {
        if (value.isloading) {
          return const Center(
              child: Loading(
            color: Colors.grey,
          ));
        }

        final groupedExams = groupItemsByDate(
          value.exam,
          (exam) => DateTime.parse(exam.date.toString()),
        );

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          itemCount: groupedExams.length,
          itemBuilder: (context, index) {
            final entry = groupedExams.entries.elementAt(index);
            final dateGroup = entry.key;
            final exams = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 2),
                Text(
                  dateGroup,
                  style: textThemeData.bodyMedium,
                ),
                const SizedBox(height: 10),
                ...exams.map((exam) => WorkContainer(
                      sub: exam.subject ?? "",
                      work: exam.title ?? "",
                      icon: Icons.workspace_premium_outlined,
                      icolor: Colors.green,
                      bcolor: Colors.green.withOpacity(0.2),
                      prefixText:
                          '${exam.marks.toString()} / ${exam.totalMarks}',
                    )),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}
