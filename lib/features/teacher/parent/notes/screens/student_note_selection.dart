import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
//import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
//import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';

class StudentNoteSelectionPage extends StatefulWidget {
  @override
  _StudentNoteSelectionPageState createState() =>
      _StudentNoteSelectionPageState();
}

class _StudentNoteSelectionPageState extends State<StudentNoteSelectionPage> {
  // String searchQuery = "";
  // String selectedClass = "All";

  late DropdownProvider dropdownprovider;

  @override
  void initState() {
    dropdownprovider = context.read<DropdownProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownprovider.clearSelectedItem('class');
      dropdownprovider.clearSelectedItem('division');

      context.read<StudentController>().clearStudentList();
      // super.dispose();

      context.read<StudentController>().getStudentDetails();
    });

    super.initState();
  }

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
              title: 'Select Student',
              onTap: () {
                context.pushNamed(AppRouteConst.NotesRouteName);
              },
              isProfileIcon: false,
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
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'class',
                    label: 'Class',
                    items: ['5', '6', '7', '8', '9', '10'],
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
                      child: Loading(
                        color: Colors.grey,
                      ),
                    );
                  } else if (value.filteredstudents.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empty.png',
                            height: Responsive.height * 45,
                          ),
                        ],
                      ),
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
                            final student = value.filteredstudents[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: ProfileTile(
                                suffixText: "Select",
                                imageUrl:
                                    "${baseUrl}${Urls.studentPhotos}${student.studentPhoto}",
                                name: capitalizeFirstLetter(
                                    student.fullName ?? ""),
                                description:
                                    "${student.studentClass} ${student.section}",
                                onPressed: () {
                                  context.pushNamed(
                                      AppRouteConst.AddNoteRouteName,
                                      extra: student);
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     context.pushNamed(AppRouteConst.AddStudentRouteName);
      //   },
      //   label: Text('Add New Student'),
      //   icon: Icon(Icons.add),
      //   backgroundColor: Colors.black,
      //   foregroundColor: Colors.white,
      // ),
    );
  }
}
