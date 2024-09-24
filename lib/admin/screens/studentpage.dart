import 'package:flutter/material.dart';
import 'package:school_app/admin/screens/newstudent.dart';
import 'package:school_app/admin/screens/studentdetails.dart';

class StudentsPage extends StatefulWidget {
  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
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

  List<Map<String, String>> filteredStudents = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredStudents = students; // Initialize with all students
  }

  void _filterStudents(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredStudents = students; // Reset to all students
      });
    } else {
      setState(() {
        filteredStudents = students
            .where((student) =>
                student['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

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
                  flex: 3,
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                      _filterStudents(searchQuery);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for students',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButton<String>(
                      value: "V",
                      underline: SizedBox(),
                      isExpanded: true,
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
                            overflow: TextOverflow.ellipsis,
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
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailPage(
                            name: filteredStudents[index]['name']!,
                            studentClass: filteredStudents[index]['class']!,
                            image: filteredStudents[index]['image']!,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/${filteredStudents[index]['image']}'),
                      ),
                      title: Text(
                        filteredStudents[index]['name']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        filteredStudents[index]['class']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      trailing: TextButton(
                        child: Text(
                          'View',
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDetailPage(
                                name: filteredStudents[index]['name']!,
                                studentClass: filteredStudents[index]['class']!,
                                image: filteredStudents[index]['image']!,
                              ),
                            ),
                          );
                        },
                      ),
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
