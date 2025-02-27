import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';

class ActivityTab extends StatefulWidget {
  final int teacherId;

  const ActivityTab({Key? key, required this.teacherId}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  @override
  void initState() {
    super.initState();
    context.read<TeacherController>().getTeacherActivities(
        teacherId: widget.teacherId,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()));
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
        Consumer<TeacherController>(
          builder: (context, value, child) {
            if (value.isloading) {
              return Expanded(
                child: const Center(
                  child: Loading(color: Colors.grey),
                ),
              );
            }
            List<Color> subjectColors = [
              Colors.green,
              Colors.blue,
              Colors.red,
              Colors.orange,
              Colors.purple,
              Colors.teal,
              Colors.pink,
            ];
            // Group Activity by date
            final groupedActivity = groupItemsByDate(
              value.activities,
              (activity) =>
                  DateTime.tryParse(activity.date.toString()) ?? DateTime.now(),
            );

            return value.activities.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "No Activity Found!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : _buildGroupedList(groupedActivity, (activity, index, total) {
                    final isFirst = index == 0;
                    final isLast = index == total - 1;
                    final topRadius = isFirst ? 16.0 : 0.0;
                    final bottomRadius = isLast ? 16.0 : 0.0;
                    final color = subjectColors[index % subjectColors.length];
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 1.5,
                      ),
                      child: ActivityCard(
                        title: activity.classGrade ?? "",
                        section: activity.section ?? "",
                        subject: activity.subjectName ?? "",
                        period: activity.periodNumber!,
                        iconColor: color,
                        icon: activity.classGrade ?? "",
                        // DateFormatter.formatDateString(
                        //     duty.createdAt.toString()),

                        topRadius: topRadius,
                        bottomRadius: bottomRadius,
                      ),
                    );
                  });
          },
        ),
      ],
    );
  }

  Widget _buildGroupedList<T>(Map<String, List<T>> groupedItems,
      Widget Function(T, int, int) buildItem) {
    return Expanded(
      child: SingleChildScrollView(
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

class ActivityCard extends StatelessWidget {
  final String title;
  final String? date;
  final String? time;
  final String subject;
  final int period;
  final double bottomRadius;
  final double topRadius;
  final Color iconColor;
  final String icon;
  final String section;

  const ActivityCard({
    required this.title,
    this.date,
    this.time,
    required this.subject,
    required this.period,
    required this.iconColor,
    required this.icon,
    required this.section,
    this.bottomRadius = 10,
    this.topRadius = 10,
  });
  String getOrdinal(int number) {
    if (number >= 11 && number <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomRadius),
            bottomRight: Radius.circular(bottomRadius),
            topLeft: Radius.circular(topRadius),
            topRight: Radius.circular(topRadius)),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center, // Ensure text stays in the center
            child: SizedBox(
              height: 22, // Fixed height for the icon text
              width: 20, // Fixed width for the icon text
              child: Center(
                child: Text(
                  icon, // Display classGrade inside the circle
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${getOrdinal(int.tryParse(title) ?? 0)} $section',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  capitalizeFirstLetter(subject),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),

          // children: [
          //   Icon(Icons.class_rounded, color: Colors.blue, size: 40),
          //   SizedBox(width: 10),
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          //       SizedBox(height: 4),
          //       Text(date,
          //           style: TextStyle(color: Colors.grey, fontSize: 13)),
          //     ],
          //   ),
          // ],

          Text('${getOrdinal(period)} Period',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
        ],
      ),
    );
  }
}
