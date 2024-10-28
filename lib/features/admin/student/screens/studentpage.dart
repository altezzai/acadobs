import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';

class StudentsPage extends StatefulWidget {
  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String searchQuery = "";
  String selectedClass = "All";

  @override
  void initState() {
    super.initState();
    context.read<StudentController>().getStudentDetails();
  }

  void _filterStudents(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _filterByClass(String? newClass) {
    if (newClass != null) {
      setState(() {
        selectedClass = newClass;
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
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            try {
              context.goNamed(
                AppRouteConst.bottomNavRouteName,
                extra: UserType.admin,
              );
            } catch (e) {
              print('Navigation Error: $e');
            }
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
                    onChanged: _filterStudents,
                    decoration: InputDecoration(
                      hintText: 'Search for Students',
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
            child: Consumer<StudentController>(
              builder: (context, value, child) {
                if (value.isloading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Filter students by search query and class
                // final filteredStudents =
                //     value.students.where((student) {
                //   final matchesSearchQuery = student.fullName!
                //       .toLowerCase()
                //       .contains(searchQuery.toLowerCase());
                //   final matchesClass = selectedClass == "All" ||
                //       student.studentDatumClass == selectedClass;
                //   return matchesSearchQuery && matchesClass;
                // }).toList();

                return ListView.builder(
                  itemCount: value.students.length,
                  itemBuilder: (context, index) {
                    // final student = filteredStudents[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: GestureDetector(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/student4.png'),
                          ),
                          title: Text(
                            value.students[index].fullName ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                          subtitle: Text(
                            value.students[index].studentClass.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15),
                          ),
                          trailing: TextButton(
                            child: Text('View'),
                            onPressed: () => context.pushReplacementNamed(
                              AppRouteConst.AdminstudentdetailsRouteName,
                              extra: {
                                'name': value.students[index].fullName,
                                'class': value.students[index].studentClass
                                    .toString(),
                                'image': 'student6.png',
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.goNamed(AppRouteConst.AddStudentRouteName);
        },
        label: Text('Add New Student'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
