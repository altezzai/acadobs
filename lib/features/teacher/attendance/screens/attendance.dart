import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/widgets/title_tile.dart';

class Attendance extends StatefulWidget {
  Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, IconData> titleIconMap = {
    "Set Holiday": Icons.beach_access,
    "Set All Present": Icons.check_circle,
    "Set All Absent": Icons.cancel,
    "Set All Leave": Icons.airline_seat_flat_angled,
  };
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Use post-frame callback to clear dropdowns after widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dropdownProvider = context.read<DropdownProvider>();
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('period');
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Responsive.height * 1),
                        _buildDropdownRow(),
                        SizedBox(height: Responsive.height * 2),
                        _buildDateAndPeriodRow(),
                        SizedBox(height: Responsive.height * 2),
                        TitleTile(
                            title: "Set All Students Present",
                            icon: Icons.school,
                            onTap: () {}),
                        // _buildAttendanceOptions(),
                        SizedBox(height: Responsive.height * 2),
                        const Text("Or"),
                        SizedBox(height: Responsive.height * 2),
                        _buildTakeAttendanceTile(),
                        SizedBox(height: Responsive.height * 3),
                        // CustomButton(
                        //   text: "Submit",
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       // Handle submission logic
                        //     }
                        //   },
                        // ),
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
            icon: Icons.school,
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
            icon: Icons.group,
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

  Widget _buildAttendanceOptions() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: titleIconMap.length,
        itemBuilder: (context, index) {
          String title = titleIconMap.keys.elementAt(index);
          IconData icon = titleIconMap.values.elementAt(index);
          return TitleTile(
            onTap: () {
              print("Tapped on $title");
            },
            title: title,
            icon: icon,
          );
        },
      ),
    );
  }

  Widget _buildTakeAttendanceTile() {
    return TitleTile(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          String selectedClass =
              context.read<DropdownProvider>().getSelectedItem('class');
          String selectedPeriod =
              context.read<DropdownProvider>().getSelectedItem('period');
          String selectedDivision =
              context.read<DropdownProvider>().getSelectedItem('division');
          String selectedDate = _dateController.text;

          final attendanceData = AttendanceData(
            selectedClass: selectedClass,
            selectedPeriod: selectedPeriod,
            selectedDivision: selectedDivision,
            selectedDate: selectedDate,
          );

          context.pushNamed(
            AppRouteConst.attendanceRouteName,
            extra: attendanceData,
          );
        }
      },
      title: "Take Attendance",
      icon: Icons.my_library_books_outlined,
    );
  }
}
