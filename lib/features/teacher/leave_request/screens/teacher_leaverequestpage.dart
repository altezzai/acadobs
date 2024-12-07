import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';


import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/leave_request/widgets/leaveRequest_card.dart';

import 'package:school_app/features/teacher/leave_request/controller/teacherLeaveReq_controller.dart';


class TeacherLeaverequestScreen extends StatefulWidget {
  @override
  _TeacherLeaverequestScreenState createState() => _TeacherLeaverequestScreenState();
}

class _TeacherLeaverequestScreenState extends State<TeacherLeaverequestScreen>
   {
 


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
            // Custom AppBar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: CustomAppbar(
                title: "My Leave Requests",
                isProfileIcon: false,
                onTap: () => context.goNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.teacher,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            // Add Leave Request Button
            _customContainer(
              color: Colors.red,
              text: 'Requests For Leave',
              icon: Icons.assignment_add,
              ontap: () => context.pushNamed(AppRouteConst.AddTeacherLeaveRequestRouteName),
            ),
            SizedBox(height: screenHeight * 0.03),
            // Today's Leave Requests
            Text(
              'Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.05,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            // Leave Requests List
            Expanded(
              child:_buildTeacherLeaveRequests(),
            ),
          ],
        ),
      ),
    );
  }

  

  Widget _buildTeacherLeaveRequests() {
    context.read<TeacherLeaveRequestController>().getTeacherLeaverequests();
    return Consumer<TeacherLeaveRequestController>(
        builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: value.teachersLeaveRequest.length,
          itemBuilder: (context, index) {
            final teacherLeaveRequest = value.teachersLeaveRequest[index];
            return  Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,

                        ), child:LeaveRequestCard(
             title: 'Leave request for ${DateFormatter.formatDateString(teacherLeaveRequest.startDate.toString())}',

              
              status: teacherLeaveRequest.approvalStatus ?? "",
              time: TimeFormatter.formatTimeFromString(
                  teacherLeaveRequest.createdAt.toString()),
              onTap: () {
               context.pushNamed(
                  AppRouteConst.teacherLeaveRequestDetailsRouteName, extra: teacherLeaveRequest,
                  
                );
              },
            ));
    });
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
}
