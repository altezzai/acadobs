import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';


class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  void initState() {
    context.read<NoticeController>().getNotices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CustomAppbar(
              title: "Notices",
              isBackButton: true,
              isProfileIcon: false,
              onTap: () {
               context.pushReplacementNamed(
              AppRouteConst.ParentHomeRouteName,
            );
              },
             ),
              Text(
                "Latest",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // NoticeCard(
              //   noticeTitle: "PTA meeting class XII",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              // ),
              SizedBox(height: 20),

              // Yesterday Events Section
              Text(
                "Previous",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              Consumer<NoticeController>(builder: (context, value, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.notices.length,
                  itemBuilder: (context, index) {
                     final isFirst = index == 0;
        final isLast = index ==value.notices.length - 1;
        final topRadius = isFirst ? 16 : 0;
        final bottomRadius = isLast ? 16 : 0;
                          final notice = value.notices[index];
                    return  DutyCard(
             bottomRadius: bottomRadius.toDouble(),
             topRadius: topRadius.toDouble(),
            title: notice.title ?? "",
            date: DateFormatter.formatDateString(notice.date.toString()),
            time:
                TimeFormatter.formatTimeFromString(notice.createdAt.toString()),
            onTap: () {
              context.pushNamed(
                AppRouteConst.NoticeDetailedPageRouteName,
                extra: NoticeDetailArguments(
                    notice: notice, userType: UserType.parent),
              );
            },
            description: notice.description ?? "",
            fileUpload: notice.fileUpload ?? "",
          );
                  },
                );
              })
              // NoticeCard(
              //   noticeTitle: "PTA meeting class 09",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              // ),
              // NoticeCard(
              //   noticeTitle: "PTA meeting class 02",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              // ),
              // NoticeCard(
              //   noticeTitle: "PTA meeting class VII",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              // ),
              // NoticeCard(
              //   noticeTitle: "PTA meeting class X",
              //   date: "15 - 06 - 24",
              //   time: "09:00 am",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
