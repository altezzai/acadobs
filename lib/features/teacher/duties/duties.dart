import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class DutiesScreen extends StatefulWidget {
  const DutiesScreen({super.key});

  @override
  State<DutiesScreen> createState() => _DutiesScreenState();
}

class _DutiesScreenState extends State<DutiesScreen> {
  @override
  void initState() {
    context.read<DutyController>().getTeacherDuties();
    super.initState();
  }

  /// Group items by date (Today, Yesterday, Specific Dates)
  Map<String, List<T>> groupItemsByDate<T>(
    List<T> items,
    DateTime Function(T) getDate,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    Map<String, List<T>> groupedItems = {};

    for (var item in items) {
      final itemDate = getDate(item);
      String formattedDate;

      if (itemDate.isAtSameMomentAs(today)) {
        formattedDate = "Today";
      } else if (itemDate.isAtSameMomentAs(yesterday)) {
        formattedDate = "Yesterday";
      } else {
        formattedDate = DateFormat.yMMMMd().format(itemDate);
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
      }
      groupedItems[formattedDate]!.add(item);
    }

    // Sort grouped dates, with "Today" and "Yesterday" on top
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey("Today")) {
      sortedEntries.add(MapEntry("Today", groupedItems["Today"]!));
      groupedItems.remove("Today");
    }
    if (groupedItems.containsKey("Yesterday")) {
      sortedEntries.add(MapEntry("Yesterday", groupedItems["Yesterday"]!));
      groupedItems.remove("Yesterday");
    }
    sortedEntries.addAll(
        groupedItems.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));

    return Map.fromEntries(sortedEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            const CustomAppbar(
              title: "Duties",
              isBackButton: false,
              isProfileIcon: false,
            ),
            Consumer<DutyController>(
              builder: (context, value, child) {
                if (value.isloading) {
                  return Column(
                    children: [
                      SizedBox(
                        height: Responsive.height * 38,
                      ),
                      Loading(
                        color: Colors.grey,
                      ),
                    ],
                  );
                }

                // Group duties by date
                final groupedDuties = groupItemsByDate(
                  value.teacherDuties,
                  (duty) =>
                      DateTime.tryParse(duty.createdAt.toString()) ??
                      DateTime.now(),
                );

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: groupedDuties.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date Header (Today, Yesterday, Specific Date)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 13,
                              ),
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // List of duties under the date
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: entry.value.length,
                              itemBuilder: (context, index) {
                                final duty = entry.value[index];
                                return WorkContainer(
                                  bcolor: const Color(0xffCEFFD3),
                                  icolor: whiteColor,
                                  icon: Icons.done,
                                  work: duty.dutyTitle ?? "",
                                  sub: DateFormatter.formatDateString(
                                      duty.createdAt.toString()),
                                  prefixText: duty.status ?? "",
                                  prefixColor: Colors.red,
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteConst.dutiesRouteName,
                                      extra: DutyDetailArguments(
                                          dutyItem: duty, index: index),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isAtSameMomentAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
