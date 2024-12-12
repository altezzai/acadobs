import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: CustomAppbar(
                title: "Leave Requests",
                isProfileIcon: false,
                onTap: () => context.goNamed(AppRouteConst.bottomNavRouteName,
                    extra: UserType.admin)),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Students'),
              Tab(text: 'Teachers'),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          
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
      final groupedLeaveRequests = groupItemsByDate(
        value.studentsLeaveRequest,
        (studentLeaveRequest) =>
            DateTime.tryParse(studentLeaveRequest.createdAt.toString()) ?? DateTime.now(),
      );
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: groupedLeaveRequests.entries.map((entry) {
          
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 1),
                _buildDateHeader(entry.key),
                SizedBox(height: Responsive.height * 1),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                    itemCount: entry.value.length,
                    itemBuilder: (context, index) {
                      final studentLeaveRequest = entry.value[index];
                      return Padding(
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: LeaveRequestCard(
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
                    }),
              ],
            );}
          ).toList(),
        ),
      );
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
       final groupedTeacherLeaveRequests = groupItemsByDate(
        value.teachersLeaveRequest,
        (teacherLeaveRequest) =>
            DateTime.tryParse(teacherLeaveRequest.createdAt.toString()) ?? DateTime.now(),
      );
      return SingleChildScrollView(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: groupedTeacherLeaveRequests.entries.map((entry) {
          
           return Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 1),
                _buildDateHeader(entry.key),
                SizedBox(height: Responsive.height * 1),
              
                 ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                    itemCount: value.teachersLeaveRequest.length,
                    itemBuilder: (context, index) {
                      final teacherLeaveRequest = value.teachersLeaveRequest[index];
                      return Padding(
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: LeaveRequestCard(
                            title:
                                'Leave request for ${DateFormatter.formatDateString(teacherLeaveRequest.startDate.toString())}',
                            status: teacherLeaveRequest.approvalStatus ?? "",
                            time: TimeFormatter.formatTimeFromString(
                                teacherLeaveRequest.createdAt.toString()),
                            onTap: () {
                              context.pushNamed(
                                AppRouteConst.teacherLeaveRequestDetailsRouteName,
                                extra: teacherLeaveRequest,
                              );
                            },
                          ));
          })]);
                    }
              
            ).toList(),
                  ),
          
        );
    });
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
