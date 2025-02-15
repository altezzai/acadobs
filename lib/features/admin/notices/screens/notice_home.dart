import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/parent/events/widget/eventcard.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        Orientation orientation = MediaQuery.of(context).orientation;
        Responsive().init(constraints, orientation);

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Responsive.height * 2),
                        CustomAppbar(
                          title: "Notices/Events",
                          isBackButton: false,
                          isProfileIcon: false,
                        ),
                        SizedBox(
                            height: Responsive.height * 2), // 20px equivalent
                        Row(
                          children: [
                            Expanded(
                              child: AddButton(
                                iconPath: noticeIcon,
                                onPressed: () {
                                  context.pushNamed(
                                      AppRouteConst.AddNoticeRouteName);
                                },
                                text: "Add Notice",
                              ),
                            ),
                            SizedBox(
                                width: Responsive.width * 4), // 16px equivalent
                            Expanded(
                              child: AddButton(
                                onPressed: () {
                                  context.pushNamed(
                                      AppRouteConst.AddEventRouteName);
                                },
                                iconPath: eventIcon,
                                text: "Add Event",
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: Responsive.height * 2),
                      ],
                    ),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: TabBar(
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: Responsive.width * 4),
                        dividerHeight: 3,
                        indicatorWeight: 3,
                        dividerColor: Colors.grey,
                        // indicatorPadding: EdgeInsets.symmetric(horizontal: 1),
                        tabAlignment: TabAlignment.center,
                        indicatorColor: Colors.black,
                        unselectedLabelColor: Color(0xFF757575),
                        unselectedLabelStyle: TextStyle(fontSize: 14),
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                        labelStyle: textThemeData.bodyMedium?.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: 'Notices'),
                          Tab(text: 'Events'),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.only(top: Responsive.height * 14),
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: _buildNotices(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildEvents(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // The rest of the code remains unchanged
  Map<String, List<T>> groupItemsByDateWithUpcoming<T>(
      List<T> items, DateTime Function(T) getDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final upcomingThreshold = today.add(Duration(days: 7));

    Map<String, List<T>> groupedItems = {};
    Map<String, DateTime> dateKeys = {};

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
        // formattedDate = DateFormatter.formatDateString(itemDate.toString());
        formattedDate = "Previous";
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
        dateKeys[formattedDate] = itemDate;
      }
      groupedItems[formattedDate]!.add(item);
    }

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

    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = dateKeys[a.key]!;
          final dateB = dateKeys[b.key]!;
          return dateB.compareTo(dateA);
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

      return _buildGroupedList(groupedNotices, (notice, index, total) {
        final isFirst = index == 0;
        final isLast = index == total - 1;
        final topRadius = isFirst ? 16 : 0;
        final bottomRadius = isLast ? 16 : 0;

        return Padding(
          padding: const EdgeInsets.only(bottom: 1.5),
          child: DutyCard(
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
                    notice: notice, userType: UserType.admin),
              );
            },
            description: notice.description ?? "",
            fileUpload: notice.fileUpload ?? "",
          ),
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

      return _buildGroupedList(groupedEvents, (event, index, total) {
        final isFirst = index == 0;
        final isLast = index == total - 1;
        final topRadius = isFirst ? 16 : 0;
        final bottomRadius = isLast ? 16 : 0;

        return Padding(
          padding: const EdgeInsets.only(bottom: 1.5),
          child: EventCard(
            onTap: () {
              context.pushNamed(
                AppRouteConst.EventDetailedPageRouteName,
                extra: EventDetailArguments(
                    event: event, userType: UserType.admin),
              );
            },
            bottomRadius: bottomRadius.toDouble(),
            topRadius: topRadius.toDouble(),
            eventTitle: event.title ?? "",
            eventDescription: event.description ?? "",
            date: DateFormatter.formatDateString(event.eventDate.toString()),
            time:
                TimeFormatter.formatTimeFromString(event.createdAt.toString()),
            imageProvider:
                "${baseUrl}${Urls.eventPhotos}${event.images![0].imagePath}",
          ),
        );
      });
    });
  }

  Widget _buildGroupedList<T>(Map<String, List<T>> groupedItems,
      Widget Function(T, int, int) buildItem) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedItems.entries.map((entry) {
          final itemCount = entry.value.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(entry.key),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return buildItem(entry.value[index], index, itemCount);
                },
              ),
              // SizedBox(
              //   height: Responsive.height * 2,
              // )
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.only(
        top: Responsive.height * 2, // 20px equivalent
        bottom: Responsive.height * 1, // 10px equivalent
      ),
      child: Text(
        date,
        style: textThemeData.bodyMedium?.copyWith(
          fontSize: 16, // Responsive font size
        ),
      ),
    );
  }
}
