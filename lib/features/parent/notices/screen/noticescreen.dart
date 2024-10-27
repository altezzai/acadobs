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
            // Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: const Text(
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today",
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
                "Yesterday",
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
                    return NoticeCard(
                        description: value.notices[index].description ?? "",
                        noticeTitle: value.notices[index].title ?? "",
                        date: DateFormatter.formatDateString(
                            value.notices[index].date.toString()),
                        time: TimeFormatter.formatTimeFromString(
                            value.notices[index].createdAt.toString()));
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
