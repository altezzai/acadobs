import 'package:flutter/material.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';

import 'package:school_app/features/teacher/leave_request/model/teacherLeaveReq_model.dart';
import 'package:school_app/features/teacher/leave_request/controller/teacherLeaveReq_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/features/admin/leave_request/widgets/leaveRequest_card.dart';

class TeacherLeaveRequestDetailsPage extends StatefulWidget {
  final TeacherLeaveRequest teacherleaverequests;

  const TeacherLeaveRequestDetailsPage({
    super.key,
    required this.teacherleaverequests,
  });

  @override
  State<TeacherLeaveRequestDetailsPage> createState() =>
      _StudentLeaveRequestDetailsPageState();
}

class _StudentLeaveRequestDetailsPageState
    extends State<TeacherLeaveRequestDetailsPage> {
  @override
  void initState() {
    context.read<TeacherLeaveRequestController>().getTeacherLeaverequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? status = widget.teacherleaverequests.approvalStatus;

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
                    '  Leave request for ${DateFormatter.formatDateString(widget.teacherleaverequests.startDate.toString())}',
                isProfileIcon: false,
                onTap: () {
                  context.pop();
                },
              ),
              SizedBox(
                height: Responsive.height * .09,
              ),
              ViewContainer(
                bcolor:
                    LeaveRequestCard.getStatusColor(status).withOpacity(0.2),
                icolor: LeaveRequestCard.getStatusColor(status),
                icon: status == "Approved"
                    ? Icons.verified
                    : (status == "Pending" ? Icons.access_time : Icons.cancel),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                'Leave request for ${DateFormatter.formatDateString(widget.teacherleaverequests.startDate.toString())}',
                style: textThemeData.headlineLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'Teacher ID: ${widget.teacherleaverequests.teacherId ?? ""}',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'Reason for leave: ${widget.teacherleaverequests.reasonForLeave ?? ""}',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'Start Date:${DateFormatter.formatDateString(widget.teacherleaverequests.startDate.toString())}',
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                'End Date: ${DateFormatter.formatDateString(widget.teacherleaverequests.endDate.toString())}',
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
                child: Consumer<TeacherLeaveRequestController>(
                    builder: (context, value, child) {
                  return OutlinedButton(
                    onPressed: () {
                      final leaveRequestId = widget.teacherleaverequests
                          .id; // Replace with actual ID field
                      context
                          .read<TeacherLeaveRequestController>()
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
                    child: value.isloading
                        ? ButtonLoading()
                        : Text(
                            'Cancel',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                          ),
                  );
                }),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),

              Consumer<TeacherLeaveRequestController>(
                  builder: (context, value, child) {
                return CommonButton(
                  onPressed: () {
                    final leaveRequestId = widget.teacherleaverequests
                        .id; // Replace with actual ID field
                    context
                        .read<TeacherLeaveRequestController>()
                        .approveLeaveRequest(context,
                            leaveRequestId!); // Your onPressed function here
                  },
                  widget: value.isloading ? ButtonLoading() : Text('Approve'),
                );
              })
// CustomButton(
//     text: 'Approve',
//     onPressed: () {
//        final leaveRequestId = widget.teacherleaverequests.id; // Replace with actual ID field
//     context.read<TeacherLeaveRequestController>().approveLeaveRequest(context, leaveRequestId!);// Your onPressed function here
//     },
//   ),
            ],
          ),
        ),
      ),
    );
  }
}
