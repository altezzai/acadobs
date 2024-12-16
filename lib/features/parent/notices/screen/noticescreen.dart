import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/parent/notices/widget/noticecard.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            context.pushNamed(AppRouteConst.bottomNavRouteName,
                extra: UserType.parent);
            // Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            'Notices',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
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
                const Text(
                  "Upcoming",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                upcomingNotices.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: upcomingNotices.length,
                        itemBuilder: (context, index) {
                          final notice = upcomingNotices[index];
                          return NoticeCard(
                            description: notice.description ?? "",
                            noticeTitle: notice.title ?? "",
                            date: DateFormatter.formatDateString(
                                notice.date.toString()),
                            time: TimeFormatter.formatTimeFromString(
                                notice.createdAt.toString()),
                            fileUpload: notice.fileUpload ?? "",
                          );
                        },
                      )
                    : const Text("No upcoming notices available."),
                const SizedBox(height: 20),

                // Latest Notices Section
                const Text(
                  "Latest",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                latestNotices.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: latestNotices.length,
                        itemBuilder: (context, index) {
                          final notice = latestNotices[index];
                          return NoticeCard(
                            description: notice.description ?? "",
                            noticeTitle: notice.title ?? "",
                            date: DateFormatter.formatDateString(
                                notice.date.toString()),
                            time: TimeFormatter.formatTimeFromString(
                                notice.createdAt.toString()),
                            fileUpload: notice.fileUpload ?? "",
                          );
                        },
                      )
                    : const Text("No latest notices available."),
                const SizedBox(height: 20),

                // Previous Notices Section
                const Text(
                  "Previous",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                previousNotices.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: previousNotices.length,
                        itemBuilder: (context, index) {
                          final notice = previousNotices[index];
                          return NoticeCard(
                            description: notice.description ?? "",
                            noticeTitle: notice.title ?? "",
                            date: DateFormatter.formatDateString(
                                notice.date.toString()),
                            time: TimeFormatter.formatTimeFromString(
                                notice.createdAt.toString()),
                            fileUpload: notice.fileUpload ?? "",
                          );
                        },
                      )
                    : const Text("No previous notices available."),
              ],
            );
          }),
        ),
      ),
    );
  }
}
