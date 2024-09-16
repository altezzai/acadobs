import 'package:flutter/material.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0), // Increase height of the AppBar
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color:
                  Colors.transparent, // Set a background color for your AppBar
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  'Hi,',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Vincent,',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: 20.0, top: 20.0), // Adjust padding for the avatar
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('assets/admin.png'),
              ),
            ),
          ],
          automaticallyImplyLeading: false, // Disable the back button
        ),
      ),
    );
  }
}
