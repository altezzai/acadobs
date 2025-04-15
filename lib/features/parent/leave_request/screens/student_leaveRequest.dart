import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';

class StudentLeaveRequestScreen extends StatefulWidget {
  final int studentId;
  final UserType userType; // Add userType parameter
  final VoidCallback onPressed;
  StudentLeaveRequestScreen(
      {super.key,
      required this.studentId,
      required this.userType, // Initialize userType
      required this.onPressed});

  @override
  State<StudentLeaveRequestScreen> createState() =>
      _StudentLeaveRequestScreenState();
}

class _StudentLeaveRequestScreenState extends State<StudentLeaveRequestScreen> {
  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
  }

  void _fetchLeaveRequests() async {
    final controller = context.read<StudentLeaveRequestController>();
    await controller.getIndividualStudentLeaveRequests(
      studentId: widget.studentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: widget.userType == UserType.admin
      //     ? null // Hide AppBar for admin
      //     : AppBar(
      //         leading: IconButton(
      //           icon: const Icon(Icons.chevron_left, color: Colors.black),
      //           onPressed: () {
      //             context.pushNamed(
      //               AppRouteConst.ParentHomeRouteName,
      //             );
      //           },
      //         ),
      //         title: const Center(
      //           child: Text(
      //             'My Leave Request',
      //             style: TextStyle(color: Colors.black),
      //           ),
      //         ),
      //         backgroundColor: Colors.white,
      //         elevation: 0,
      //         iconTheme: const IconThemeData(color: Colors.black),
      //       ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (widget.userType !=
            //     UserType.admin) // Show button only for non-admin
            //   ElevatedButton(
            //     onPressed: () {
            //       context.pushNamed(
            //         AppRouteConst.AddStudentLeaveRequestRouteName,
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.red,
            //       padding: EdgeInsets.symmetric(
            //         horizontal: MediaQuery.of(context).size.width * 0.25,
            //         vertical: MediaQuery.of(context).size.height * 0.025,
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     child: const Text(
            //       'Request for Leave',
            //       style: TextStyle(fontSize: 18, color: Colors.white),
            //     ),
            //   ),
            const SizedBox(height: 60),
            Expanded(
              child: Consumer<StudentLeaveRequestController>(
                builder: (context, value, child) {
                  return value.studentsIndividualLeaveRequest.isEmpty
                      ? Center(
                          child: Text(
                            "No Leave requests found",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              value.studentsIndividualLeaveRequest.length,
                          itemBuilder: (context, index) {
                            final leaveRequest =
                                value.studentsIndividualLeaveRequest[index];
                            return ListTile(
                              tileColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              leading: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      leaveRequest.approvalStatus == "Approved"
                                          ? Colors.green.withOpacity(.1)
                                          : (leaveRequest.approvalStatus ==
                                                  "Pending"
                                              ? Colors.orange.withOpacity(.1)
                                              : Colors.red.withOpacity(.1)),
                                ),
                                child: Icon(
                                  Icons.assignment_add,
                                  color:
                                      leaveRequest.approvalStatus == "Approved"
                                          ? Colors.green
                                          : (leaveRequest.approvalStatus ==
                                                  "Pending"
                                              ? Colors.orangeAccent
                                              : Colors.red),
                                ),
                              ),
                              title: Text(
                                leaveRequest.leaveType ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: leaveRequest.approvalStatus ==
                                            "Approved"
                                        ? Colors.green.withOpacity(.1)
                                        : (leaveRequest.approvalStatus ==
                                                "Pending"
                                            ? Colors.orange.withOpacity(.1)
                                            : Colors.blue.withOpacity(.1)),
                                  ),
                                  child: Text(
                                    leaveRequest.approvalStatus ?? "",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: leaveRequest.approvalStatus ==
                                              "Approved"
                                          ? Colors.green
                                          : (leaveRequest.approvalStatus ==
                                                  "Pending"
                                              ? Colors.orangeAccent
                                              : Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Text(
                                DateFormatter.formatDateString(
                                  leaveRequest.startDate.toString(),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: widget.userType == UserType.parent
          ? FloatingActionButton(
              onPressed: widget.onPressed,
              backgroundColor: Colors.black,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : SizedBox.shrink(),
    );
  }
}
