import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';

import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';


class AddNoticePage extends StatefulWidget {
  @override
  _AddNoticePageState createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  String? selectedDivision;
  String? selectedClass;
  String? selectedAudience;
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();

  Future<void> pickFile() async {
    // ignore: unused_local_variable
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Add Notice'),
        //   centerTitle: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       context.pushReplacementNamed(
        //                   AppRouteConst.AdminHomeRouteName);
        //     },
        //   ),
        // ),
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
              hintText: 'Select Audience',
              value: selectedAudience,
              items: ['All Students', 'All Teachers'],
              onChanged: (value) {
                setState(() {
                  selectedAudience = value;
                });
              },
              iconData: const Icon(Icons.person),
            ),

            SizedBox(height: 16),

            // Class Dropdown
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    hintText: 'Class',
                    value: selectedClass,
                    items: ['Class 1', 'Class 2', 'Class 3'],
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    },
                    iconData: const Icon(Icons.school),
                  ),
                ),
                const SizedBox(width: 16), // Space between Class and Division
                Expanded(
                  child: CustomDropdown(
                    hintText: 'Division',
                    value: selectedDivision,
                    items: ['Division A', 'Division B', 'Division C'],
                    onChanged: (value) {
                      setState(() {
                        selectedDivision = value;
                      });
                    },
                    iconData: const Icon(Icons.class_),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Date Picker
            CustomDatePicker(
              label: "Date",
              dateController: _dateController, // Unique controller for end date
              onDateSelected: (selectedDate) {
                print("End Date selected: $selectedDate");
              },
            ),
r
            SizedBox(height: 16),
            Text(
              'Notice Details',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),

            // Title Input
            CustomTextfield(
              hintText: 'Title',
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
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Colors.grey, // Change label text color here
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                prefixIcon: Icon(Icons.description),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
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
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle form submission logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form successfully submitted!')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
