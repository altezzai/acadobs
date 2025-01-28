import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';

import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
import '../../../../base/utils/form_validators.dart';

class AddDutyPage extends StatefulWidget {
  @override
  _AddDutyPageState createState() => _AddDutyPageState();
}

class _AddDutyPageState extends State<AddDutyPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedStaff;
  String? selectedFile;
  List<String> selectedStaffs = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  late TeacherController teacherController;
  late DropdownProvider dropdownProvider;
  late FilePickerProvider filePickerProvider;

  @override
  void initState() {
    super.initState();
    teacherController = Provider.of<TeacherController>(context, listen: false);
    dropdownProvider = context.read<DropdownProvider>();
    filePickerProvider = context.read<FilePickerProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearAllDropdowns();
      filePickerProvider.clearFile('duty file');
      if (teacherController.selectedTeacherIds.isNotEmpty) {
        teacherController.clearSelection();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Responsive().init(constraints, MediaQuery.of(context).orientation);

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width * 4),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                    SizedBox(height: Responsive.height * 2),

                    // Title Input
                    CustomTextfield(
                      hintText: 'Title',
                      controller: _titleController,
                      iconData: Icon(Icons.title),
                      hintStyle: TextStyle(fontSize: Responsive.text * 1.8),
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Title"),
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Description Input
                    CustomTextfield(
                      hintText: 'Description',
                      controller: _descriptionController,
                      iconData: Icon(Icons.description),
                      keyBoardtype: TextInputType.multiline,
                      hintStyle: TextStyle(fontSize: Responsive.text * 1.8),
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Description"),
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Remark Input
                    CustomTextfield(
                      hintText: 'Remark',
                      controller: _remarkController,
                      iconData: Icon(Icons.description),
                      keyBoardtype: TextInputType.multiline,
                      hintStyle: TextStyle(fontSize: Responsive.text * 1.8),
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Remark"),
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Date Inputs (Start and End Date) with DatePicker
                    Row(
                      children: [
                        // Start Date Field
                        Expanded(
                          child: CustomDatePicker(
                            label: "Start Date",
                            dateController: _startDateController,
                            firstDate: DateTime.now(), // Earliest date is today
                            lastDate: DateTime(
                                2100), // Extend to a reasonable future date
                            initialDate: DateTime.now(),
                            onDateSelected: (selectedDate) {
                              print("Start Date selected: $selectedDate");
                            },
                            validator: (value) =>
                                FormValidator.validateNotEmpty(value,
                                    fieldName: "Start Date"),
                          ),
                        ),
                        SizedBox(width: Responsive.width * 2),

                        // End Date Field
                        Expanded(
                          child: CustomDatePicker(
                            label: "End Date",
                            dateController: _endDateController,
                            firstDate:
                                DateTime.now(), // Ensure it's today or later
                            lastDate: DateTime(
                                2100), // Extend to a reasonable future date
                            initialDate: DateTime.now()
                                .add(Duration(days: 1)), // Default to tomorrow
                            onDateSelected: (selectedDate) {
                              print("End Date selected: $selectedDate");
                            },
                            validator: (value) =>
                                FormValidator.validateNotEmpty(value,
                                    fieldName: "End Date"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Status Dropdown
                    // CustomDropdown(
                    //   dropdownKey: 'status',
                    //   label: 'Status',
                    //   items: ['Pending', 'In Progress', 'Completed'],
                    //   icon: Icons.pending_actions,
                    //   validator: (value) => FormValidator.validateNotEmpty(
                    //       value,
                    //       fieldName: "Status"),
                    // ),
                    // SizedBox(height: Responsive.height * 2),

                    CustomFilePicker(
                      label: 'Document',
                      fieldName: 'duty file',
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Document"),
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Selected Teachers
                    Text("Selected Teachers: ",
                        style: TextStyle(fontSize: Responsive.text * 2)),
                    SizedBox(height: Responsive.height * 1),

                    InkWell(
                      onTap: () {
                        context
                            .pushNamed(AppRouteConst.teacherSelectionRouteName);
                      },
                      child: Consumer<TeacherController>(
                          builder: (context, value, child) {
                        String selectedTeacherNames = value.selectedTeacherIds
                            .map((id) => value.teachers
                                .firstWhere((teacher) => teacher.id == id)
                                .fullName)
                            .join(", ");

                        return TextFormField(
                          decoration: InputDecoration(
                            hintText: value.selectedTeacherIds.isEmpty
                                ? "Select Staffs"
                                : capitalizeEachWord(selectedTeacherNames),
                            enabled: false,
                          ),
                          // validator: (value) => FormValidator.validateNotEmpty(
                          //     value,
                          //     fieldName: "Staff selection"),
                        );
                      }),
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Selected Staffs Display
                    Wrap(
                      spacing: Responsive.width * 2,
                      runSpacing: Responsive.height * 1,
                      children: selectedStaffs.map((staff) {
                        return _buildStaffChip(staff);
                      }).toList(),
                    ),
                    SizedBox(height: Responsive.height * 4),

                    // Submit Button
                    Center(
                      child: Consumer2<TeacherController, DutyController>(
                        builder: (context, value1, value2, child) {
                          return CommonButton(
                            onPressed: () async {
                              // First, validate the form
                              if (_formKey.currentState?.validate() ?? false) {
                                // Check that start date is before end date
                                DateTime? startDate = DateTime.tryParse(
                                    _startDateController.text);
                                DateTime? endDate =
                                    DateTime.tryParse(_endDateController.text);

                                if (startDate != null &&
                                    endDate != null &&
                                    endDate.isBefore(startDate)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'End date must be after start date.'),
                                    ),
                                  );
                                  return;
                                }

                                // Log selected teacher ids
                                log("List of teacher ids selected: ==== ${value1.selectedTeacherIds.toString()}");

                                // Retrieve selected status and duty file
                                final status = context
                                    .read<DropdownProvider>()
                                    .getSelectedItem('status');
                                final dutyfile = context
                                    .read<FilePickerProvider>()
                                    .getFile('duty file');
                                final dutyfilepath = dutyfile?.path;

                                // Proceed with adding the duty
                                context.read<DutyController>().addDuty(
                                      context,
                                      duty_title: _titleController.text,
                                      description: _descriptionController.text,
                                      status: status,
                                      remark: _remarkController.text,
                                      teachers: value1.selectedTeacherIds,
                                      fileattachment: dutyfilepath,
                                    );
                              } else {
                                // If form is invalid, show a message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please fix the errors in the form.'),
                                  ),
                                );
                              }
                            },
                            widget: value2.isloadingTwo
                                ? ButtonLoading()
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: Responsive.text * 2),
                                  ),
                          );
                        },
                      ),
                    ),
                    // SizedBox(height: Responsive.height * 2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Build Staff Chip Widget with delete functionality
  Widget _buildStaffChip(String staffName) {
    return Chip(
      label: Text(staffName, style: TextStyle(fontSize: Responsive.text * 1.8)),
      deleteIcon: Icon(Icons.cancel, color: Colors.red),
      onDeleted: () {
        setState(() {
          selectedStaffs.remove(staffName);
        });
      },
    );
  }
}
