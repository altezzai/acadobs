import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class DutiesScreen extends StatefulWidget {
  const DutiesScreen({super.key});

  @override
  State<DutiesScreen> createState() => _DutiesScreenState();
}

class _DutiesScreenState extends State<DutiesScreen> {
  @override
  void initState() {
    context.read<DutyController>().getDuties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(
            title: "Duties",
            isBackButton: false,
          ),
          // SizedBox(height: Responsive.height * 2),
          Text(
            'Today',
            style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
          ),
          SizedBox(
            height: Responsive.height * 2,
          ),
          WorkContainer(
            bcolor: const Color(0xffCEFFD3),
            icolor: const Color(0xff5DD168),
            icon: Icons.class_,
            work: '12th Class',
            sub: 'Maths',
            onTap: () {
              context.pushNamed(AppRouteConst.dutiesRouteName);
            },
          ),
          SizedBox(height: Responsive.height * 2),
          Text(
            'Ongoing',
            style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
          ),
          SizedBox(
            height: Responsive.height * 2,
          ),
          const WorkContainer(
            bcolor: Color(0xffCEFFD3),
            icolor: Color(0xff5DD168),
            icon: Icons.class_,
            work: '12th Class',
            sub: 'Maths',
            prefixText: "Ongoing",
            prefixColor: Color(0xFFD68400),
          ),
          SizedBox(height: Responsive.height * 2),
          Text(
            'Yesterday',
            style: textThemeData.bodyMedium!.copyWith(fontSize: 17),
          ),

          Consumer<DutyController>(builder: (context, value, child) {
            if (value.isloading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.duties.length,
              itemBuilder: (context, index) {
                return WorkContainer(
                  bcolor: Color(0xffCEFFD3),
                  icolor: whiteColor,
                  icon: Icons.done,
                  work: value.duties[index].dutyTitle ?? "",
                  sub: DateFormatter.formatDateString(
                      value.duties[index].createdAt.toString()),
                  prefixText: value.duties[index].status ?? "",
                  prefixColor: Colors.red,
                  onTap: () {
                    context.pushNamed(AppRouteConst.dutiesRouteName);
                  },
                );
              },
            );
          }),
          SizedBox(
            height: Responsive.height * 1,
          ),
          // const WorkContainer(
          //   bcolor: Color(0xffFF7E7E),
          //   icolor: Colors.red,
          //   icon: Icons.stop_screen_share,
          //   work: 'Homework',
          //   sub: 'Maths',
          //   prefixText: "Not Attended",
          //   prefixColor: Colors.red,
          // ),
        ],
      ),
    ));
  }
}
