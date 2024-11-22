import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/homework/controller/homework_controller.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';

class WorkScreen extends StatefulWidget {
  WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  @override
  void initState() {
    context.read<HomeworkController>().getHomework();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: 'Home Works',
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(
                    AppRouteConst.bottomNavRouteName,
                    extra: UserType.teacher,
                  );
                },
              ),
              Text(
                'Today',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              WorkContainer(
                work: 'Homework',
                sub: 'Maths',
                onTap: () {
                  context.pushReplacementNamed(AppRouteConst.workviewRouteName);
                },
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                'Yesterday',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Consumer<HomeworkController>(builder: (context, value, child) {
                if (value.isloading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.homework.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: WorkContainer(
                          // bcolor: workItem.backgroundColor,
                          // icolor: workItem.iconColor,
                          // icon: workItem.icon,
                          work:
                              value.homework[index].assignmentTitle.toString(),
                          sub: capitalizeFirstLetter(
                              value.homework[index].subject.toString())
                          // onTap: () => workItem.onTap(context),
                          ),
                    );
                  },
                );
              }),
              SizedBox(
                height: Responsive.height * 1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushReplacementNamed(AppRouteConst.addworkRouteName);
        },
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            '+',
            style: textThemeData.headlineLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
