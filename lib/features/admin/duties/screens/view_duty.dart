import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class DutyView extends StatefulWidget {
  final DutyClass duties;

  const DutyView({
    super.key,
    required this.duties,
  });

  @override
  State<DutyView> createState() => _DutyViewState();
}

class _DutyViewState extends State<DutyView> {
  @override
  void initState() {
    context
        .read<DutyController>()
        .getAssignedDuties(dutyid: widget.duties.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 6),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomAppbar(
                title: widget.duties.dutyTitle ?? "",
                isProfileIcon: false,
                onTap: () {
                  context.pushNamed(AppRouteConst.bottomNavRouteName,
                      extra: UserType.admin);
                },
              ),
              SizedBox(
                height: Responsive.height * .09,
              ),
              const ViewContainer(
                bcolor: Color(0xffCEFFD3),
                icolor: Color(0xff5DD168),
                icon: Icons.workspace_premium,
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                widget.duties.dutyTitle ?? "",
                style: textThemeData.headlineLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                widget.duties.description ?? "",
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                'Teachers Assigned: ',
                style: textThemeData.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Consumer<DutyController>(builder: (context, value, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.assignedteachers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: CircleAvatar(
                            // backgroundImage: value
                            //             .assignedteachers[index].profilePhoto !=
                            //         null
                            //     ? NetworkImage(
                            //         value.assignedteachers[index].profilePhoto!)
                            //     : AssetImage('assets/student5.png')
                            //         as ImageProvider,
                            backgroundImage: NetworkImage(
                                value.assignedteachers[index].profilePhoto ??
                                    'assets/student5.png'),
                          ),
                          title: Text(
                              value.assignedteachers[index].fullName ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 16)),
                          subtitle: Text(
                              value.assignedteachers[index]
                                      .administrativeRoles ??
                                  "",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 15)),
                          // trailing: Text(value.assignedteachers[index].classGradeHandling?? "")
                        ),
                      );
                    });
              }),
              SizedBox(
                height: Responsive.height * 3,
              ),
              CommonButton(
                onPressed: () {},
                widget: Text('Mark as Completed'),
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
