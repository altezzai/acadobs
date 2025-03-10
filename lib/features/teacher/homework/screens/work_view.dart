import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/teacher/homework/controller/homework_controller.dart';
import 'package:school_app/features/teacher/homework/model/homework_model.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class WorkView extends StatefulWidget {
  final Homework work;
  WorkView({required this.work});

  @override
  State<WorkView> createState() => _WorkViewState();
}

class _WorkViewState extends State<WorkView> {
  late HomeworkController homeworkController;
  @override
  void initState() {
    super.initState();
    homeworkController = context.read<HomeworkController>(); // Initialize here
    homeworkController.getHomeworkStudent(
        homeworkId: widget.work.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Homework",
        isBackButton: true,
        actions: [
          Consumer<HomeworkController>(
            builder: (context, homeworkController, child) {
              return CustomPopupMenu(onEdit: () {
                context.pushNamed(AppRouteConst.editHomeworkRouteName,
                    extra: homeworkController.homeworkWithStudent);
              }, onDelete: () {
                showConfirmationDialog(
                    context: context,
                    title: "Delete Duty?",
                    content: "Are you sure you want to delete this duty?",
                    onConfirm: () {
                      homeworkController.deleteHomework(
                          context: context, homeworkId: widget.work.id ?? 0);
                    });
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height * 2,
              ),
              const ViewContainer(
                bcolor: Color(0xffFFFCCE),
                icolor: const Color(0xffBCB54F),
                icon: Icons.home_work_outlined,
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                widget.work.assignmentTitle ?? "",
                style: textThemeData.headlineLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                widget.work.description ?? "",
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assigned Date : ${DateFormatter.formatDateString(widget.work.assignedDate.toString())}',
                    style: textThemeData.bodySmall!.copyWith(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Due Date : ${DateFormatter.formatDateString(widget.work.dueDate.toString())}',
                    style: textThemeData.bodySmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subject : ${capitalizeEachWord(widget.work.subject ?? "")}',
                    style: textThemeData.bodySmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: Responsive.width * 23,
                  ),
                  Text(
                    'Total Marks : ${widget.work.totalMarks}',
                    style: textThemeData.bodySmall!.copyWith(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'Status : ${widget.work.status}',
                style: textThemeData.bodySmall!.copyWith(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                'Students Assigned: ',
                style: textThemeData.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Consumer<HomeworkController>(builder: (context, value, child) {
                final assignedStudents =
                    value.homeworkWithStudent.assignedStudents ?? [];
                if (assignedStudents.isEmpty) {
                  return Center(
                    child: Text("No students assigned"),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: assignedStudents.length,
                    // value.homeworkWithStudent.assignedStudents?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: ProfileTile(
                          name: value.homeworkWithStudent
                                  .assignedStudents?[index].fullName ??
                              "",
                          description:
                              '${value.homeworkWithStudent.assignedStudents?[index].assignedStudentClass ?? ""} ${value.homeworkWithStudent.assignedStudents?[index].section ?? ""}',
                          imageUrl:
                              "${baseUrl}${Urls.studentPhotos}${value.homeworkWithStudent.assignedStudents?[index].studentPhoto}",
                          suffixText:"",
                        ),
                      );
                    });
              }),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Container(
                padding: EdgeInsets.all(Responsive.width * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: Responsive.radius * 6,
                      backgroundColor: const Color(0xffF4F4F4),
                      child: const Icon(
                        Icons.fact_check_outlined,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width * 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRouteConst.markstarRouteName);
                      },
                      child: Text(
                        'Mark Homework',
                        style: textThemeData.bodyMedium!.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
