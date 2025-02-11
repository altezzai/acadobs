import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';

class DutiesHomeScreen extends StatefulWidget {
  @override
  _DutiesHomeScreenState createState() => _DutiesHomeScreenState();
}

class _DutiesHomeScreenState extends State<DutiesHomeScreen> {
  @override
  void initState() {
    
      context.read<DutyController>().getDuties();
    
    super.initState();
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
                      children: [
                        SizedBox(height: Responsive.height * 2),
                        CustomAppbar(
                          title: "Duties",
                          isBackButton: false,
                        ),
                        SizedBox(height: Responsive.height * 2),
                        Row(
                          children: [
                            Expanded(
                              child: AddButton(
                                iconPath: "assets/icons/add_duty.png",
                                onPressed: () {
                                  context.pushNamed(
                                      AppRouteConst.AdminAddDutyRouteName);
                                },
                                text: "Add Duty",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.only(top: Responsive.height * 4),
              child: Consumer<DutyController>(
                builder: (context, value, child) {
                  if (value.isloading) {
                    return Center(
                      child: Loading(color: Colors.grey),
                    );
                  }

                  final groupedDuties = groupItemsByDateWithUpcoming(
                    value.duties,
                    (duty) =>
                        DateTime.tryParse(duty.createdAt.toString()) ??
                        DateTime.now(),
                  );

                  return value.duties.isEmpty
                      ? Center(child: Text("No Duties Found!"))
                      : _buildGroupedList(groupedDuties, (duty, index, total) {
                          final isFirst = index == 0;
                          final isLast = index == total - 1;
                          final topRadius = isFirst ? 16 : 0;
                          final bottomRadius = isLast ? 16 : 0;

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 1.5,
                              left: 15,
                              right: 15,
                            ),
                            child: DutyCard(
                              bottomRadius: bottomRadius.toDouble(),
                              topRadius: topRadius.toDouble(),
                              title: duty.dutyTitle ?? "",
                              date: DateFormatter.formatDateString(
                                  duty.createdAt.toString()),
                              time: TimeFormatter.formatTimeFromString(
                                  duty.createdAt.toString()),
                              description: duty.description ?? "",
                              fileUpload: duty.fileAttachment ?? "",
                              onTap: () {
                                context.pushNamed(
                                    AppRouteConst.AdminViewDutyRouteName,
                                    extra: AdminDutyDetailArguments(
                                      duty: duty,
                                      userType: UserType.admin,
                                    ));
                              },
                            ),
                          );
                        });
                },
              ),
            ),
          ),
        );
      },
    );
  }

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

      // Strip the time components to focus on date comparisons
      final itemDateOnly =
          DateTime(itemDate.year, itemDate.month, itemDate.day);

      if (itemDateOnly.isAtSameMomentAs(today)) {
        formattedDate = "Today";
      } else if (itemDateOnly.isAtSameMomentAs(tomorrow)) {
        formattedDate = "Tomorrow";
      } else if (itemDateOnly.isAfter(tomorrow) &&
          itemDateOnly.isBefore(upcomingThreshold)) {
        formattedDate = "Upcoming";
      } else {
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

    // Sort the remaining entries (Previous) by date
    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = dateKeys[a.key]!;
          final dateB = dateKeys[b.key]!;
          return dateB.compareTo(dateA); // Sort descending (latest first)
        }),
    );

    return Map.fromEntries(sortedEntries);
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
          bottom: Responsive.height * 1.5, // 10px equivalent
          left: Responsive.width * 4),
      child: Text(
        date,
        style: textThemeData.bodyMedium?.copyWith(
          fontSize: 16, // Responsive font size
        ),
      ),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isAtSameMomentAs(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
