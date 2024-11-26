import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/data/dropdown_data.dart';
import 'package:school_app/features/teacher/parent/data/parent_data.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';

// ignore: must_be_immutable
class ParentsScreen extends StatelessWidget {
  ParentsScreen({super.key});

  List<DropdownMenuItem<String>> allClasses = DropdownData.allClasses;
  List<DropdownMenuItem<String>> allDivisions = DropdownData.allDivisions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomAppbar(
                    title: "Parents",
                    isProfileIcon: false,
                    onTap: () {
                      context.goNamed(AppRouteConst.bottomNavRouteName,
                          extra: UserType.teacher);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0), // Adjust spacing as needed
                  child: IconButton(
                    icon: Icon(Icons.draw_sharp),
                    onPressed: () {
                      context.goNamed(AppRouteConst.NotesRouteName);
                    },
                    // Optional tooltip
                  ),
                ),
              ],
            ),

            CustomTextfield(
              hintText: "Search",
              iconData: Icon(Icons.search),
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: CustomDropdown(
            //           icon: Icons.school,
            //           label: "Select Class",
            //           items: ["1", "2", "3", "4", "5"]),
            //     ),
            //     // SizedBox(width: Responsive.width * 6),
            //     Expanded(
            //       child: CustomDropdown(
            //           icon: Icons.school,
            //           label: "Select Period",
            //           items: ["A", "B", "C", "D", "E"]),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: parentStudentList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Responsive.height * 1),
                    child: ProfileTile(
                        name: parentStudentList[index]['parentName']!,
                        icon: Icons.person_outline,
                        description: parentStudentList[index]['studentName']!),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
