import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/utils/attendance_action.dart';

void showAttendanceBottomSheet(BuildContext context) {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Set initial value to today's date
  dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late SubjectController subjectController;
  final dropdownProvider = context.read<DropdownProvider>();
  subjectController = context.read<SubjectController>();

  dropdownProvider.clearSelectedItem('class');
  dropdownProvider.clearSelectedItem('division');
  dropdownProvider.clearSelectedItem('period');
  dropdownProvider.clearSelectedItem('subject');
  // subjectController.clearSubjects();
  subjectController.clearSelection();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Title**
                Text(
                  "Mark Attendance",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),

                /// **Class Dropdown**
                CustomDropdown(
                  dropdownKey: 'class',
                  icon: Icons.school_outlined,
                  label: "Select Class*",
                  items: AppConstants.classNames,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please select a class"
                      : null,
                ),
                SizedBox(height: 12),

                /// **Division Dropdown**
                CustomDropdown(
                  dropdownKey: 'division',
                  icon: Icons.access_time,
                  label: "Select Division*",
                  items: AppConstants.divisions,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please select a division"
                      : null,
                ),
                SizedBox(height: 12),

                /// **Date Picker**
                CustomDatePicker(
                  label: "Date*",
                  dateController: dateController,
                  onDateSelected: (selectedDate) {
                    dateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? "Please select a date"
                      : null,
                ),
                SizedBox(height: 12),

                /// **Period Dropdown**
                CustomDropdown(
                  dropdownKey: 'period',
                  icon: Icons.group_outlined,
                  label: "Select Period*",
                  items: AppConstants.classPeriods,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please select a period"
                      : null,
                ),
                SizedBox(height: 12),

                /// **Subject Selection**
                // Consumer<SubjectController>(
                //   builder: (context, subjectProvider, child) {
                //     return InkWell(
                //       onTap: () {
                //         context.pushNamed(
                //           AppRouteConst.subjectSelectionRouteName,
                //           extra: _subjectController,
                //         );
                //       },
                //       child: TextFormField(
                //         decoration: InputDecoration(
                //           hintText: subjectProvider.selectedSubjectId != null
                //               ? capitalizeEachWord(subjectProvider.subjects
                //                       .firstWhere((subject) =>
                //                           subject.subjects?[0].subjectName ==
                //                           subjectProvider.selectedSubjectId)
                //                       .subjects?[0].id)
                //               : "Select Subject*",
                //         ),
                //         enabled: false, // Prevent manual editing
                //       ),
                //     );
                //   },
                // ),

                SizedBox(height: 16),

                /// **Mark Attendance Button**
                AddButton(
                  isSmallButton: false,
                  iconPath: "assets/icons/start_attendance.png",
                  iconSize: 30,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (dateController.text.isEmpty) {
                        print(" Error: Date is missing");
                        return;
                      }

                      _navigateToNextPage(context, dateController.text,
                          AttendanceAction.markAttendance);
                    }
                  },
                  text: "Mark Attendance",
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// **Function to Navigate to Next Page**
void _navigateToNextPage(
    BuildContext context, String selectedDate, AttendanceAction action) {
  //  Fetch selected values from DropdownProvider
  String selectedClass =
      context.read<DropdownProvider>().getSelectedItem('class');
  String selectedPeriod =
      context.read<DropdownProvider>().getSelectedItem('period');
  String selectedDivision =
      context.read<DropdownProvider>().getSelectedItem('division');

  // Get selected subject
  final selectedSubjectId =
      Provider.of<SubjectController>(context, listen: false).selectedSubjectId;

  //  Create AttendanceData object
  final attendanceData = AttendanceData(
    selectedClass: selectedClass,
    selectedPeriod: selectedPeriod,
    selectedDivision: selectedDivision,
    selectedDate: selectedDate,
    subject: selectedSubjectId ?? 0,
    action: action,
  );

  // ✅ Submit attendance
  context
      .read<AttendanceController>()
      .takeAttendance(context, attendanceData: attendanceData);
}
