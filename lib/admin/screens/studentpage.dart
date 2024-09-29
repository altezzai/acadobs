import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/admin/screens/newstudent.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';

class StudentsPage extends StatelessWidget {
  final List<Map<String, String>> students = [
    {"name": "Muhammad Rafasl N", "class": "XIII", "image": "student1.png"},
    {"name": "Livie Kenter", "class": "XIII", "image": "student2.png"},
    {"name": "Kaiya Siphron", "class": "XIII", "image": "student3.png"},
    {"name": "Abram Bator", "class": "XIII", "image": "student4.png"},
    {"name": "Allison Lipshulz", "class": "XIII", "image": "student5.png"},
    {"name": "Diana Lipshulz", "class": "XIII", "image": "student6.png"},
    {"name": "Justin Levin", "class": "XIII", "image": "student7.png"},
    {"name": "Miracle Bator", "class": "XIII", "image": "student1.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Students',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.pushReplacementNamed(AppRouteConst.homeRouteName);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/admin.png'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Adjust the width based on screen size
                Expanded(
                  flex: 3, // Allow more space for the search bar
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for students',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        suffixIcon: Icon(Icons.tune, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor:
                            Colors.grey.shade100, // Light background color
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Use Flexible to make sure dropdown adapts to available space
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButton<String>(
                      value: "V", // Set the initial value
                      underline: SizedBox(),
                      isExpanded: true, // Ensure dropdown uses available width
                      items: <String>[
                        'V',
                        'VI',
                        'VII',
                        'VIII',
                        'IX',
                        'X',
                        'XI',
                        'XII',
                        'XIII'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis, // Prevent overflow
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // Handle dropdown selection change
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/${students[index]['image']}'),
                    ),
                    title: Text(
                      students[index]['name']!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      overflow: TextOverflow
                          .ellipsis, // Ensure title does not overflow
                    ),
                    subtitle: Text(
                      students[index]['class']!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    trailing: TextButton(
                      child: Text('View'),
                      onPressed: () {
                        // Handle view button press
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentPage()),
          );
        },
        label: Text('Add New Student'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
