import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/app_constants.dart';
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
import 'package:school_app/features/admin/student/model/students_by_class_and_division.dart';

class StudentsPage extends StatefulWidget {
  final UserType userType;

  const StudentsPage({super.key, required this.userType});

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  late DropdownProvider dropdownProvider;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    dropdownProvider = context.read<DropdownProvider>();
    final studentController = context.read<StudentController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');

      // Attach Scroll Listener for Pagination
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) {
          if (!studentController.isloading && studentController.hasMoreData) {
            final selectedClass = dropdownProvider.getSelectedItem('class');
            final selectedDivision =
                dropdownProvider.getSelectedItem('division');
            studentController.getStudentsClassAndDivision(
              classname: selectedClass,
              section: selectedDivision,
            );
          }
        }
      });

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
                        items: AppConstants.classNames,
                        icon: Icons.school,
                        onChanged: (selectedClass) {
                          final selectedDivision = context
                              .read<DropdownProvider>()
                              .getSelectedItem('division');
                          studentController.getStudentsClassAndDivision(
                              classname: selectedClass,
                              section: selectedDivision,
                              isRefresh: true);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: CustomDropdown(
                        dropdownKey: 'division',
                        label: 'Division',
                        items: AppConstants.divisions,
                        icon: Icons.group,
                        onChanged: (selectedDivision) {
                          final selectedClass = context
                              .read<DropdownProvider>()
                              .getSelectedItem('class');
                          studentController.getStudentsClassAndDivision(
                              classname: selectedClass,
                              section: selectedDivision,
                              isRefresh: true);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                Expanded(
                  child: studentController.isloading
                      ? const Center(child: Loading(color: Colors.grey))
                      : studentController.isFiltered
                          ? _buildStudentList(
                              studentController.filteredstudents, context)
                          : _buildStudentList(
                              studentController.lateststudents, context),
                  // studentController.filteredstudents, context)
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

  Widget _buildStudentList(
      List<StudentProfile> students, BuildContext context) {
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

    // Check if filtering is applied; disable pagination for latest students
    bool isPaginationEnabled = context.read<StudentController>().isFiltered;

    return ListView.builder(
      padding: EdgeInsets.only(bottom: Responsive.height * 12),
      physics: AlwaysScrollableScrollPhysics(),
      controller: isPaginationEnabled
          ? scrollController
          : null, // Disable scrolling for latest students
      itemCount: isPaginationEnabled
          ? students.length + 1
          : students.length, // Add +1 only if pagination is enabled
      itemBuilder: (context, index) {
        if (isPaginationEnabled && index == students.length) {
          return context.read<StudentController>().hasMoreData
              ? const Center(
                  child: CircularProgressIndicator()) // Show pagination loader
              : const SizedBox();
        }

        final student = students[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: ProfileTile(
            imageUrl: "${baseUrl}${Urls.studentPhotos}${student.studentPhoto}",
            name: capitalizeFirstLetter(student.fullName ?? ""),
            description: "${student.className} ${student.section}",
            onPressed: () {
              context.pushNamed(
                AppRouteConst.AdminstudentdetailsRouteName,
                extra: StudentDetailArguments(
                  studentId: student.id ?? 0,
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
