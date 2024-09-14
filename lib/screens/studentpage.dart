import 'package:flutter/material.dart';

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
            Navigator.pop(context);
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
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for students',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.tune),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                DropdownButton<String>(
                  value: "XIII",
                  items: <String>['XIII', 'XII', 'XI', 'X'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {},
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
                    title: Text(students[index]['name']!),
                    subtitle: Text(students[index]['class']!),
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
          // Handle add new student
        },
        label: Text('Add New Student'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.grey,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.assignment),
      //       label: 'Duties',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.report),
      //       label: 'Reports',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notice',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.payment),
      //       label: 'Payments',
      //     ),
      //   ],
      // ),
    );
  }
}
