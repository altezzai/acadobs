import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

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
                  child: CustomButton(
                    text: 'Add Notice',
                    onPressed: () {
                      context.pushNamed(AppRouteConst.AddNoticeRouteName);
                    },
                  ),
                ),
                SizedBox(
                  width: screenWidth > 600 ? 32 : 16,
                ),
                Expanded(
                  child: CustomButton(
                    text: 'Add Events',
                    onPressed: () {
                      context.pushNamed(AppRouteConst.AddEventRouteName);
                    },
                  ),
                ),
              ],
            ),
          ),
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
                _buildNoticesList(),
                _buildEventsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticesList() {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        _buildDivider('Today'),
        NoticeItem(
            title: 'PTA meeting class XII',
            date: '15 - 06 - 24',
            time: '09:00 am'),
        _buildDivider('Yesterday'),
        NoticeItem(
            title: 'PTA meeting class 09',
            date: '15 - 06 - 24',
            time: '09:00 am'),
        NoticeItem(
            title: 'PTA meeting class 02',
            date: '15 - 06 - 24',
            time: '09:00 am'),
      ],
    );
  }

  Widget _buildEventsList() {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        _buildDivider('Today'),
        EventItem(
          title: 'Sports day',
          description: 'National sports day will be conducted in our school...',
          date: '15 - 06 - 24',
          imagePath: 'assets/sports_day.png',
        ),
        _buildDivider('Yesterday'),
        EventItem(
          title: 'Cycle competition',
          description: 'Cycle race will be held on this day...',
          date: '15 - 06 - 24',
          imagePath: 'assets/cycle.png',
        ),
      ],
    );
  }

  Widget _buildDivider(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(text, style: TextStyle(color: Colors.grey)),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}
