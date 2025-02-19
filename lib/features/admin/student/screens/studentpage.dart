import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_floating_action_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';

class StudentsPage extends StatefulWidget {
  final UserType userType;

  const StudentsPage({super.key, required this.userType});

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  late DropdownProvider dropdownProvider;

  @override
  void initState() {
    super.initState();
    dropdownProvider = context.read<DropdownProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');

      final studentController = context.read<StudentController>();
      studentController.clearStudentList();
      studentController.resetFilter();
      studentController.getLatestStudents(); // Fetch latest students
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentController>(
      builder: (context, studentController, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: Responsive.height * 2),
                CustomAppbar(
                  title: 'Students',
                  isProfileIcon: false,
                  onTap: () {
                    context.pushNamed(
                      AppRouteConst.bottomNavRouteName,
                      extra: widget.userType,
                    );
                  },
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
                          final selectedDivision = context
                              .read<DropdownProvider>()
                              .getSelectedItem('division');
                          studentController.getStudentsClassAndDivision(
                            classname: selectedClass,
                            section: selectedDivision,
                          );
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
                          final selectedClass = context
                              .read<DropdownProvider>()
                              .getSelectedItem('class');
                          studentController.getStudentsClassAndDivision(
                            classname: selectedClass,
                            section: selectedDivision,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: studentController.isloading
                      ? const Center(child: Loading(color: Colors.grey))
                      : studentController.isFiltered
                          ? _buildStudentList(
                              studentController.filteredstudents, context)
                          : _buildStudentList(
                              studentController.lateststudents, context),
                ),
              ],
            ),
          ),
          floatingActionButton: CommonFloatingActionButton(
            onPressed: () {
              context.pushNamed(AppRouteConst.AddStudentRouteName);
            },
            text: 'Add New Student',
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildStudentList(List<Student> students, BuildContext context) {
    if (students.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/empty.png', height: Responsive.height * 45),
            const SizedBox(height: 10),
            const Text(
              'No students available.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: ProfileTile(
            imageUrl: "${baseUrl}${Urls.studentPhotos}${student.studentPhoto}",
            name: capitalizeFirstLetter(student.fullName ?? ""),
            description: "${student.studentClass} ${student.section}",
            onPressed: () {
              context.pushNamed(
                AppRouteConst.AdminstudentdetailsRouteName,
                extra: StudentDetailArguments(
                  student: student,
                  userType: widget.userType,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
