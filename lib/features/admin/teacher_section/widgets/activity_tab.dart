import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';

class ActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.height * 2),
            
            ActivityCard(
              subject: "Maths",
              period: "2",
              iconColor: Colors.green,
                title: "Classroom Activities",
                date: "15-06-24",
                time: "09:00 am"),
         
          
           
          ],
        ),
      ),
    );
  }
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

class ActivityCard extends StatelessWidget {
  final String title;
  final String date;
  final String? time;
  final String subject;
  final String period;
  final double bottomRadius;
  final double topRadius;
  final Color iconColor;
  


  const ActivityCard({
    required this.title,
    required this.date,
    this.time,
    required this.subject,
    required this.period,
     required this.iconColor,
    this.bottomRadius=10,
    this.topRadius=10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft:Radius.circular(bottomRadius),
         bottomRight: Radius.circular(bottomRadius),
              topLeft: Radius.circular(topRadius),
              topRight: Radius.circular(topRadius)
         ),
       
      ),
      child: Row(
        
        children: [
          Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.symmetric(horizontal: 6,vertical:2,),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle
            ),
            child: Padding(padding: EdgeInsets.all(4),
           child: Text(
            title,
            style: TextStyle(height: 22,
            color: iconColor),

           ),
          )),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalizeFirstLetter(title),
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
          
          Text(period, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
