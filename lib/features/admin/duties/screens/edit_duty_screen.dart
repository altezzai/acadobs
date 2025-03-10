import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/form_validators.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';

class EditDutyScreen extends StatefulWidget {
  final Duty duty;
  const EditDutyScreen({
    super.key,
    required this.duty,
  });

  @override
  State<EditDutyScreen> createState() => _EditDutyScreenState();
}

class _EditDutyScreenState extends State<EditDutyScreen> {
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
    _titleController.text = widget.duty.duty?.dutyTitle ?? "";
    _descriptionController.text = widget.duty.duty?.description ?? "";
    _remarkController.text = widget.duty.duty?.remark ?? "";
    _startDateController.text = widget.duty.duty?.assignedDate != null
        ? DateFormat('yyyy-MM-dd')
            .format(widget.duty.duty?.assignedDate as DateTime)
        : "";

    _endDateController.text = widget.duty.duty?.endDate ?? "";

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
                    SizedBox(height: Responsive.height * 1),
                    CustomAppbar(
                      title: "Edit Duty",
                      isProfileIcon: false,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Title Input
                    CustomTextfield(
                      label: 'Title',
                      controller: _titleController,
                      iconData: Icon(Icons.title),
                      hintStyle: TextStyle(fontSize: Responsive.text * 1.8),
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Description Input
                    CustomTextfield(
                      label: 'Description',
                      controller: _descriptionController,
                      iconData: Icon(Icons.description),
                      keyBoardtype: TextInputType.multiline,
                      hintStyle: TextStyle(fontSize: Responsive.text * 1.8),
                    ),
                    SizedBox(height: Responsive.height * 2),

                    // Remark Input
                    CustomTextfield(
                      label: 'Remark',
                      controller: _remarkController,
                      iconData: Icon(Icons.description),
                      keyBoardtype: TextInputType.multiline,
                      hintStyle: TextStyle(fontSize: Responsive.text * 1.8),
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.height * 2),

                    CustomFilePicker(
                      label: 'Document (Maximum file size: 5MB)',
                      fieldName: 'duty file',
                      // validator: (value) => FormValidator.validateNotEmpty(
                      //     value,
                      //     fieldName: "Document"),
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
                        final assignedTeachers = widget.duty.assignedTeachers
                                ?.map((teacher) => teacher.fullName)
                                .toList() ??
                            [];
                        return TextFormField(
                          decoration: InputDecoration(
                            hintText: value.selectedTeacherIds.isEmpty
                                ? capitalizeEachWord(
                                    assignedTeachers.join(', '))
                                : capitalizeEachWord(selectedTeacherNames),
                            enabled: false,
                          ),
                          validator: (value) => FormValidator.validateNotEmpty(
                              value,
                              fieldName: "Staff selection"),
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

                              // Check that start date is before end date
                              DateTime? startDate =
                                  DateTime.tryParse(_startDateController.text);
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
                              final assignedTeachers = widget
                                      .duty.assignedTeachers
                                      ?.map((teacher) => teacher.id)
                                      .toList() ??
                                  [];

                              // Proceed with adding the duty
                              context.read<DutyController>().editDuty(
                                    context,
                                    dutyId: widget.duty.duty?.id ?? 0,
                                    duty_title: _titleController.text,
                                    description: _descriptionController.text,
                                    status: status,
                                    remark: _remarkController.text,
                                    assignedDate: _startDateController.text,
                                    endDate: _endDateController.text,
                                    teachers: value1.selectedTeacherIds.isEmpty
                                        ? assignedTeachers
                                            .whereType<int>()
                                            .toList()
                                        : value1.selectedTeacherIds
                                            .whereType<int>()
                                            .toList(),
                                    fileattachment: dutyfilepath,
                                  );
                            },
                            widget: value2.isloadingTwo
                                ? ButtonLoading()
                                : Text(
                                    'Edit Duty',
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
