import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart'; // imported for date formatting
import 'package:provider/provider.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';

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
                  context.pushReplacementNamed(AppRouteConst.bottomNavRouteName,
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

              // Select Staffs Dropdown
              Container(
                child: CustomDropdown(
                  dropdownKey: 'selectstaffs',
                  label: 'Select Staffs',
                  items: [
                    'Kaiya Mango',
                    'Lindsey Calzoni',
                    'Adison Rhiel Madsen'
                  ],
                  icon: Icons.person,
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
              SizedBox(height: 20),

              // Add Documents Button
              GestureDetector(
                onTap: pickFile,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Icon(Icons.attachment_rounded, color: Colors.black),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedFile ?? 'Add Documents',
                          style: TextStyle(
                              color: selectedFile != null
                                  ? Colors.black
                                  : Colors.grey,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Submit Button
              Center(
                child: CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    final status = context
                        .read<DropdownProvider>()
                        .getSelectedItem('status');
                    //  final selectstaffs = context
                    // .read<DropdownProvider>()
                    // .getSelectedItem('selectstaffs');

                    context.read<DutyController>().addDuty(
                          context,
                          duty_title: _titleController.text,
                          description: _descriptionController.text,
                          status: status,
                          remark: _remarkController.text,
                        );
                  },
                ),
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
