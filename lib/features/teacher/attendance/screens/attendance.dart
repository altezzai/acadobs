import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, IconData> titleIconMap = {
    "Set Holiday": Icons.beach_access,
    "Set All Present": Icons.check_circle,
    "Set All Absent": Icons.cancel,
    "Set All Leave": Icons.airline_seat_flat_angled,
  };

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Use post-frame callback to clear dropdowns after widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dropdownProvider = context.read<DropdownProvider>();
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('period');
      dropdownProvider.clearSelectedItem('subject');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CustomAppbar(
                  title: "Attendance",
                  isBackButton: false,
                  isProfileIcon: false,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Responsive.height * 1),
                        Column(
                          children: [
                            _buildDropdownRow(),
                            SizedBox(height: Responsive.height * 2),
                            _buildDateAndPeriodRow(),
                            SizedBox(height: Responsive.height * 2),
                            Consumer<SubjectController>(
                              builder: (context, subjectProvider, child) {
                                return InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteConst.subjectSelectionRouteName,
                                      extra: _subjectController,
                                    );
                                  },
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: subjectProvider
                                                  .selectedSubjectId !=
                                              null
                                          ? subjectProvider.subjects
                                              .firstWhere((subject) =>
                                                  subject.id ==
                                                  subjectProvider
                                                      .selectedSubjectId)
                                              .subject // Fetch the selected subject name
                                          : "Select Subject", // Default hint text when no subject is selected
                                    ),
                                    enabled:
                                        false, // Prevent editing as it's controlled by selection
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        // SizedBox(height: Responsive.height * 2),
                        // TitleTile(
                        //     title: "Set All Present",
                        //     icon: Icons.group_outlined,
                        //     onTap: () {}),
                        // // _buildAttendanceOptions(),
                        // SizedBox(height: Responsive.height * 2),
                        // const Text("Or"),
                        // SizedBox(height: Responsive.height * 2),
                        // _buildTakeAttendanceTile(),
                        SizedBox(height: Responsive.height * 3),
                        Column(
                          children: [
                            // AddButton(
                            //   isSmallButton: false,
                            //   iconSize: 27,
                            //   iconPath: "assets/icons/check_attendance.png",
                            //   onPressed: () {
                            //      if (_formKey.currentState!.validate()) {
                            //       _navigateToNextPage(context,
                            //           AttendanceAction.checkAttendance);
                            //     }
                            //   },
                            //   text: "Check Attendance",
                            // ),
                            // SizedBox(height: Responsive.height * 1),
                            // AddButton(
                            //   isSmallButton: false,
                            //   iconPath: "assets/icons/all_present.png",
                            //   onPressed: () {
                            //     if (_formKey.currentState!.validate()) {
                            //       // context.read<AttendanceController>().markAllPresent();
                            //       _navigateToNextPage(context,
                            //           AttendanceAction.markAllPresent);
                            //     }
                            //   },
                            //   text: "Mark All Present",
                            // ),
                            // SizedBox(height: Responsive.height * 2),
                            // const Text("Or"),
                            SizedBox(height: Responsive.height * 1),
                            AddButton(
                              isSmallButton: false,
                              iconPath: "assets/icons/start_attendance.png",
                              iconSize: 30,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _navigateToNextPage(
                                      context, AttendanceAction.markAttendance);
                                }
                              },
                              text: " Mark Attendance",
                            ),
                          ],
                        ),

                        SizedBox(height: Responsive.height * 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomDropdown(
            dropdownKey: 'class',
            icon: Icons.school_outlined,
            label: "Select Class",
            items: ["6", "7", "8", "9", "10"],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a class";
              }
              return null;
            },
          ),
        ),
        SizedBox(width: Responsive.width * 1),
        Expanded(
          child: CustomDropdown(
            dropdownKey: 'division',
            icon: Icons.access_time,
            label: "Select Division",
            items: ["A", "B", "C", "D", "E"],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a division";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateAndPeriodRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomDatePicker(
            label: "Date",
            dateController: _dateController,
            onDateSelected: (selectedDate) {
              print("Date selected: $selectedDate");
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a date";
              }
              return null;
            },
          ),
        ),
        SizedBox(width: Responsive.width * 1),
        Expanded(
          child: CustomDropdown(
            dropdownKey: 'period',
            icon: Icons.group_outlined,
            label: "Select Period",
            items: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a period";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  void _navigateToNextPage(BuildContext context, AttendanceAction action) {
    String selectedClass =
        context.read<DropdownProvider>().getSelectedItem('class');
    String selectedPeriod =
        context.read<DropdownProvider>().getSelectedItem('period');
    String selectedDivision =
        context.read<DropdownProvider>().getSelectedItem('division');
    String selectedDate = _dateController.text;
    final selectedSubjectId =
        Provider.of<SubjectController>(context, listen: false)
            .selectedSubjectId;

    final attendanceData = AttendanceData(
        selectedClass: selectedClass,
        selectedPeriod: selectedPeriod,
        selectedDivision: selectedDivision,
        selectedDate: selectedDate,
        subject: selectedSubjectId ?? 0,
        action: action);

    context.read<AttendanceController>().takeAttendance(
          context,
          attendanceData: attendanceData,
        );
  }
}

enum AttendanceAction { checkAttendance, markAllPresent, markAttendance }
