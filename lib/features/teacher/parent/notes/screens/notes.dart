import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';

import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';




import 'package:school_app/core/shared_widgets/custom_button.dart';


// ignore: must_be_immutable
class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomAppbar(
              title: "Notes",
              isProfileIcon: false,
              onTap:   () {
          context.goNamed(AppRouteConst.parentRouteName,
            );
        },
            ),
            CustomTextfield(
              hintText: "Search for parents",
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
            Expanded(
              child: ListView(
                children: [
                  // Teacher 1
                  _buildParentTile(
                    context,
                    name: 'April Curtis',
                    subject: 'Maths',
                    imageUrl: 'assets/april.png',
                    notificationCount: 2,
                  ),
                  // Teacher 2
                  _buildParentTile(
                    context,
                    name: 'Dori Doreau',
                    subject: 'Science',
                    imageUrl: 'assets/dori.png',
                    notificationCount: 1,
                  ),
                  // Teacher 3
                  _buildParentTile(
                    context,
                    name: 'Angus MacGyver',
                    subject: 'English',
                    imageUrl: 'assets/angus.png',
                    notificationCount: 0,
                  ),
                ],
              ),
            ), SizedBox(
              height: Responsive.height * 1,
            ),
                   CustomButton(
                    onPressed: () {
          context.goNamed(AppRouteConst.AddNoteRouteName);
        },
                    text: "Add New Note",
                  ), SizedBox(
              height: Responsive.height * 2,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildParentTile(BuildContext context,
      {required String name,
      required String subject,
      required String imageUrl,
      int notificationCount = 0}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
        radius: 24,
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subject),
      trailing: notificationCount > 0
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Text(
                '$notificationCount',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          : null,
      onTap: () {
       context.pushNamed(
                  AppRouteConst.NoteDetailsRouteName, 
                  
                );
      },
    );
  }
}
