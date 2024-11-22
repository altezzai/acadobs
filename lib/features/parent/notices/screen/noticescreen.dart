import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
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
            context.pushReplacementNamed(
              AppRouteConst.ParentHomeRouteName,
            );
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
            // Categorize notices into latest and previous based on the date
            final today = DateTime.now();
            final latestNotices = controller.notices
                .where((notice) => DateTime.parse(notice.date.toString())
                    .isAfter(today.subtract(const Duration(days: 1))))
                .toList();

            final previousNotices = controller.notices
                .where((notice) => DateTime.parse(notice.date.toString())
                    .isBefore(today.subtract(const Duration(days: 1))))
                .toList();
            previousNotices.sort((a, b) => DateTime.parse(b.date.toString())
                .compareTo(DateTime.parse(a.date.toString())));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
