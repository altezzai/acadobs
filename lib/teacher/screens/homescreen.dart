import 'package:flutter/material.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            '',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0), // static padding
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/admin.png'),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
    );
  }
}
