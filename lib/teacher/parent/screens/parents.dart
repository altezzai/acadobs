import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/controller/dropdown_controller.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/global%20widgets/custom_dropdown.dart';
import 'package:school_app/teacher/data/dropdown_data.dart';
import 'package:school_app/teacher/parent/data/parent_data.dart';
import 'package:school_app/teacher/parent/widgets/parent_tile.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class ParentsScreen extends StatelessWidget {
  ParentsScreen({super.key});

  List<DropdownMenuItem<String>> allClasses = DropdownData.allClasses;
  List<DropdownMenuItem<String>> allDivisions = DropdownData.allDivisions;

  @override
  Widget build(BuildContext context) {
    final dropdownProvider = Provider.of<DropdownProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomAppbar(
              title: "Parents",
              onTap: () {
                context.pushReplacementNamed(AppRouteConst.homeRouteName);
              },
            ),
            CustomTextfield(
              hintText: "Search",
              iconData: Icon(Icons.search),
            ),
            SizedBox(
              height: Responsive.height * 1,
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
            SizedBox(
              height: Responsive.height * 2,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: parentStudentList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Responsive.height * 1),
                    child: ParentTile(
                        name: parentStudentList[index]['parentName']!,
                        studentName: parentStudentList[index]['studentName']!),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
