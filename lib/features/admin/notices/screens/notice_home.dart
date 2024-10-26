import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/notices/widgets/event_item.dart';
import 'package:school_app/features/admin/notices/widgets/notice_item.dart';

class NoticeHomeScreen extends StatefulWidget {
  @override
  _NoticeHomeScreenState createState() => _NoticeHomeScreenState();
}

class _NoticeHomeScreenState extends State<NoticeHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: CustomAppbar(
              title: "Notices and Events",
              isBackButton: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: AddButton(
                      iconPath: noticeIcon,
                      onPressed: () {
                        context.pushNamed(AppRouteConst.AddNoticeRouteName);
                      },
                      text: "Add Notice"),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: AddButton(
                      onPressed: () {
                        context.pushNamed(AppRouteConst.AddEventRouteName);
                      },
                      iconPath: eventIcon,
                      text: "Add Event"),
                ),
              ],
            ),
          ),
          // Image.asset(
          //   noticeIcon,
          //   color: Colors.green,
          // ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Notices'),
              Tab(text: 'Events'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotices(),
                _buildEvents(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotices() {
    context.read<NoticeController>().getNotices();
    return Consumer<NoticeController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: value.notices.length,
          itemBuilder: (context, index) {
            final notice = value.notices[index];
            return NoticeItem(
                title: notice.title ?? "",
                date: DateFormatter.formatDateString(notice.date.toString()),
                time: "9.00 AM");
          });
    });
  }

  Widget _buildEvents() {
    context.read<NoticeController>().getEvents();
    return Consumer<NoticeController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: value.events.length,
          itemBuilder: (context, index) {
            final event = value.events[index];
            return EventItem(
              title: event.title ?? "",
              description: event.description ?? "",
              date: DateFormatter.formatDateString(event.eventDate.toString()),
              imagePath: 'assets/sports_day.png',
            );
          });
    });
  }
}
