import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';

class StudentsPage extends StatefulWidget {
  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final List<Map<String, String>> students = [
    {"name": "Muhammad Rafasl", "class": "VI", "image": "student1.png"},
    {"name": "Midlej O P", "class": "V", "image": "student2.png"},
    {"name": "Saleem Riyaz", "class": "VIII", "image": "student3.png"},
    {"name": "Abram Bator", "class": "IX", "image": "student4.png"},
    {"name": "Allison Lipshulz", "class": "VII", "image": "student5.png"},
    {"name": "Rayees Ibrahim", "class": "VII", "image": "student6.png"},
    {"name": "Khalid Mustafa", "class": "XI", "image": "student7.png"},
    {"name": "Bilal Rifad", "class": "X", "image": "student1.png"},
    {"name": "Hamem Fahad", "class": "VI", "image": "student6.png"},
    {"name": "Sajad K V", "class": "X", "image": "student5.png"},
  ];

  List<Map<String, String>> filteredStudents = [];
  String searchQuery = "";
  String selectedClass = "All"; // Initial class selected

  @override
  void initState() {
    super.initState();
    // Sort the students by name in alphabetical order
    students.sort((a, b) => a['name']!.compareTo(b['name']!));
    filteredStudents = students; // Initialize with all students
  }

  void _filterStudents(String query) {
    setState(() {
      searchQuery = query;
      // Apply filtering logic based on both search query and selected class
      filteredStudents = students.where((student) {
        final matchesSearchQuery =
            student['name']!.toLowerCase().contains(query.toLowerCase());
        final matchesClass =
            selectedClass == "All" || student['class'] == selectedClass;
        return matchesSearchQuery && matchesClass;
      }).toList();
    });
  }

  void _filterByClass(String newClass) {
    setState(() {
      selectedClass = newClass; // Update the selected class

      // Filter by both class and search query
      filteredStudents = students.where((student) {
        final matchesSearchQuery =
            student['name']!.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesClass = newClass == "All" || student['class'] == newClass;
        return matchesSearchQuery && matchesClass;
      }).toList();
    });
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
            context.pushReplacementNamed(AppRouteConst
                .AdminHomeRouteName); // Go back to the previous page
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
                      _filterStudents(value);
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
                      value: selectedClass,
                      underline: SizedBox(),
                      isExpanded: true,
                      items: <String>[
                        'All',
                        'V',
                        'VI',
                        'VII',
                        'VIII',
                        'IX',
                        'X',
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
                        if (newValue != null) {
                          _filterByClass(newValue);
                        }
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
                      context.pushReplacementNamed(
                        AppRouteConst.AdminstudentdetailsRouteName,
                        extra: {
                          'name': filteredStudents[index]['name'],
                          'class': filteredStudents[index]['class'],
                          'image': filteredStudents[index]['image'],
                        },
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
                            fontWeight: FontWeight.normal, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        filteredStudents[index]['class']!,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      ),
                      trailing: TextButton(
                        child: Text(
                          'View',
                          style: TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          context.pushReplacementNamed(
                            AppRouteConst.AdminstudentdetailsRouteName,
                            extra: {
                              'name': filteredStudents[index]['name'],
                              'class': filteredStudents[index]['class'],
                              'image': filteredStudents[index]['image'],
                            },
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
          context.pushReplacementNamed(AppRouteConst.AddStudentRouteName);
        },
        label: Text('Add New Student'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
