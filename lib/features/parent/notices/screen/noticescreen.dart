import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
// import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';
// import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';

class NoticePage extends StatefulWidget {
  final bool forNavbar;
  const NoticePage({super.key, this.forNavbar = false});

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomAppbar(
                title: "Notices",
                isBackButton: widget.forNavbar,
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Consumer<NoticeController>(builder: (context, controller, child) {
                final today = DateTime.now();

                // Categorize notices into Upcoming, Latest, and Previous
                final upcomingNotices = controller.notices
                    .where((notice) =>
                        DateTime.parse(notice.date.toString()).isAfter(today))
                    .toList();

                final latestNotices = controller.notices
                    .where((notice) =>
                        DateTime.parse(notice.date.toString())
                            .isAfter(today.subtract(const Duration(days: 1))) &&
                        DateTime.parse(notice.date.toString()).isBefore(today))
                    .toList();

                final previousNotices = controller.notices
                    .where((notice) => DateTime.parse(notice.date.toString())
                        .isBefore(today.subtract(const Duration(days: 1))))
                    .toList();

                // Sort notices
                upcomingNotices.sort((a, b) => DateTime.parse(a.date.toString())
                    .compareTo(DateTime.parse(b.date.toString())));
                latestNotices.sort((a, b) => DateTime.parse(b.date.toString())
                    .compareTo(DateTime.parse(a.date.toString())));
                previousNotices.sort((a, b) => DateTime.parse(b.date.toString())
                    .compareTo(DateTime.parse(a.date.toString())));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming Notices Section
                    upcomingNotices.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              "Upcoming",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    // const SizedBox(height: 10),
                    upcomingNotices.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: upcomingNotices.length,
                            itemBuilder: (context, index) {
                              final isFirst = index == 0;
                              final isLast =
                                  index == upcomingNotices.length - 1;
                              final topRadius = isFirst ? 16 : 0;
                              final bottomRadius = isLast ? 16 : 0;
                              final notice = upcomingNotices[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 1.5),
                                child: DutyCard(
                                  bottomRadius: bottomRadius.toDouble(),
                                  topRadius: topRadius.toDouble(),
                                  title: notice.title ?? "",
                                  date: DateFormatter.formatDateString(
                                      notice.date.toString()),
                                  time: TimeFormatter.formatTimeFromString(
                                      notice.createdAt.toString()),
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteConst.NoticeDetailedPageRouteName,
                                      extra: NoticeDetailArguments(
                                          notice: notice,
                                          userType: UserType.parent),
                                    );
                                  },
                                  description: notice.description ?? "",
                                  //  fileUpload: notice.fileUpload ?? "",
                                ),
                              );
                            },
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: Responsive.height * 2),

                    // Latest Notices Section
                    latestNotices.isNotEmpty
                        ? const Text(
                            "Latest",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : SizedBox.shrink(),
                    const SizedBox(height: 10),
                    latestNotices.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: latestNotices.length,
                            itemBuilder: (context, index) {
                              final notice = latestNotices[index];
                              final isFirst = index == 0;
                              final isLast = index == latestNotices.length - 1;
                              final topRadius = isFirst ? 16 : 0;
                              final bottomRadius = isLast ? 16 : 0;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 1.5),
                                child: DutyCard(
                                  bottomRadius: bottomRadius.toDouble(),
                                  topRadius: topRadius.toDouble(),
                                  title: notice.title ?? "",
                                  date: DateFormatter.formatDateString(
                                      notice.date.toString()),
                                  time: TimeFormatter.formatTimeFromString(
                                      notice.createdAt.toString()),
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteConst.NoticeDetailedPageRouteName,
                                      extra: NoticeDetailArguments(
                                          notice: notice,
                                          userType: UserType.parent),
                                    );
                                  },
                                  description: notice.description ?? "",
                                  //  fileUpload: notice.fileUpload ?? "",
                                ),
                              );
                            },
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: Responsive.height * 2),

                    // Previous Notices Section
                    previousNotices.isNotEmpty
                        ? const Text(
                            "Previous",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : SizedBox.shrink(),
                    const SizedBox(height: 10),
                    previousNotices.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: previousNotices.length,
                            itemBuilder: (context, index) {
                              final notice = previousNotices[index];
                              final isFirst = index == 0;
                              final isLast =
                                  index == previousNotices.length - 1;
                              final topRadius = isFirst ? 16 : 0;
                              final bottomRadius = isLast ? 16 : 0;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 1.5),
                                child: DutyCard(
                                  bottomRadius: bottomRadius.toDouble(),
                                  topRadius: topRadius.toDouble(),
                                  title: notice.title ?? "",
                                  date: DateFormatter.formatDateString(
                                      notice.date.toString()),
                                  time: TimeFormatter.formatTimeFromString(
                                      notice.createdAt.toString()),
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteConst.NoticeDetailedPageRouteName,
                                      extra: NoticeDetailArguments(
                                          notice: notice,
                                          userType: UserType.parent),
                                    );
                                  },
                                  description: notice.description ?? "",
                                  //  fileUpload: notice.fileUpload ?? "",
                                ),
                              );
                            },
                          )
                        : SizedBox.shrink()
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
