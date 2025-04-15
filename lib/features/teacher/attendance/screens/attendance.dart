import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
import 'package:school_app/features/admin/teacher_section/widgets/activity_tab.dart';
import 'package:school_app/features/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/utils/attendance_action.dart';


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
  final TextEditingController _dateControllerForList = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  late SubjectController subjectController;
  late TeacherController teacherController;
  late AttendanceController attendanceController;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _dateControllerForList.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    // Use post-frame callback to clear dropdowns after widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dropdownProvider = context.read<DropdownProvider>();
      subjectController = context.read<SubjectController>();
      teacherController = context.read<TeacherController>();
      attendanceController = context.read<AttendanceController>();
      teacherController.getTeacherActivities(
          teacherId: 0, //actually not needed
          forTeacherLogin: true,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()));
      attendanceController.getTeacherAttendanceRecords(
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()));
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('period');
      dropdownProvider.clearSelectedItem('subject');
      // subjectController.clearSubjects();
      subjectController.clearSelection();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ? capitalizeEachWord(subjectProvider
                                                  .subjects
                                                  .firstWhere((subject) =>
                                                      subject.id ==
                                                      subjectProvider
                                                          .selectedSubjectId)
                                                  .subject ??
                                              "") // Fetch the selected subject name
                                          : "Select Subject*", // Default hint text when no subject is selected
                                    ),
                                    enabled:
                                        false, // Prevent editing as it's controlled by selection
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.height * 3),
                        Column(
                          children: [
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
                        Consumer<AttendanceController>(
                          builder: (context, value, child) {
                            DateTime today = DateTime.now();
                            DateTime yesterday =
                                today.subtract(Duration(days: 1));
                            DateTime selectedDate =
                                _dateControllerForList.text.isNotEmpty
                                    ? DateFormat('yyyy-MM-dd')
                                        .parse(_dateControllerForList.text)
                                    : today;

                            String displayText = "";
                            if (selectedDate.year == today.year &&
                                selectedDate.month == today.month &&
                                selectedDate.day == today.day) {
                              displayText = "Today";
                            } else if (selectedDate.year == yesterday.year &&
                                selectedDate.month == yesterday.month &&
                                selectedDate.day == yesterday.day) {
                              displayText = "Yesterday";
                            }

                            return Row(
                              children: [
                                if (displayText.isNotEmpty)
                                  Text(
                                    displayText,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                SizedBox(width: Responsive.width * 24),
                                Expanded(
                                  child: CustomDatePicker(
                                    label: "Date",
                                    dateController: _dateControllerForList,
                                    onDateSelected: (selectedDate) {
                                      context
                                          .read<AttendanceController>()
                                          .getTeacherAttendanceRecords(
                                            date: DateFormat('yyyy-MM-dd')
                                                .format(selectedDate),
                                          );
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please select a date";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: Responsive.height * 2),
                        Consumer<AttendanceController>(
                            builder: (context, value, child) {
                          if (value.isloading) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: Responsive.height * 14,
                                ),
                                Loading(),
                              ],
                            );
                          }
                          if (value.attendanceRecord.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: Responsive.height * 14,
                                ),
                                Center(child: Text("No Activities Found")),
                              ],
                            ); // ✅ Now it returns
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: value.attendanceRecord.length,
                              itemBuilder: (context, index) {
                                List<Color> subjectColors = [
                                  Colors.green,
                                  Colors.blue,
                                  Colors.red,
                                  Colors.orange,
                                  Colors.purple,
                                  Colors.teal,
                                  Colors.pink,
                                ];
                                final attendanceRecord =
                                    value.attendanceRecord[index];
                                final color =
                                    subjectColors[index % subjectColors.length];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: InkWell(
                                    onTap: () {
                                      context.pushNamed(
                                          AppRouteConst
                                              .attendanceRecordRouteName,
                                          extra: AttendanceRecordArguments(
                                              forEditScreen: false,
                                              attendanceRecord:
                                                  attendanceRecord));
                                    },
                                    child: ActivityCard(
                                      title: attendanceRecord.classGrade ?? "",
                                      section: attendanceRecord.section ?? "",
                                      subject:
                                          attendanceRecord.subjectName ?? "",
                                      period: attendanceRecord.periodNumber!,
                                      iconColor: color,
                                      icon: attendanceRecord.classGrade ?? "",
                                    ),
                                  ),
                                );
                              });
                        })
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
            label: "Select Class*",
            items: AppConstants.classNames,
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
            label: "Select Division*",
            items: AppConstants.divisions,
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
            label: "Date*",
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
            label: "Select Period*",
            items: AppConstants.classPeriods,
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


