import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/teacher_section/widgets/activity_tab.dart';
import 'package:school_app/features/teacher/marks/controller/marks_controller.dart';

class TeacherMarksList extends StatefulWidget {
  const TeacherMarksList({super.key});

  @override
  State<TeacherMarksList> createState() => _TeacherMarksListState();
}

class _TeacherMarksListState extends State<TeacherMarksList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MarksController>().getTeacherMarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: Responsive.height * 2),
            CustomAppbar(
              title: "Exam Marks",
              isProfileIcon: false,
              isBackButton: false,
            ),
            SizedBox(height: Responsive.height * 2),

            // Add Marks Button
            _customContainer(
              color: Colors.black,
              text: 'Add Marks',
              icon: Icons.assignment_add,
              ontap: () {
                context.pushNamed(AppRouteConst.progressreportRouteName);
              },
            ),
            SizedBox(height: Responsive.height * 2),

            // List of Teacher's Marks
            Expanded(
              child: _buildTeacherAddedMarksList(),
            ),
          ],
        ),
      ),
    );
  }

  // Build List of Teacher Added Marks
  Widget _buildTeacherAddedMarksList() {
    return Consumer<MarksController>(
      builder: (context, value, child) {
        if (value.isloading) {
          return const Center(child: Loading(color: Colors.grey));
        }

        if (value.teacheraddedmarks.isEmpty) {
          return const Center(
            child: Text(
              "No marks added yet.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: value.teacheraddedmarks.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final mark = value.teacheraddedmarks[index];
            List<Color> subjectColors = [
              Colors.green,
              Colors.blue,
              Colors.red,
              Colors.orange,
              Colors.purple,
              Colors.teal,
              Colors.pink,
            ];
            final color = subjectColors[index % subjectColors.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: ActivityCard(
                title:
                    "${mark.classGrade ?? ""}th ${mark.section ?? ""} - ${capitalizeEachWord(mark.title ?? "")}",
                subject: mark.subject ?? "",
                section: mark.section ?? "",
                iconColor: color,
                icon: mark.classGrade ?? "",
                forMarks: true,
                text: DateFormatter.formatDateString(mark.date.toString()),
              ),
            );
          },
        );
      },
    );
  }

  // Reusable Custom Container
  Widget _customContainer({
    required Color color,
    required String text,
    IconData icon = Icons.dashboard_customize_outlined,
    required VoidCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Responsive.height * 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
              child: Icon(icon, color: Colors.white),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
