import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/teacher/controller/dropdown_provider.dart';
import 'package:school_app/features/teacher/widgets/custom_dropdown.dart';

class AddNoticePage extends StatefulWidget {
  @override
  _AddNoticePageState createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  String? selectedDivision;
  String? selectedClass;
  String? selectedAudience;
  String? selectedFile;
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> classes = ['Class 1', 'Class 2', 'Class 3', 'Class 4'];

  Future<void> pickFile() async {
    // ignore: unused_local_variable
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      // Use SingleChildScrollView here
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 20),
            // Target Audience Dropdown
            CustomDropdown(
              dropdownKey: 'targetAudience',
              label: 'Select Audience',
              icon: Icons.school,
              items: ['All', 'Teachers', 'Parents'],
            ),
            SizedBox(height: Responsive.height * 2),
            // Row for Class and Division Dropdowns
            Row(
              children: [
                // Expanded dropdown for Class
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'classDropdown',
                    label: 'Select Class',
                    icon: Icons.school,
                    items: ['Class 1', 'Class 2', 'Class 3'],
                  ),
                ),
                SizedBox(width: 16), // Space between the dropdowns
                // Expanded dropdown for Division
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'divisionDropdown',
                    label: 'Select Division',
                    icon: Icons.group,
                    items: ['A', 'B', 'C'],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Date Picker
            CustomDatePicker(
              label: "dd-mm-yyyy",
              dateController: _dateController, // Unique controller for end date
              onDateSelected: (selectedDate) {
                print("End Date selected: $selectedDate");
              },
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
              label: 'Title',
              iconData: Icon(Icons.title),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Description Input
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write here....',
                labelText: 'Description',
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
            ),

            SizedBox(height: 16),

            // Document Upload Button
            GestureDetector(
              onTap: pickFile,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                child: Row(
                  children: [
                    Icon(Icons.attachment_rounded, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedFile ?? 'Document',
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

            SizedBox(height: 40),
            Center(
              child: CustomButton(
                text: 'Submit',
                onPressed: () {
                  final selected_Audience = context
                      .read<DropdownProvider>()
                      .getSelectedItem('targetAudience');
                  context.read<NoticeController>().addNotice(
                    context,
                      audience_type: selected_Audience,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: _dateController.text);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
