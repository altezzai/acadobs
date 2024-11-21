import 'package:flutter/material.dart';

import 'package:school_app/features/parent/leave_request/model/studentLeaveReq_model.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';
import 'package:school_app/base/utils/date_formatter.dart';

class StudentLeaveRequestDetailsPage extends StatefulWidget {
  final StudentLeaveRequest studentleaverequests;

  const StudentLeaveRequestDetailsPage({
    super.key,
    required this.studentleaverequests,
  });

  @override
  State<StudentLeaveRequestDetailsPage> createState() =>
      _StudentLeaveRequestDetailsPageState();
}

class _StudentLeaveRequestDetailsPageState
    extends State<StudentLeaveRequestDetailsPage> {
  @override
  void initState() {
    context.read<StudentLeaveRequestController>().getStudentLeaveRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 6),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomAppbar(
                title:
                    '      Leave request for ${DateFormatter.formatDateString(widget.studentleaverequests.startDate.toString())}',
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(
                    AppRouteConst.LeaveRequestScreenRouteName,
                  );
                },
              ),
              SizedBox(
                height: Responsive.height * .09,
              ),
              const ViewContainer(
                bcolor: Color(0xffCEFFD3),
                icolor: Color(0xff5DD168),
                icon: Icons.punch_clock_sharp,
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                'Leave request for ${DateFormatter.formatDateString(widget.studentleaverequests.startDate.toString())}',
                style: textThemeData.headlineLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'Student ID: ${widget.studentleaverequests.studentId ?? ""}',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'Reason for leave: ${widget.studentleaverequests.reasonForLeave ?? ""}',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'Start Date:${DateFormatter.formatDateString(widget.studentleaverequests.startDate.toString())}',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'End Date: ${DateFormatter.formatDateString(widget.studentleaverequests.endDate.toString())}',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    final leaveRequestId = widget.studentleaverequests
                        .id; // Replace with actual ID field
                    context
                        .read<StudentLeaveRequestController>()
                        .rejectLeaveRequest(context,
                            leaveRequestId!); // This will navigate back to the previous screen
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black, // Text color
                    side: BorderSide(color: Colors.black), // Black border
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25.0), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              CustomButton(
                text: 'Approve',
                onPressed: () {
                  final leaveRequestId = widget
                      .studentleaverequests.id; // Replace with actual ID field
                  context
                      .read<StudentLeaveRequestController>()
                      .approveLeaveRequest(context,
                          leaveRequestId!); // Your onPressed function here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
