import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/reports/controller/student_report_controller.dart';

class StudentReport extends StatefulWidget {
  const StudentReport({Key? key}) : super(key: key);

  @override
  State<StudentReport> createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  late DropdownProvider dropdownprovider;

  @override
  void initState() {
    dropdownprovider = context.read<DropdownProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownprovider.clearSelectedItem('class');
      dropdownprovider.clearSelectedItem('division');

      context.read<StudentReportController>().clearStudentReportList();
      context.read<StudentReportController>().resetFilter();
      // super.dispose();
    });
    super.initState();

    context.read<StudentReportController>().getStudentReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              CustomAppbar(
                title: "Student Report",
                isBackButton: true,
                onTap: () {
                  context.pop();
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _buildClassDivisionStudentReport(context: context),
              ),
            ])));
  }

  Widget _buildClassDivisionStudentReport({required BuildContext context}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDropdown(
                dropdownKey: 'class',
                label: 'Class',
                items: ['5', '6', '7', '8', '9', '10'],
                icon: Icons.school,
                onChanged: (selectedClass) {
                  final selectedDivision = context
                      .read<DropdownProvider>()
                      .getSelectedItem('division');
                  context
                      .read<StudentReportController>()
                      .getStudentReportsByClassAndDivision(
                        className: selectedClass,
                        section: selectedDivision,
                      );
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CustomDropdown(
                dropdownKey: 'division',
                label: 'Division',
                items: ['A', 'B', 'C'],
                icon: Icons.group,
                onChanged: (selectedDivision) {
                  final selectedClass =
                      context.read<DropdownProvider>().getSelectedItem('class');
                  context
                      .read<StudentReportController>()
                      .getStudentReportsByClassAndDivision(
                        className: selectedClass,
                        section: selectedDivision,
                      );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<StudentReportController>(
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
                        'No filter applied. Please select a class and division.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              } else if (value.isFiltered &&
                  value.filteredstudentreports.isEmpty) {
                // Show message after filtering with no results
                return Center(
                  child: Text(
                    'No Reports Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Responsive.height * 4,
                          ),
                          // ListView.builder(
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   shrinkWrap: true,
                          //   padding: EdgeInsets.zero,
                          //   itemCount: value.filteredstudentreports.length,
                          //   itemBuilder: (context, index) {
                          //     final studentreport =
                          //         value.filteredstudentreports[index];
                          //     return Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 4),
                          //         child: ReportTile(
                          //           icon: Icons.assignment,
                          //           title: capitalizeFirstLetter(
                          //             studentreport.fullName ?? "",
                          //           ),
                          //           subtitle:
                          //               '${studentreport.studentReportClass ?? ""} ${studentreport.section ?? ""}',
                          //           onTap: () {},
                          //         ));
                          //   },
                          // )
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20), // Apply rounded corners to the entire table
                            child: DataTable(
                              headingRowColor:
                                  WidgetStatePropertyAll(Colors.grey.shade400),
                              border: TableBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Still needed for bottom corners
                              ),
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
                                    label: Text("Class",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Section",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Attendance",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Leaves",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Avg Marks",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Achievements",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: value.filteredstudentreports.map((student) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                        Text(student.studentId.toString())),
                                    DataCell(Text(capitalizeFirstLetter(
                                        student.fullName ?? ""))),
                                    DataCell(
                                        Text(student.studentReportClass ?? "")),
                                    DataCell(Text(student.section ?? "")),
                                    DataCell(Text(
                                        student.attendancePercentage ?? "")),
                                    DataCell(
                                        Text(student.leaveCount.toString())),
                                    DataCell(Text(student.marksAverage ?? "")),
                                    DataCell(Text(
                                        student.achievementsCount.toString())),
                                  ],
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
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
