import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/widgets/date_group_function.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class HomeworkList extends StatelessWidget {
  const HomeworkList({super.key});

  Widget build(BuildContext context) {
    return Consumer<StudentController>(builder: (context, value, child) {
      if (value.isloading) {
        return const Center(
            child: Loading(
          color: Colors.grey,
        ));
      }

      final groupedHomework = groupItemsByDate(
        value.homeworks,
        (homework) => DateTime.parse(homework.assignedDate.toString()),
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
              SizedBox(height: Responsive.height * 2),
              Text(
                dateGroup,
                style: textThemeData.bodyMedium,
              ),
              const SizedBox(height: 5),
              ...homeworks.map((homework) => WorkContainer(
                    sub: homework.subject ?? "",
                    work: homework.assignmentTitle ?? "",
                    icon: Icons.home_work_outlined,
                    onTap: () {
                      context.pushNamed(
                        AppRouteConst.AdminhomeworkDetailRouteName,
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
