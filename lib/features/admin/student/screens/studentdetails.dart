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
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/controller/exam_controller.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/admin/student/screens/achievements_list.dart';
import 'package:school_app/features/admin/student/screens/homework_list.dart';
import 'package:school_app/features/admin/student/widgets/daily_attendance_container.dart';
import 'package:school_app/features/admin/student/widgets/daily_attendance_shimmer.dart';
import 'package:school_app/features/admin/student/widgets/date_group_function.dart';
import 'package:school_app/features/parent/leave_request/screens/student_leaveRequest.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';
// import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

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
  late NotesController noteController;

  @override
  void initState() {
    // super.initState();
    achievementController = context.read<AchievementController>();
    examController = context.read<ExamController>();
    noteController = context.read<NotesController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final studentController = context.read<StudentController>();
      studentController.getDayAttendance(
          studentId: widget.student.id.toString(), forBuildScreen: true);
      studentController.updateDate(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
          studentId: widget.student.id.toString());
      achievementController.getAchievements(studentId: widget.student.id ?? 0);
      studentController.getStudentHomework(studentId: widget.student.id ?? 0);
      examController.getExamMarks(studentId: widget.student.id ?? 0);
      noteController.fetchUnviewedNotesCountByStudentId(
          studentId: widget.student.id ?? 0);
      noteController.getNotesByStudentId(studentId: widget.student.id ?? 0);
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
      length: 5, // Number of tabs
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
                        SizedBox(height: Responsive.height * 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFFD9D9D9),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                ),
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Student",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                            widget.userType == UserType.parent
                                ? Consumer<NotesController>(
                                    builder: (context, noteController, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.pushNamed(
                                          AppRouteConst.parentNoteRouteName,
                                          extra: widget.student.id,
                                        );
                                      },
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Image.asset(
                                            "assets/icons/add_note.png",
                                            height: 32,
                                          ),
                                          if (noteController
                                                  .unviewedNotesCount >
                                              0) // Show badge only if count > 0
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .red, // Badge background color
                                                  shape: BoxShape.circle,
                                                ),
                                                constraints: BoxConstraints(
                                                  minWidth: 16,
                                                  minHeight: 16,
                                                ),
                                                child: Text(
                                                  '${noteController.unviewedNotesCount}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  })
                                : IconButton(
                                    onPressed: () {
                                      context.pushNamed(
                                          AppRouteConst.UpdateStudentRountName,
                                          extra: widget.student);
                                    },
                                    icon: Icon(Icons.edit)),
                          ],
                        ),
                        SizedBox(
                          height: Responsive.height * 3,
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
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
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
                            Tab(text: "Leave Request"),
                          ],
                        ),
                      ),
                    )),
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
                  StudentLeaveRequestScreen(
                    studentId: widget.student.id ?? 0,
                    userType: widget.userType,
                    onPressed: () {
                      context.pushNamed(
                          AppRouteConst.AddStudentLeaveRequestRouteName,
                          extra: widget.student.id);
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Consumer<StudentController>(builder: (context, value, child) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          SizedBox(height: Responsive.height * 8),
          const Text("Attendance", style: TextStyle(fontSize: 20)),
          SizedBox(height: Responsive.height * 2),
          value.isloading
              ? DailyAttendanceShimmer()
              : DailyAttendanceContainer(
                  studentId: widget.student.id.toString(),
                  onSelectDate: () => _selectDate(context),
                ),
          SizedBox(height: Responsive.height * 3),
          CalenderWidget(),
          SizedBox(height: Responsive.height * 8),
        ],
      );
    });
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

        return value.exam.isEmpty
            ? const Center(
                child: Text("No Exams Found!"),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                      _buildExamCard(
                        exams.isNotEmpty
                            ? exams.first.classGrade ?? "N/A"
                            : "N/A",
                        exams.isNotEmpty ? exams.first.section ?? "N/A" : "N/A",
                        exams.isNotEmpty ? exams.first.title ?? "N/A" : "N/A",
                        exams.map((exam) {
                          return {
                            "subject": exam.subject ?? "",
                            "mark": exam.marks?.toString() ?? "0",
                            "total": exam.totalMarks?.toString() ?? "0",
                          };
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              );
      },
    );
  }

  Widget _buildExamCard(String grade, String division, String examName,
      List<Map<String, String>> subjects) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
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
                        "$grade $division",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        examName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.assessment, color: Colors.white, size: 20),
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
                const Divider(),
                ...subjects.map((subject) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(subject["subject"]!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
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
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
