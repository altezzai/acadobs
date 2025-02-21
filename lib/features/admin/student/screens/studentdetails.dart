import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
//import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
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
      studentController.getIndividualStudentDetails(
          studentId: widget.student.id ?? 0);
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
          final studentDetail = value.individualStudent;
          return value.isloading
              ? Loading()
              : NestedScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          fontSize: 22,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                  widget.userType == UserType.parent
                                      ? Consumer<NotesController>(builder:
                                          (context, noteController, child) {
                                          return GestureDetector(
                                            onTap: () {
                                              context.pushNamed(
                                                AppRouteConst
                                                    .parentNoteRouteName,
                                                extra: studentDetail.id,
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
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .red, // Badge background color
                                                        shape: BoxShape.circle,
                                                      ),
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 16,
                                                        minHeight: 16,
                                                      ),
                                                      child: Text(
                                                        '${noteController.unviewedNotesCount}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        })
                                      : Consumer<StudentController>(
                                          builder: (context, value, child) {
                                          return CustomPopupMenu(onEdit: () {
                                            context.pushNamed(
                                                AppRouteConst
                                                    .UpdateStudentRountName,
                                                extra: studentDetail);
                                          }, onDelete: () {
                                            showConfirmationDialog(
                                                context: context,
                                                title: "Delete Student?",
                                                content:
                                                    "Are you sure you want to delete this student?",
                                                onConfirm: () {
                                                  value.deleteStudents(context,
                                                      studentId:
                                                          widget.student.id ??
                                                              0);
                                                });
                                          });
                                        })
                                ],
                              ),
                              SizedBox(
                                height: Responsive.height * 3,
                              ),
                              ProfileContainer(
                                imagePath:
                                    "${baseUrl}${Urls.studentPhotos}${studentDetail.studentPhoto}",
                                name: capitalizeFirstLetter(
                                    studentDetail.fullName ?? ""),
                                description:
                                    "${studentDetail.studentClass} ${studentDetail.section}",
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
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
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
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                tabs: const [
                                  Tab(text: "Dashboard"),
                                  Tab(text: "Achievements"),
                                  Tab(text: "Marks"),
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
                            context.pushNamed(
                                AppRouteConst.AddAchivementsRouteName,
                                extra: studentDetail!.id);
                          },
                        ),
                        _buildExamContent(),
                        HomeworkList(),
                        StudentLeaveRequestScreen(
                          studentId: studentDetail!.id ?? 0,
                          userType: widget.userType,
                          onPressed: () {
                            context.pushNamed(
                                AppRouteConst.AddStudentLeaveRequestRouteName,
                                extra: studentDetail.id ?? 0);
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
          return const Center(child: Loading(color: Colors.grey));
        }

        // Group exams by date using the provided groupItemsByDate function
        final groupedExams = groupItemsByDate(
          value.exam,
          (exam) => DateTime.parse(exam.date.toString()),
        );

        return value.exam.isEmpty
            ? SizedBox(
                width: double.infinity,
                height: Responsive.height * 5, // Adjust height as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: Responsive.height * 5), // Moves text lower
                    const Text(
                      "No Exams Found!",
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Responsive.height * 5),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      itemCount: groupedExams.length,
                      itemBuilder: (context, index) {
                        final entry = groupedExams.entries.elementAt(index);
                        final dateGroup = entry.key;
                        final exams = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Responsive.height * 2),
                            Text(dateGroup, style: textThemeData.bodyMedium),
                            const SizedBox(height: 10),
                            // Create cards for each exam in the same date group
                            ...exams.map((exam) {
                              return _buildExamCard(
                                exam.classGrade ?? "N/A",
                                exam.section ?? "N/A",
                                exam.title ?? "N/A",
                                exam.attendanceStatus ?? "N/A",
                                [
                                  {
                                    "subject": exam.subject ?? "",
                                    "mark": exam.marks?.toString() ?? "0",
                                    "total": exam.totalMarks?.toString() ?? "0",
                                    "attendance_status":
                                        exam.attendanceStatus ?? "N/A",
                                  }
                                ],
                              );
                            }).toList(),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget _buildExamCard(
    String grade,
    String division,
    String examName,
    String attendanceStatus,
    List<Map<String, String>> subjects,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exam Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "$grade $division",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    //const SizedBox(height: 2),
                    const SizedBox(
                      width: 16,
                      height: 10,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      examName,
                      style: const TextStyle(
                        color: Color(0xFFD4D4D4),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                // Exam Subjects and Details

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Subject",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Mark",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Total",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ...subjects.map((subject) => Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(subject["subject"]!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(subject["mark"]!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(subject["total"]!,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Map<String, List<T>> groupItemsByDate<T>(
    List<T> items,
    DateTime Function(T) getDate,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    Map<String, List<T>> groupedItems = {};
    Map<String, DateTime> dateKeys = {}; // To store actual dates for sorting

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
        dateKeys[formattedDate] = itemDate; // Save the actual date for sorting
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

    // Sort remaining entries by their actual dates (descending order)
    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = dateKeys[a.key]!;
          final dateB = dateKeys[b.key]!;
          return dateB.compareTo(dateA); // Sort by date descending
        }),
    );

    return Map.fromEntries(sortedEntries);
  }
}
