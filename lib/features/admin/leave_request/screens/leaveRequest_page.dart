import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';

import 'package:school_app/base/utils/date_formatter.dart';
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
          Text(
            'Today',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: screenWidth * 0.05,
            ),
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
      return ListView.builder(
          itemCount: value.studentsLeaveRequest.length,
          itemBuilder: (context, index) {
            final studentLeaveRequest = value.studentsLeaveRequest[index];
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
      return ListView.builder(
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
          });
    });
  }
}
