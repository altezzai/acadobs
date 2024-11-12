import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';

class StudentsPage extends StatefulWidget {
  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  // String searchQuery = "";
  // String selectedClass = "All";

  @override
  void initState() {
    super.initState();
    context.read<StudentController>().getStudentDetails();
  }

  // void _filterStudents(String query) {
  //   setState(() {
  //     searchQuery = query;
  //   });
  // }

  // void _filterByClass(String? newClass) {
  //   if (newClass != null) {
  //     setState(() {
  //       selectedClass = newClass;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomAppbar(
              title: 'Students',
              onTap: () {
                context.goNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
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
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  // SizedBox(width: 8),
                  // Flexible(
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 12),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey.shade100,
                  //       borderRadius: BorderRadius.circular(30),
                  //       border: Border.all(color: Colors.grey.shade300),
                  //     ),
                  //     child: DropdownButton<String>(
                  //       value: selectedClass,
                  //       underline: SizedBox(),
                  //       isExpanded: true,
                  //       items: <String>[
                  //         'All',
                  //         'V',
                  //         'VI',
                  //         'VII',
                  //         'VIII',
                  //         'IX',
                  //         'X',
                  //       ].map((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(
                  //             value,
                  //             overflow: TextOverflow.ellipsis,
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (newValue) {
                  //         if (newValue != null) {
                  //           _filterByClass(newValue);
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'class',
                    label: 'Class',
                    items: ['8', '9', '10'],
                    icon: Icons.school,
                    onChanged: (selectedClass) {
                      // Automatically fetch students when division is selected
                      final selectedDivision = context
                          .read<DropdownProvider>()
                          .getSelectedItem(
                              'division'); // Get the currently selected class
                      context
                          .read<StudentController>()
                          .getStudentsClassAndDivision(
                              classname: selectedClass,
                              section: selectedDivision);
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'division',
                    label: 'Division',
                    items: ['A', 'B', 'C'],
                    icon: Icons.group,
                    onChanged: (selectedDivision) {
                      // Automatically fetch students when division is selected
                      final selectedClass = context
                          .read<DropdownProvider>()
                          .getSelectedItem(
                              'class'); // Get the currently selected class
                      context
                          .read<StudentController>()
                          .getStudentsClassAndDivision(
                              classname: selectedClass,
                              section: selectedDivision);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Expanded(
              child: Consumer<StudentController>(
                builder: (context, value, child) {
                  if (value.isloading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    padding: EdgeInsets.zero, // Removes any default padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets
                              .zero, // Removes any extra padding at the top
                          itemCount: value.filteredstudents.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: ProfileTile(
                                name: capitalizeFirstLetter(
                                    value.filteredstudents[index].fullName ??
                                        ""),
                                description:
                                    "${value.filteredstudents[index].studentClass} ${value.filteredstudents[index].section}",
                                onPressed: () {
                                  context.pushNamed(
                                      AppRouteConst
                                          .AdminstudentdetailsRouteName,
                                      extra: value.filteredstudents[index]);
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: Responsive.height * 7.5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
