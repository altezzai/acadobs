import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';

import 'package:school_app/features/parent/leave_request/model/studentLeaveReq_model.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/features/admin/leave_request/widgets/leaveRequest_card.dart';

class StudentLeaveRequestDetailsPage extends StatefulWidget {
  final StudentLeaveRequest studentleaverequests;
  final UserType userType;

  const StudentLeaveRequestDetailsPage({
    super.key,
    required this.studentleaverequests,
    required this.userType,
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
    context.read<StudentController>().getIndividualStudentDetails(
        studentId: widget.studentleaverequests.studentId ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? status = widget.studentleaverequests.approvalStatus;
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
                    'Leave request for ${DateFormatter.formatDateString(widget.studentleaverequests.startDate.toString())}',
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
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
                'Leave request for ${DateFormatter.formatDateString(widget.studentleaverequests.startDate.toString())}',
                style: textThemeData.headlineLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                widget.studentleaverequests.reasonForLeave ?? "",
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Consumer<StudentController>(builder: (context, value, child) {
                return ProfileTile(
                  imageUrl:
                      "${baseUrl}${Urls.studentPhotos}${value.individualStudent?.studentPhoto}",
                  name: value.individualStudent?.fullName ?? "",
                  description: value.individualStudent?.studentClass ?? "",
                  onPressed: () {
                    context.pushNamed(
                        AppRouteConst.AdminstudentdetailsRouteName,
                        extra: StudentDetailArguments(
                            student: value.individualStudent!,
                            userType: widget.userType));
                  },
                );
              }),
              SizedBox(
                height: Responsive.height * 2,
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
                child: Consumer<StudentLeaveRequestController>(
                    builder: (context, value, child) {
                  return OutlinedButton(
                    onPressed: () {
                      final leaveRequestId = widget.studentleaverequests
                          .id; // Replace with actual ID field
                      if (status != 'Rejected')
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
                    child: value.isloadingTwo
                        ? ButtonLoading()
                        : Text(
                            (status == 'Rejected') ? 'Rejected' : 'Reject',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: (status == 'Rejected')
                                          ? Colors.red
                                          : Colors.black,
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
              Consumer<StudentLeaveRequestController>(
                  builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    final leaveRequestId = widget.studentleaverequests
                        .id; // Replace with actual ID field
                    if (status != 'Approved')
                      context
                          .read<StudentLeaveRequestController>()
                          .approveLeaveRequest(context,
                              leaveRequestId!); // Your onPressed function here
                  },
                  child: value.isloadingTwo
                      ? ButtonLoading()
                      : Text(
                          (status == 'Approved') ? 'Approved' : 'Approve',
                        ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (status == 'Approved') ? Colors.green : Colors.black),
                );
              })
              // CustomButton(
              //   text: 'Approve',
              //   onPressed: () {
              //     final leaveRequestId = widget
              //         .studentleaverequests.id; // Replace with actual ID field
              //     context
              //         .read<StudentLeaveRequestController>()
              //         .approveLeaveRequest(context,
              //             leaveRequestId!); // Your onPressed function here
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
