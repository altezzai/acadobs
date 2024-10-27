import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // Import for state management
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/teacher/attendance/model/attendance_data.dart';
import 'package:school_app/features/teacher/attendance/widgets/title_tile.dart';

class Attendance extends StatelessWidget {
  Attendance({Key? key}) : super(key: key);

  final Map<String, IconData> titleIconMap = {
    "Set Holiday": Icons.beach_access, // Holiday-related icon
    "Set All Present": Icons.check_circle, // Present icon
    "Set All Absent": Icons.cancel, // Absent icon
    "Set All Leave": Icons.airline_seat_flat_angled, // Leave icon
  };

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DropdownProvider(), // Instantiate the DropdownProvider
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        SizedBox(
                          height: Responsive.height * 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // First Dropdown: Select Class
                            Expanded(
                              child: CustomDropdown(
                                dropdownKey: 'class', // Unique key
                                icon: Icons.school,
                                label: "Select Class",
                                items: ["6", "7", "8", "9", "10"],
                              ),
                            ),
                            SizedBox(width: Responsive.width * 1),
                            // Second Dropdown: Select Period
                            Expanded(
                              child: CustomDropdown(
                                dropdownKey: 'period', // Unique key
                                icon: Icons.access_time,
                                label: "Select Division",
                                items: ["A", "B", "C", "D", "E"],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.height * 2),
                        // Date Picker: Select Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomDatePicker(
                                label: "Date",
                                dateController:
                                    _dateController, // Controller for date input
                                onDateSelected: (selectedDate) {
                                  print("Date selected: $selectedDate");
                                },
                              ),
                            ),
                            SizedBox(width: Responsive.width * 1),
                            // Another Dropdown: Select Student/Division/etc.
                            Expanded(
                              child: CustomDropdown(
                                dropdownKey: 'division', // Unique key
                                icon: Icons.group,
                                label: "Select Period",
                                items: [
                                  "1",
                                  "2",
                                  "3",
                                  "4",
                                  "5",
                                  "6",
                                  "7",
                                  "8",
                                  "9",
                                  "10"
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Responsive.height * 2),
                        // Title Tiles (Set Holiday, Set All Present, etc.)
                        Container(
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
                              IconData icon =
                                  titleIconMap.values.elementAt(index);
                              return TitleTile(
                                onTap: () {
                                  print("Tapped on $title");
                                },
                                title: title,
                                icon: icon,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: Responsive.height * 2),
                        const Text("Or"),
                        SizedBox(height: Responsive.height * 2),
                        TitleTile(
                          onTap: () {
                            context
                                .pushNamed(AppRouteConst.attendanceRouteName);
                          },
                          title: "Take Attendance",
                          icon: Icons.my_library_books_outlined,
                        ),
                        SizedBox(height: Responsive.height * 3),
                        CustomButton(
                          text: "Submit",
                          onPressed: () {
                            // Accessing selected dropdown values
                            String selectedClass = context
                                .read<DropdownProvider>()
                                .getSelectedItem('class');
                            String selectedPeriod = context
                                .read<DropdownProvider>()
                                .getSelectedItem('period');
                            String selectedDivision = context
                                .read<DropdownProvider>()
                                .getSelectedItem('division');
                            String selectedDate = _dateController
                                .text; // Access date from dateController

                            // Create an AttendanceData object
                            final attendanceData = AttendanceData(
                              selectedClass: selectedClass,
                              selectedPeriod: selectedPeriod,
                              selectedDivision: selectedDivision,
                              selectedDate: selectedDate,
                            );

                            // Push to attendanceRoute with extra data
                            context.pushNamed(
                              AppRouteConst.attendanceRouteName,
                              extra: attendanceData,
                            );
                          },
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
}
