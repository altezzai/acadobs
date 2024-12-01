import 'dart:developer';

import 'package:file_picker/file_picker.dart'; // imported for date formatting
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';

class AddDutyPage extends StatefulWidget {
  @override
  _AddDutyPageState createState() => _AddDutyPageState();
}

class _AddDutyPageState extends State<AddDutyPage> {
  String? selectedStaff;
  String? selectedFile;
  List<String> selectedStaffs = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future<void> pickFile() async {
    // ignore: unused_local_variable
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
  }

  late TeacherController teacherController;
  late DropdownProvider dropdownProvider;
  @override
  void initState() {
    super.initState();

    teacherController = Provider.of<TeacherController>(context, listen: false);
    dropdownProvider = context.read<DropdownProvider>();

    // Clear dropdowns and selection after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearAllDropdowns();

      if (teacherController.selectedTeacherIds.isNotEmpty) {
        teacherController.clearSelection();
      }
    });
  }

  // Variables to hold selected dates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Add Duty",
                isProfileIcon: false,
                onTap: () {
                  context.pushNamed(AppRouteConst.bottomNavRouteName,
                      extra: UserType.admin);
                },
              ),
              // Title Input
              CustomTextfield(
                hintText: 'Title',
                controller: _titleController,
                iconData: Icon(Icons.title),
                hintStyle: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 20),

              // Description Input
              CustomTextfield(
                hintText: 'Description',
                controller: _descriptionController,
                iconData: Icon(Icons.description),
                keyBoardtype: TextInputType.multiline,
                hintStyle: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 20),

              CustomTextfield(
                hintText: 'remark',
                controller: _remarkController,
                iconData: Icon(Icons.description),
                keyBoardtype: TextInputType.multiline,
                hintStyle: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 20),

              // Date Inputs (Start and End Date) with DatePicker
              Row(
                children: [
                  // Start Date Field
                  Expanded(
                    child: CustomDatePicker(
                      label: "Start Date",
                      dateController:
                          _startDateController, // Unique controller for end date
                      onDateSelected: (selectedDate) {
                        print("End Date selected: $selectedDate");
                      },
                    ),
                  ),
                  SizedBox(width: 10),

                  // End Date Field
                  Expanded(
                    child: CustomDatePicker(
                      label: "End Date",
                      dateController:
                          _endDateController, // Unique controller for end date
                      onDateSelected: (selectedDate) {
                        print("End Date selected: $selectedDate");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              CustomDropdown(
                dropdownKey: 'status',
                label: 'Status',
                items: ['Pending', 'In Progress', 'Completed'],
                icon: Icons.pending_actions,
              ),
              SizedBox(height: 20),
              Text("Selected Teachers:"),
              SizedBox(height: 10),
              // Select Staffs
              InkWell(
                onTap: () {
                  context.pushNamed(AppRouteConst.teacherSelectionRouteName);
                },
                child: Consumer<TeacherController>(
                  builder: (context, value, child) {
                    // Get names of selected teachers
                    String selectedTeacherNames = value.selectedTeacherIds
                        .map((id) => value.teachers
                            .firstWhere((teacher) => teacher.id == id)
                            .fullName)
                        .join(", "); // Concatenate names with a comma

                    return TextFormField(
                      decoration: InputDecoration(
                        hintText: value.selectedTeacherIds.isEmpty
                            ? "Select Staffs"
                            : capitalizeEachWord(
                                selectedTeacherNames), // Display selected names or placeholder
                        enabled: false,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // Selected Staffs Display
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: selectedStaffs.map((staff) {
                  return _buildStaffChip(staff);
                }).toList(),
              ),
              SizedBox(height: Responsive.height * 1),

              // Submit Button
              Center(
                child: Consumer<TeacherController>(
                    builder: (context, value, child) {
                  return CustomButton(
                    text: 'Submit',
                    onPressed: () async {
                      log("List of teacher ids selected: ==== ${value.selectedTeacherIds.toString()}");
                      final status = context
                          .read<DropdownProvider>()
                          .getSelectedItem('status');
                      context.read<DutyController>().addDuty(context,
                          duty_title: _titleController.text,
                          description: _descriptionController.text,
                          status: status,
                          remark: _remarkController.text,
                          teachers: value.selectedTeacherIds);
                      // value.clearSelection();
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Staff Chip Widget with delete functionality
  Widget _buildStaffChip(String staffName) {
    return Chip(
      label: Text(staffName),
      deleteIcon: Icon(Icons.cancel, color: Colors.red),
      onDeleted: () {
        setState(() {
          selectedStaffs.remove(staffName);
        });
      },
    );
  }
}
