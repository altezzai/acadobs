import 'package:flutter/material.dart';

class TeachersPage extends StatefulWidget {
  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  final List<Map<String, String>> teachers = [
    {
      "name": "Muhammad Rafasl",
      "class": "VI Class Teacher",
      "image": "student1.png"
    },
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

  List<Map<String, String>> filteredTeachers = [];
  String searchQuery = "";
  String selectedClass = "All"; // Initial class selected

  @override
  void initState() {
    super.initState();
    // Sort the students by name in alphabetical order
    teachers.sort((a, b) => a['name']!.compareTo(b['name']!));
    filteredTeachers = teachers; // Initialize with all students
  }

  void _filterTeachers(String query) {
    setState(() {
      searchQuery = query;
      filteredTeachers = teachers.where((teacher) {
        final matchesSearchQuery =
            teacher['name']!.toLowerCase().contains(query.toLowerCase());
        final matchesClass = teacher['class'] == selectedClass;
        return matchesSearchQuery && matchesClass;
      }).toList();
    });
  }

  void _filterByClass(String newClass) {
    setState(() {
      selectedClass = newClass; // Update the selected class

      // If "All" is selected, show all students, else filter by class
      if (selectedClass == "All") {
        filteredTeachers = teachers.where((teacher) {
          return teacher['name']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
        }).toList();
      } else {
        filteredTeachers = teachers.where((teacher) {
          final matchesSearchQuery = teacher['name']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
          final matchesClass = teacher['class'] == selectedClass;
          return matchesSearchQuery && matchesClass;
        }).toList();
      }
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
          'Teachers',
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
              backgroundImage: AssetImage('assets/student1.png'),
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
                      _filterTeachers(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for Teachers',
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
              itemCount: filteredTeachers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => StudentDetailPage(
                      //       name: filteredTeachers[index]['name']!,
                      //       studentClass: filteredTeachers[index]['class']!,
                      //       image: filteredTeachers[index]['image']!,
                      //     ),
                      //   ),
                      // );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/${filteredTeachers[index]['image']}'),
                      ),
                      title: Text(
                        filteredTeachers[index]['name']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        filteredTeachers[index]['class']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      trailing: TextButton(
                        child: Text(
                          'View',
                          style: TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => StudentDetailPage(
                          //       name: filteredTeachers[index]['name']!,
                          //       studentClass: filteredTeachers[index]['class']!,
                          //       image: filteredTeachers[index]['image']!,
                          //     ),
                          //   ),
                          // );
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddStudentPage()),
          // );
        },
        label: Text('Add New Teacher'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
