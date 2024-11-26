import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';


class StudentLeaveRequestScreen extends StatefulWidget {
  StudentLeaveRequestScreen({super.key});

  @override
  State<StudentLeaveRequestScreen> createState() =>
      _StudentLeaveRequestScreenState();
}

class _StudentLeaveRequestScreenState extends State<StudentLeaveRequestScreen> {
  @override
  void initState() {
    context.read<StudentLeaveRequestController>().getStudentLeaveRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            context.pushReplacementNamed(
              AppRouteConst.ParentHomeRouteName,
            );
            // Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: const Text(
            'My Leave Request',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushReplacementNamed(
                    AppRouteConst.AddStudentLeaveRequestRouteName,
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25, //
                      vertical: MediaQuery.of(context).size.height * 0.025,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text(
                  'Request for Leave',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                leading: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.withOpacity(0.1)),
                    child: Icon(
                      Icons.assignment_add,
                      color: Colors.green,
                    )),
                title: Text(
                  "Leave Request 13-11-2024",
                  maxLines: 1, // Set max lines to 1 to keep it in a single line
                  overflow: TextOverflow
                      .ellipsis, // Show ellipsis (...) if the text overflows
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.045, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green.withOpacity(0.1)),
                        child: Text("Approved",
                            style: const TextStyle(color: Colors.green))),
                  ),
                ),
                trailing: Text("9:00 AM"),
              ),
              const SizedBox(height: 20),

              // Yesterday Events Section
              const Text(
                "Yesterday",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Consumer<StudentLeaveRequestController>(
                  builder: (context, value, child) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.studentsLeaveRequest.length,
                  itemBuilder: (context, index) {
                    final leaveRequest = value.studentsLeaveRequest[index];
                    return ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      leading: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: leaveRequest.approvalStatus == "Approved"
                              ? Colors.green.withOpacity(.1)
                              : (leaveRequest.approvalStatus == "Pending"
                                  ? Colors.red.withOpacity(.1)
                                  : Colors.blue.withOpacity(.1)),
                        ),
                        child: Icon(
                          Icons.assignment_add,
                          color: leaveRequest.approvalStatus == "Approved"
                              ? Colors.green
                              : (leaveRequest.approvalStatus == "Pending"
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                      ),
                      title: Text(
                        'Leave Request ${DateFormatter.formatDateString(
                          leaveRequest.startDate.toString(),
                        )}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: leaveRequest.approvalStatus == "Approved"
                                ? Colors.green.withOpacity(.1)
                                : (leaveRequest.approvalStatus == "Pending"
                                    ? Colors.red.withOpacity(.1)
                                    : Colors.blue.withOpacity(.1)),
                          ),
                          child: Text(
                            leaveRequest.approvalStatus ?? "",
                            style: TextStyle(
                              color: leaveRequest.approvalStatus == "Approved"
                                  ? Colors.green
                                  : (leaveRequest.approvalStatus == "Pending"
                                      ? Colors.red
                                      : Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      trailing: Text(
                        TimeFormatter.formatTimeFromString(
                          leaveRequest.createdAt.toString(),
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
