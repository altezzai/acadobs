import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
        child: Column(
          children: [
            CustomAppbar(
              title: "Student Report",
              isBackButton: true,
              onTap: () {
                context.pop(              
                );
              },
            ),
           
            const SizedBox(height: 16),
            Expanded(
              child: _buildClassDivisionStudentReport(context: context),
            ),
          ]))
    );
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
                items: ['5', '6', '7','8','9','10'],
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
              } else if (value.filteredstudentreports.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/money.png',
                        height: Responsive.height * 45,
                      ),
                    ],
                  ),
                );
              }
                return SingleChildScrollView(
                    padding: EdgeInsets.zero, // Removes any default padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets
                              .zero,
                itemCount: value.filteredstudentreports.length,
                itemBuilder: (context, index) {
                  final studentreport = value.filteredstudentreports[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Card(
                      child: ListTile(
                        title:Text(studentreport.fullName??"",  style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) ,
                        subtitle:Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ Text(studentreport.studentReportClass ?? "",),
     Text(studentreport.section ?? "",) ])
                        
                      ),
                    )
                  );
                },
              )],),);
            },
          ),
        ),
      ],
    );
  }

}