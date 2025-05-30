import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/form_validators.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';

class AddNoticePage extends StatefulWidget {
  @override
  _AddNoticePageState createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedDivision;
  String? selectedClass;
  String? selectedAudience;
  String? selectedFile;
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  // final TextEditingController classController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late DropdownProvider dropdownProvider;
  late FilePickerProvider filePickerProvider;
  @override
  void initState() {
    super.initState();
    dropdownProvider = Provider.of<DropdownProvider>(context, listen: false);
    filePickerProvider = context.read<FilePickerProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('targetAudience');
      filePickerProvider.clearFile('notice file');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppbar(
                title: "Add Notice",
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                'Target audience',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: Responsive.height * 2),
              // Target Audience Dropdown
              CustomDropdown(
                dropdownKey: 'targetAudience',
                label: 'Select Audience*',
                icon: Icons.school,
                items: ['All', 'Specific Class'],
                validator: (value) => FormValidator.validateNotEmpty(value,
                    fieldName: "TargetAudience"),
              ),
              SizedBox(height: Responsive.height * 2),
              // Row for Class and Division Dropdowns
              Consumer<DropdownProvider>(builder: (context, value, child) {
                final dropdownValue = value.getSelectedItem('targetAudience');
                return dropdownValue == 'All'
                    ? SizedBox.shrink()
                    : Row(
                        children: [
                          // Expanded dropdown for Class
                          Expanded(
                            child: CustomDropdown(
                              dropdownKey: 'class',
                              label: 'Class*',
                              icon: Icons.school,
                              items: AppConstants.classNames,
                              validator: (value) =>
                                  FormValidator.validateNotEmpty(value,
                                      fieldName: "Class"),
                            ),
                          ),
                          SizedBox(width: 16), // Space between the dropdowns
                          // Expanded dropdown for Division
                          Expanded(
                            child: CustomDropdown(
                              dropdownKey: 'division',
                              label: 'Division*',
                              icon: Icons.group,
                              items: AppConstants.divisions,
                              validator: (value) =>
                                  FormValidator.validateNotEmpty(value,
                                      fieldName: "Division"),
                            ),
                          ),
                        ],
                      );
              }),
              SizedBox(height: 16),
              // Date Picker
              CustomDatePicker(
                label: "Date*",
                dateController:
                    _dateController, // Unique controller for end date
                lastDate: DateTime(2026),
                onDateSelected: (selectedDate) {
                  print("End Date selected: $selectedDate");
                },
                validator: (value) =>
                    FormValidator.validateNotEmpty(value, fieldName: "Date"),
              ),
              SizedBox(height: Responsive.height * 3),
              Text(
                'Notice Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),

              // Title Input
              CustomTextfield(
                controller: _titleController,
                // hintText: 'Title',
                label: 'Title*',
                iconData: Icon(Icons.title),
                validator: (value) =>
                    FormValidator.validateNotEmpty(value, fieldName: "Title"),
              ),
              SizedBox(height: 16),

              // Description Input
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write here....',
                  labelText: 'Description*',
                  labelStyle: TextStyle(
                    color: Colors.grey, // Change label text color here
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 75.0), // Adjust this value to your needs
                    child: Icon(Icons.description),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) => FormValidator.validateNotEmpty(value,
                    fieldName: "Description"),
              ),

              SizedBox(height: 16),
              CustomFilePicker(
                label: 'Add Receipt (Maximum file size: 5MB)',
                fieldName: 'notice file',
              ),
              SizedBox(height: 40),
              Consumer<NoticeController>(builder: (context, value, child) {
                return CommonButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        final selected_Audience = context
                            .read<DropdownProvider>()
                            .getSelectedItem('targetAudience');
                        String selectedClass = context
                            .read<DropdownProvider>()
                            .getSelectedItem('class');
                        String selectedDivision = context
                            .read<DropdownProvider>()
                            .getSelectedItem('division');
                        context.read<NoticeController>().addNotice(context,
                            className: selectedClass,
                            division: selectedDivision,
                            audience_type: selected_Audience,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: _dateController.text);
                      } catch (e) {
                        // Handle any errors and show an error message
                        CustomSnackbar.show(context,
                            message: "Failed to add notice.Please try again",
                            type: SnackbarType.failure);
                      }
                    } else {
                      // Highlight missing fields if the form is invalid
                      CustomSnackbar.show(context,
                          message: "Please complete all required fields",
                          type: SnackbarType.warning);
                    }
                  },
                  widget: value.isloadingTwo ? Loading() : Text('Submit'),
                );
              }),
            ],
          ),
        ),
      ),
    ));
  }
}
