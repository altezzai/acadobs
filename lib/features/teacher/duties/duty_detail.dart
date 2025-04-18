import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/duties/model/teacherDuty_model.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class DutyDetailScreen extends StatefulWidget {
  final DutyItem teacherDuty;
  final int index;
  DutyDetailScreen({required this.teacherDuty, required this.index});

  @override
  State<DutyDetailScreen> createState() => _DutyDetailScreenState();
}

class _DutyDetailScreenState extends State<DutyDetailScreen> {
  late DutyController dutyController;
  @override
  void initState() {
    dutyController = context.read<DutyController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dutyController.getTeacherSingleDuty(
          dutyId: widget.teacherDuty.dutyId ?? 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<DutyController>(builder: (context, value, child) {
            return value.isloading
                ? Column(
                    children: [
                      SizedBox(
                        height: Responsive.height * 50,
                      ),
                      Loading(
                        color: Colors.grey,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Responsive.height * 2,
                      ),
                      CustomAppbar(
                        title: widget.teacherDuty.dutyTitle ?? "",
                        isProfileIcon: false,
                        onTap: () {
                          context.pushNamed(AppRouteConst.bottomNavRouteName,
                              extra: UserType.teacher);
                        },
                      ),
                      const ViewContainer(
                        bcolor: Color(0xffCEFFD3),
                        icolor: Color(0xff5DD168),
                        icon: Icons.class_,
                      ),
                      SizedBox(
                        height: Responsive.height * 3,
                      ),
                      Text(
                        widget.teacherDuty.dutyTitle ?? "",
                        style: textThemeData.headlineLarge!.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: Responsive.height * 1,
                      ),
                      Text(
                        widget.teacherDuty.description ?? "",
                        style: textThemeData.bodySmall!.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: Responsive.height * 3),
                      Text(value.singleTeacherDuty['status'],
                          style: textThemeData.bodyMedium),
                      SizedBox(height: Responsive.height * 6),
                      Consumer<DutyController>(
                        builder: (context, value, child) {
                          final dutyStatus = value.singleTeacherDuty['status'];
                          return Column(
                            children: [
                              if (dutyStatus != 'InProgress' &&
                                  dutyStatus != 'Completed')
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.orange,
                                  ),
                                  onPressed: () {
                                    context.read<DutyController>().progressDuty(
                                          context,
                                          duty_id: widget.teacherDuty.id ?? 0,
                                        );
                                  },
                                  child: Text(
                                    "In Progress",
                                    style: textThemeData.bodyMedium!.copyWith(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: Responsive.height * 1,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff14601C),
                                ),
                                onPressed: () {
                                  context.read<DutyController>().completeDuty(
                                        context,
                                        duty_id: widget.teacherDuty.id ?? 0,
                                      );
                                },
                                child: Text(
                                  dutyStatus == 'Completed'
                                      ? "Duty Completed"
                                      : "Mark as Completed",
                                  style: textThemeData.bodyMedium!.copyWith(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
