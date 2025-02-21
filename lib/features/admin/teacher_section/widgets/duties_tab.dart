import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/teacher_section/widgets/teacherDuty_tile.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: Responsive.height * 5),
        Consumer<DutyController>(
          builder: (context, value, child) {
            if (value.isloading) {
              return Expanded(
                child: const Center(
                  child: Loading(color: Colors.grey),
                ),
              );
            }

            // Group duties by date
            final groupedDuties = groupItemsByDate(
              value.teacherDuties,
              (duty) =>
                  DateTime.tryParse(duty.createdAt.toString()) ??
                  DateTime.now(),
            );

            return value.teacherDuties.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "No Duties Found!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : _buildGroupedList(groupedDuties, (duty, index, total) {
                    final isFirst = index == 0;
                    final isLast = index == total - 1;
                    final topRadius = isFirst ? 16.0 : 0.0;
                    final bottomRadius = isLast ? 16.0 : 0.0;

                    return TeacherdutyTile(
                      work: duty.dutyTitle ?? "",
                      sub: DateFormatter.formatDateString(
                          duty.createdAt.toString()),
                      status: duty.status ?? "",
                      topRadius: topRadius,
                      bottomRadius: bottomRadius,
                      onTap: () {
                        context.pushNamed(
                          AppRouteConst.AdminViewDutyRouteName,
                          extra: AdminDutyDetailArguments(
                              dutyId: duty.dutyId ?? 0,
                              userType: UserType.admin),
                        );
                      },
                    );
                  });
          },
        ),
      ],
    );
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
        // left: Responsive.width * 4
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
