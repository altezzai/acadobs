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
import 'package:school_app/features/teacher/leave_request/controller/teacherLeaveReq_controller.dart';

class TeacherLeaverequestScreen extends StatefulWidget {
  @override
  _TeacherLeaverequestScreenState createState() =>
      _TeacherLeaverequestScreenState();
}

class _TeacherLeaverequestScreenState extends State<TeacherLeaverequestScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            // Custom AppBar
            CustomAppbar(
              title: "My Leave Requests",
              isProfileIcon: false,
              onTap: () => context.goNamed(
                AppRouteConst.bottomNavRouteName,
                extra: UserType.teacher,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            // Add Leave Request Button
            _customContainer(
              color: Colors.red,
              text: 'Requests For Leave',
              icon: Icons.assignment_add,
              ontap: () => context
                  .pushNamed(AppRouteConst.AddTeacherLeaveRequestRouteName),
            ),
            // Today's Leave Requests

            SizedBox(height: screenHeight * 0.03),
            // Leave Requests List
            Expanded(
              child: _buildTeacherLeaveRequests(),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<T>> groupItemsByDate<T>(
    List<T> items,
    DateTime Function(T) getDate, // Function to extract the date from the item
  ) {
    final now = DateTime.now();
    final today =
        DateTime(now.year, now.month, now.day); // Strip time component
    final yesterday = today.subtract(Duration(days: 1));

    Map<String, List<T>> groupedItems = {};

    for (var item in items) {
      final itemDate = getDate(item);
      final itemDateOnly = DateTime(
          itemDate.year, itemDate.month, itemDate.day); // Strip time component
      String formattedDate;

      if (itemDateOnly == today) {
        formattedDate = "Today";
      } else if (itemDateOnly == yesterday) {
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
        groupedItems.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));

    return Map.fromEntries(sortedEntries);
  }

  Widget _buildTeacherLeaveRequests() {
    context
        .read<TeacherLeaveRequestController>()
        .getIndividualTeacherLeaverequests();
    return Consumer<TeacherLeaveRequestController>(
        builder: (context, value, child) {
      if (value.isloading) {
        return Column(
          children: [
            SizedBox(
              height: Responsive.height * 25,
            ),
            Loading(
              color: Colors.grey,
            ),
          ],
        );
      }
      final groupedTeacherLeaveRequests = groupItemsByDate(
        value.teacherIndividualLeaveRequest,
        (teacherLeaveRequest) =>
            DateTime.tryParse(teacherLeaveRequest.createdAt.toString()) ??
            DateTime.now(),
      );

      return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: groupedTeacherLeaveRequests.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: Responsive.height * 1),
                  _buildDateHeader(entry.key),
                  SizedBox(height: Responsive.height * 1),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: entry.value.length, // Use grouped items here
                      itemBuilder: (context, index) {
                        final teacherLeaveRequest = entry.value[index];
                        return Padding(
                            padding: EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: LeaveRequestCard(
                              title: teacherLeaveRequest.leaveType ?? "",
                              status: teacherLeaveRequest.approvalStatus ?? "",
                              time: DateFormatter.formatDateString(
                                teacherLeaveRequest.startDate.toString(),
                              ),
                              onTap: () {
                                context.pushNamed(
                                  AppRouteConst
                                      .teacherLeaveRequestDetailsRouteName,
                                  extra: {
                                    'teacherLeaveRequest': teacherLeaveRequest,
                                    'userType': 'teacher'
                                  },
                                );
                              },
                            ));
                      }),
                ],
              );
            }).toList()),
      );
    });
  }

  Widget _customContainer({
    required Color color,
    required String text,
    IconData icon = Icons.dashboard_customize_outlined,
    required VoidCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Responsive.height * 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Text(date, style: textThemeData.bodyMedium),
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
