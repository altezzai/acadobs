import 'package:flutter/material.dart';
import 'package:school_app/features/parent/chat/screen/parentchatdetailedscreen.dart';
import 'package:school_app/features/parent/home/screen/homescreen.dart';

class ParentChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ParentHomeScreen()));
          },
        ),
        title: Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search for Teachers',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            // List of teachers
            Expanded(
              child: ListView(
                children: [
                  // Teacher 1
                  _buildTeacherTile(
                    context,
                    name: 'April Curtis',
                    subject: 'Maths',
                    imageUrl: 'assets/april.png',
                    notificationCount: 2,
                  ),
                  // Teacher 2
                  _buildTeacherTile(
                    context,
                    name: 'Dori Doreau',
                    subject: 'Science',
                    imageUrl: 'assets/dori.png',
                    notificationCount: 1,
                  ),
                  // Teacher 3
                  _buildTeacherTile(
                    context,
                    name: 'Angus MacGyver',
                    subject: 'English',
                    imageUrl: 'assets/angus.png',
                    notificationCount: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each teacher tile
  Widget _buildTeacherTile(BuildContext context,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              name: name,
              subject: subject,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
    );
  }
}
