import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/leave_request/widgets/leaveRequest_card.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';
import 'package:school_app/features/teacher/leave_request/controller/teacherLeaveReq_controller.dart';

class LeaverequestScreen extends StatefulWidget {
  @override
  _LeaverequestScreenState createState() => _LeaverequestScreenState();
}

class _LeaverequestScreenState extends State<LeaverequestScreen>
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
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Responsive.height * 2),
          CustomAppbar(
              title: "Leave Requests",
              isProfileIcon: false,
              onTap: () => context.goNamed(AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin)),
          Center(
            child: TabBar(
              labelPadding:
                  EdgeInsets.symmetric(horizontal: Responsive.width * 4),
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
              labelStyle: textThemeData.bodyMedium
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Students'),
                Tab(text: 'Teachers'),
              ],
            ),
          ),
          SizedBox(height: Responsive.height * 2),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStudentLeaveRequests(),
                _buildTeacherLeaveRequests(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Map<String, List<T>> groupItemsByDate<T>(
    List<T> items,
    DateTime Function(T) getDate, // Function to extract the date from the item
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

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

    // Sort grouped dates with "Today" and "Yesterday" on top.
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey('Today')) {
      sortedEntries.add(MapEntry('Today', groupedItems['Today']!));
      groupedItems.remove('Today');
    }
    if (groupedItems.containsKey('Yesterday')) {
      sortedEntries.add(MapEntry('Yesterday', groupedItems['Yesterday']!));
      groupedItems.remove('Yesterday');
    }

    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = DateFormat.yMMMMd().parse(a.key, true);
          final dateB = DateFormat.yMMMMd().parse(b.key, true);
          return dateB.compareTo(dateA); // Sort descending by date
        }),
    );

    return Map.fromEntries(sortedEntries);
  }

  Widget _buildStudentLeaveRequests() {
    context.read<StudentLeaveRequestController>().getStudentLeaveRequests();
    return Consumer<StudentLeaveRequestController>(
        builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: Loading(
            color: Colors.grey,
          ),
        );
      }
      final groupedStudentLeaveRequests = groupItemsByDateWithUpcoming(
        value.studentsLeaveRequest,
        (studentLeaveRequest) =>
            DateTime.tryParse(studentLeaveRequest.createdAt.toString()) ??
            DateTime.now(),
      );
      return value.studentsLeaveRequest.isEmpty
                    ? Center(
                        child: Text("No Achievements Found!"),
                      )
                    :  _buildGroupedList(groupedStudentLeaveRequests,
          (studentLeaveRequest, index, total) {
        final isFirst = index == 0;
        final isLast = index == total - 1;
        final topRadius = isFirst ? 16.0 : 0.0;
        final bottomRadius = isLast ? 16.0 : 0.0;
        return Padding(
            padding: EdgeInsets.only(
              bottom: 1.5,
            ),
            child: LeaveRequestCard(
              topRadius: topRadius,
              bottomRadius: bottomRadius,
              title:
                  'Leave request for ${DateFormatter.formatDateString(studentLeaveRequest.startDate.toString())}',
              status: studentLeaveRequest.approvalStatus ?? "",
              time: TimeFormatter.formatTimeFromString(
                  studentLeaveRequest.createdAt.toString()),
              onTap: () {
                context.pushNamed(
                  AppRouteConst.studentLeaveRequestDetailsRouteName,
                  extra: studentLeaveRequest,
                );
              },
            ));
      });
    });
  }

  Widget _buildTeacherLeaveRequests() {
    context.read<TeacherLeaveRequestController>().getTeacherLeaverequests();
    return Consumer<TeacherLeaveRequestController>(
        builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: Loading(
            color: Colors.grey,
          ),
        );
      }
      final groupedTeacherLeaveRequests = groupItemsByDateWithUpcoming(
        value.teachersLeaveRequest,
        (teacherLeaveRequest) =>
            DateTime.tryParse(teacherLeaveRequest.createdAt.toString()) ??
            DateTime.now(),
      );
      return value.teachersLeaveRequest.isEmpty
                    ? Center(
                        child: Text("No Achievements Found!"),
                      )
                    : _buildGroupedList(groupedTeacherLeaveRequests,
          (teacherLeaveRequest, index, total) {
        final isFirst = index == 0;
        final isLast = index == total - 1;
        final topRadius = isFirst ? 16.0 : 0.0;
        final bottomRadius = isLast ? 16.0 : 0.0;
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 1.5,
          ),
          child: LeaveRequestCard(
            topRadius: topRadius,
            bottomRadius: bottomRadius,
            title:
                'Leave request for ${DateFormatter.formatDateString(teacherLeaveRequest.startDate.toString())}',
            status: teacherLeaveRequest.approvalStatus ?? "",
            time: TimeFormatter.formatTimeFromString(
                teacherLeaveRequest.createdAt.toString()),
            onTap: () {
              context.pushNamed(
                AppRouteConst.teacherLeaveRequestDetailsRouteName,
                extra: {
                  'teacherLeaveRequest': teacherLeaveRequest,
                  'userType': 'admin'
                },
              );
            },
          ),
        );
      });
    });
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

extension DateOnlyCompare on DateTime {
  bool isAtSameMomentAs(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
