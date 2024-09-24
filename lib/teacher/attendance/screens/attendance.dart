import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/controller/dropdown_controller.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/global%20widgets/custom_dropdown.dart';
import 'package:school_app/teacher/attendance/screens/take_attendance.dart';
import 'package:school_app/teacher/attendance/widgets/title_tile.dart';
import 'package:school_app/teacher/data/dropdown_data.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class Attendance extends StatelessWidget {
  Attendance({super.key});

  final Map<String, IconData> titleIconMap = {
    "Set Holiday": Icons.beach_access, // Holiday-related icon
    "Set All Present": Icons.check_circle, // Present icon
    "Set All Absent": Icons.cancel, // Absent icon
    "Set All Leave": Icons.airline_seat_flat_angled, // Leave icon
  };

  List<DropdownMenuItem<String>> allClasses = DropdownData.allClasses;
  List<DropdownMenuItem<String>> allDivisions = DropdownData.allDivisions;
  List<DropdownMenuItem<String>> periods = DropdownData.periods;

  @override
  Widget build(BuildContext context) {
    final dropdownProvider = Provider.of<DropdownProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const CustomAppbar(
                title: "Attendance",
                isBackButton: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      title: 'Select  Class',
                      icon: Icons.school,
                      items: allClasses,
                      selectedValue: dropdownProvider.selectedClass,
                      onChanged: (value) {
                        dropdownProvider.setSelectedClass(
                            value); // Update the state using provider
                      },
                    ),
                  ),
                  SizedBox(width: Responsive.width * 6),
                  Expanded(
                    child: CustomDropdown(
                      title: 'Select Division',
                      icon: Icons.school,
                      items: allDivisions,
                      selectedValue: dropdownProvider.selectedDivision,
                      onChanged: (value) {
                        dropdownProvider.setSelectedDivision(
                            value); // Update the state using provider
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 1),
              CustomTextfield(
                hintText: "dd/mm/yyyy",
                iconData: const Icon(Icons.calendar_month),
              ),
              SizedBox(height: Responsive.height * 1),
              CustomDropdown(
                title: 'Select Period',
                icon: Icons.book_outlined,
                items: periods,
                selectedValue: dropdownProvider.selectedPeriod,
                onChanged: (value) {
                  dropdownProvider.setSelectedPeriod(
                      value); // Update the state using provider
                },
              ),
              SizedBox(height: Responsive.height * 2),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: titleIconMap.length,
                    itemBuilder: (context, index) {
                      // Get the title and icon from the map
                      String title = titleIconMap.keys.elementAt(index);
                      IconData icon = titleIconMap.values.elementAt(index);
                      return TitleTile(
                        onTap: () {},
                        title: title,
                        icon: icon,
                      );
                    }),
              ),
              SizedBox(height: Responsive.height * 2),
              const Text("Or"),
              SizedBox(height: Responsive.height * 2),
              TitleTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TakeAttendance(),
                      ),
                    );
                  },
                  title: "Take Attendance",
                  icon: Icons.my_library_books_outlined),
              SizedBox(height: Responsive.height * 3),
              CustomButton(
                  text: "Submit",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => TakeAttendance()));
                  }),
              SizedBox(height: Responsive.height * 3),
            ],
          ),
        )),
      ),
    );
  }
}
