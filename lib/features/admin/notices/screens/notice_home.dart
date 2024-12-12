import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/show_loading.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(
              title: "Notices and Events",
              isBackButton: false,
            ),
            Row(
              children: [
                Expanded(
                  child: AddButton(
                    iconPath: noticeIcon,
                    onPressed: () {
                      context.pushNamed(AppRouteConst.AddNoticeRouteName);
                    },
                    text: "Add Notice",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AddButton(
                    onPressed: () {
                      context.pushNamed(AppRouteConst.AddEventRouteName);
                    },
                    iconPath: eventIcon,
                    text: "Add Event",
                  ),
                ),
              ],
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
                  _buildNotices(),
                  _buildEvents(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Function to group items by date with sections for Upcoming and Tomorrow.
  Map<String, List<T>> groupItemsByDateWithUpcoming<T>(
    List<T> items,
    DateTime Function(T) getDate,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final upcomingThreshold = today.add(Duration(days: 7));

    Map<String, List<T>> groupedItems = {};
    Map<String, DateTime> dateKeys =
        {}; // To track the parsed date for each key

    for (var item in items) {
      final itemDate = getDate(item);
      String formattedDate;

      if (itemDate.isAtSameMomentAs(today)) {
        formattedDate = "Today";
      } else if (itemDate.isAtSameMomentAs(tomorrow)) {
        formattedDate = "Tomorrow";
      } else if (itemDate.isAfter(tomorrow) &&
          itemDate.isBefore(upcomingThreshold)) {
        formattedDate = "Upcoming";
      } else {
        formattedDate = DateFormatter.formatDateString(itemDate.toString());
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
        dateKeys[formattedDate] = itemDate; // Store the actual date
      }
      groupedItems[formattedDate]!.add(item);
    }

    // Sort grouped dates with "Today," "Tomorrow," and "Upcoming" on top, and others in descending order.
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey("Today")) {
      sortedEntries.add(MapEntry("Today", groupedItems["Today"]!));
      groupedItems.remove("Today");
    }
    if (groupedItems.containsKey("Tomorrow")) {
      sortedEntries.add(MapEntry("Tomorrow", groupedItems["Tomorrow"]!));
      groupedItems.remove("Tomorrow");
    }
    if (groupedItems.containsKey("Upcoming")) {
      sortedEntries.add(MapEntry("Upcoming", groupedItems["Upcoming"]!));
      groupedItems.remove("Upcoming");
    }

    // Sort the remaining entries by the actual date stored in `dateKeys`
    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = dateKeys[a.key]!;
          final dateB = dateKeys[b.key]!;
          return dateB.compareTo(dateA); // Descending order
        }),
    );

    return Map.fromEntries(sortedEntries);
  }

  Widget _buildNotices() {
    context.read<NoticeController>().getNotices();
    return Consumer<NoticeController>(builder: (context, value, child) {
      if (value.isloading) {
        return Loading(
          color: Colors.grey,
        );
      }

      final groupedNotices = groupItemsByDateWithUpcoming(
        value.notices,
        (notice) => DateTime.tryParse(notice.date.toString()) ?? DateTime.now(),
      );

      return _buildGroupedList(groupedNotices, (notice) {
        return NoticeItem(
          title: notice.title ?? "",
          date: notice.description ?? "",
          time: TimeFormatter.formatTimeFromString(notice.createdAt.toString()),
        );
      });
    });
  }

  Widget _buildEvents() {
    context.read<NoticeController>().getEvents();
    return Consumer<NoticeController>(builder: (context, value, child) {
      if (value.isloading) {
        return Loading(
          color: Colors.grey,
        );
      }

      final groupedEvents = groupItemsByDateWithUpcoming(
        value.events,
        (event) =>
            DateTime.tryParse(event.eventDate.toString()) ?? DateTime.now(),
      );

      return _buildGroupedList(groupedEvents, (event) {
        return EventItem(
          title: event.title ?? "",
          description: event.description ?? "",
          date: TimeFormatter.formatTimeFromString(event.createdAt.toString()),
          imagePath: 'assets/sports_day.png',
        );
      });
    });
  }

  Widget _buildGroupedList<T>(
      Map<String, List<T>> groupedItems, Widget Function(T) buildItem) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedItems.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(entry.key),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: entry.value.length,
                itemBuilder: (context, index) {
                  return buildItem(entry.value[index]);
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        date,
        style: textThemeData.bodyMedium,
      ),
    );
  }
}
