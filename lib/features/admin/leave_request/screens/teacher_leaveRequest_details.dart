import 'package:flutter/material.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
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
  final String userType;

  const TeacherLeaveRequestDetailsPage({
    super.key,
    required this.teacherleaverequests,
    required this.userType,
  });

  @override
  State<TeacherLeaveRequestDetailsPage> createState() =>
      _TeacherLeaveRequestDetailsPageState();
}

class _TeacherLeaveRequestDetailsPageState
    extends State<TeacherLeaveRequestDetailsPage> {
  @override
  void initState() {
    context.read<TeacherLeaveRequestController>().getTeacherLeaverequests();
    context.read<TeacherController>().getIndividualTeacherDetails(
        teacherId: widget.teacherleaverequests.teacherId ?? 0);
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
                    'Leave request for ${DateFormatter.formatDateString(widget.teacherleaverequests.startDate.toString())}',
                isProfileIcon: false,
                onTap: () {
                  context.pop();
                },
              ),
              SizedBox(
                height: Responsive.height * 0.09,
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
                height: Responsive.height * 2,
              ),
              Text(
                widget.teacherleaverequests.reasonForLeave ?? "",
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Consumer<TeacherController>(builder: (context, value, child) {
                return ProfileTile(
                  imageUrl:
                      "${baseUrl}${Urls.teacherPhotos}${value.individualTeacher?.profilePhoto}",
                  name: value.individualTeacher?.fullName ?? "",
                  description:
                      value.individualTeacher?.classGradeHandling ?? "",
                  onPressed: () {
                    context.pushNamed(
                        AppRouteConst.AdminteacherdetailsRouteName,
                        extra: value.individualTeacher!);
                  },
                );
              }),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                'Start Date: ${DateFormatter.formatDateString(widget.teacherleaverequests.startDate.toString())}',
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
              if (widget.userType == 'admin') ...[
                SizedBox(
                  width: double.infinity,
                  child: Consumer<TeacherLeaveRequestController>(
                    builder: (context, value, child) {
                      return OutlinedButton(
                        onPressed: () {
                          final leaveRequestId = widget.teacherleaverequests.id;
                          if (status != 'Rejected') {
                            context
                                .read<TeacherLeaveRequestController>()
                                .rejectLeaveRequest(context, leaveRequestId!);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: value.isloadingTwo
                            ? ButtonLoading()
                            : Text(
                                (status == 'Rejected') ? 'Rejected' : 'Reject',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: (status == 'Rejected')
                                          ? Colors.red
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                              ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Responsive.height * 3,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Consumer<TeacherLeaveRequestController>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: () {
                          final leaveRequestId = widget.teacherleaverequests.id;
                          if (status != 'Approved') {
                            context
                                .read<TeacherLeaveRequestController>()
                                .approveLeaveRequest(context, leaveRequestId!);
                          }
                        },
                        child: value.isloadingTwo
                            ? ButtonLoading()
                            : Text(
                                (status == 'Approved') ? 'Approved' : 'Approve',
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (status == 'Approved')
                              ? Colors.green
                              : Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Center(
                  child: Text(
                    'Current Status: $status',
                    style: textThemeData.bodyMedium,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
