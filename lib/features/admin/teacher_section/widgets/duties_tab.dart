import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class DutiesTab extends StatefulWidget {
  final int teacherId;

  const DutiesTab({Key? key, required this.teacherId}) : super(key: key);

  @override
  State<DutiesTab> createState() => _DutiesTabState();
}

class _DutiesTabState extends State<DutiesTab> {
  @override
  void initState() {
    super.initState();
    context
        .read<DutyController>()
        .getAdminTeacherDuties(teacherId: widget.teacherId);
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
    Map<String, DateTime> dateKeys = {};

    for (var item in items) {
      final itemDate =
          DateTime(getDate(item).year, getDate(item).month, getDate(item).day);
      String formattedDate;

      if (itemDate == today) {
        formattedDate = "Today";
      } else if (itemDate == yesterday) {
        formattedDate = "Yesterday";
      } else {
        formattedDate = DateFormat.yMMMMd().format(itemDate);
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
        dateKeys[formattedDate] = itemDate;
      }
      groupedItems[formattedDate]!.add(item);
    }

    // Sort grouped dates, prioritizing "Today" and "Yesterday"
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey("Today")) {
      sortedEntries.add(MapEntry("Today", groupedItems.remove("Today")!));
    }
    if (groupedItems.containsKey("Yesterday")) {
      sortedEntries
          .add(MapEntry("Yesterday", groupedItems.remove("Yesterday")!));
    }

    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = dateKeys[a.key]!;
          final dateB = dateKeys[b.key]!;
          return dateB.compareTo(dateA); // Sort by date descending
        }),
    );

    return Map.fromEntries(sortedEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<DutyController>(
        builder: (context, value, child) {
          if (value.isloading) {
            return Center(
              child: Loading(color: Colors.grey),
            );
          }

          // Group duties by date
          final groupedDuties = groupItemsByDate(
            value.teacherDuties,
            (duty) =>
                DateTime.tryParse(duty.createdAt.toString()) ?? DateTime.now(),
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: groupedDuties.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Header
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // List of duties
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: entry.value.length,
                      itemBuilder: (context, index) {
                        final duty = entry.value[index];
                        return WorkContainer(
                          bcolor: const Color(0xffCEFFD3),
                          icolor: Colors.white,
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
                   SizedBox(height: Responsive.height*2),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
