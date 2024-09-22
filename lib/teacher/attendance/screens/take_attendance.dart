import 'package:flutter/material.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/teacher/navbar/screens/bottom_navbar.dart';

class TakeAttendance extends StatelessWidget {
  TakeAttendance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomAppbar(
              title: "9th B",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BottomNavbar(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
