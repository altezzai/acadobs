import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/features/admin/reports/controller/teacher_report_controller.dart';

class TeacherReport extends StatefulWidget {
  const TeacherReport({Key? key}) : super(key: key);

  @override
  State<TeacherReport> createState() => _TeacherReportState();
}

class _TeacherReportState extends State<TeacherReport> {
  final TextEditingController _teacherNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _teacherNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeacherReportController>().clearTeacherReportList();
      context.read<TeacherReportController>().getTeacherReports();
      context.read<TeacherReportController>().resetFilter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
              title: "Teacher Report",
              isBackButton: true,
              onTap: () {
                context.pop();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildTeacherReportByNameAndDate(context: context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherReportByNameAndDate({required BuildContext context}) {
    return Column(
      children: [
        // CustomTextfield(
        //   iconData: const Icon(Icons.search),
        //   label: 'Search Teacher Name',
        //   controller: _teacherNameController,
        // ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomDatePicker(
                label: "Start Date",
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
                dateController: _startDateController,
                onDateSelected: (_) {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomDatePicker(
                label: "End Date",
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
                dateController: _endDateController,
                onDateSelected: (_) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // final selectedTeacherName = _teacherNameController.text.trim();
            final selectedStartDate = _startDateController.text.trim();
            final selectedEndDate = _endDateController.text.trim();

            context
                .read<TeacherReportController>()
                .getTeacherReportsByNameAndDate(
                  // teacherName: selectedTeacherName,
                  startDate: selectedStartDate,
                  endDate: selectedEndDate,
                );
          },
          child: const Text('Filter Reports'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Consumer<TeacherReportController>(
            builder: (context, value, child) {
              if (value.isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!value.isFiltered) {
                // Show image before filtering
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/money.png',
                        height: Responsive.height * 45,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No filter applied.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              } else if (value.isFiltered &&
                  value.filteredteacherreports.isEmpty) {
                // Show message after filtering with no results
                return Center(
                  child: Text(
                    'No Reports Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Responsive.height * 2,
                        ),
                        // ListView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   padding: EdgeInsets.zero,
                        //   itemCount: value.filteredteacherreports.length,
                        //   itemBuilder: (context, index) {
                        //     final teacherreport =
                        //         value.filteredteacherreports[index];
                        //     return Padding(
                        //         padding: const EdgeInsets.symmetric(vertical: 4),
                        //         child: ReportTile(
                        //           icon: Icons.assignment,
                        //           title: capitalizeFirstLetter(
                        //               teacherreport.fullName ?? ""),
                        //           // subtitle:
                        //           //     '${teacherreport.studentReportClass ?? ""} ${teacherreport.section ?? ""}',

                        //           onTap: () {},
                        //         ));
                        //   },
                        // )
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: DataTable(
                              headingRowColor:
                                  WidgetStatePropertyAll(Colors.grey.shade400),
                              border: TableBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Still needed for bottom corners
                              ),
                              columnSpacing: 30,
                              columns: [
                                DataColumn(
                                    label: Text("ID",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Attendance Recorded Count",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Leave Pending Count",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Leave Approved Count",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Leave Rejected Count",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Total Duties",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Completed Duties",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: value.filteredteacherreports.map((teacher) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                        Text(teacher.teacherId.toString())),
                                    DataCell(Text(capitalizeFirstLetter(
                                        teacher.fullName ?? ""))),
                                    DataCell(Center(
                                      child: Text(teacher
                                          .attendanceRecordedCount
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(
                                          teacher.leavePendingCount.toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(teacher.leaveApprovedCount
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(teacher.leaveRejectedCount
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                        child: Text(
                                            teacher.totalDuties.toString()))),
                                    DataCell(Center(
                                      child: Text(
                                          teacher.completedDuties.toString()),
                                    )),
                                  ],
                                );
                              }).toList()),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
