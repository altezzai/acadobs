import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
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
    final teacherReports =
        context.watch<TeacherReportController>().teacherreports; // Full list
    final filteredReports =
        context.watch<TeacherReportController>().filteredteacherreports; // Filtered list
    final isloading = context.watch<TeacherReportController>().isloading;

    final bool isFilterApplied = filteredReports.isNotEmpty;
    final List reportsToDisplay = isFilterApplied ? filteredReports : teacherReports;

    return Column(
      children: [
        CustomTextfield(
          iconData: const Icon(Icons.search),
          label: 'Search Teacher Name',
          controller: _teacherNameController,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomDatePicker(
                label: "Start Date",
                dateController: _startDateController,
                onDateSelected: (_) {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomDatePicker(
                label: "End Date",
                dateController: _endDateController,
                onDateSelected: (_) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final selectedTeacherName = _teacherNameController.text.trim();
            final selectedStartDate = _startDateController.text.trim();
            final selectedEndDate = _endDateController.text.trim();

            context.read<TeacherReportController>().getTeacherReportsByNameAndDate(
                  teacherName: selectedTeacherName,
                  startDate: selectedStartDate,
                  endDate: selectedEndDate,
                );
          },
          child: const Text('Filter Reports'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: isloading
              ? const Center(child: CircularProgressIndicator())
              : (reportsToDisplay.isEmpty && isFilterApplied)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/money.png',
                            height: Responsive.height * 0.45,
                          ),
                          const Text(
                            'No matching reports found.',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : (reportsToDisplay.isEmpty)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/money.png',
                                height: Responsive.height * 0.45,
                              ),
                              const Text(
                                'No reports found.',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: reportsToDisplay.length,
                          itemBuilder: (context, index) {
                            final report = reportsToDisplay[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.person_2),
                                title: Text(
                                  report.fullName ?? "N/A",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
        ),
      ],
    );
  }
}
