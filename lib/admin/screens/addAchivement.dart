import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_dropdown';

import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class AddAchievementPage extends StatefulWidget {
  @override
  _AddAchievementPageState createState() => _AddAchievementPageState();
}

class _AddAchievementPageState extends State<AddAchievementPage> {
  DateTime? selectedDate;
  String? selectedClass;
  String? selectedDivision;
  String? studentName;
  String? selectedLevel;
  String? certificatePath; // Path for selected certificate

  // Sample dropdown items
  final List<String> classes = ['V', 'VI', 'VII', 'VIII', 'IX', 'X'];
  final List<String> divisions = ['A', 'B', 'C'];
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  // Function to format date
  String formatDate(DateTime? date) {
    if (date == null) return 'mm/dd/yyyy';
    return DateFormat('MM/dd/yyyy').format(date);
  }

  // Function to show the date picker and set the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Function to select a file for the certificate
  Future<void> _selectCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );
    if (result != null) {
      setState(() {
        certificatePath = result.files.single.path; // Store the file path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Achievement',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Class dropdown
            CustomDropdown(
              hintText: 'Class',
              value: selectedClass,
              items: classes,
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                });
              },
              iconData: Icon(Icons.class_),
            ),
            SizedBox(height: 16),

            // Division dropdown
            CustomDropdown(
              hintText: 'Division',
              value: selectedDivision,
              items: divisions,
              onChanged: (value) {
                setState(() {
                  selectedDivision = value;
                });
              },
              iconData: Icon(Icons.category),
            ),
            SizedBox(height: 16),

            // Student Name input as CustomTextfield
            CustomTextfield(
              hintText: 'Student Name',
              iconData: Icon(Icons.person),
              onChanged: (value) {
                setState(() {
                  studentName = value; // Set studentName value
                });
              },
            ),
            SizedBox(height: 24),

            // Achievement details
            Text(
              'Achievement details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Title input
            CustomTextfield(
              hintText: 'Title',
              iconData: Icon(Icons.title),
            ),
            SizedBox(height: 16),

            // Level dropdown
            CustomDropdown(
              hintText: 'Level',
              value: selectedLevel,
              items: levels,
              onChanged: (value) {
                setState(() {
                  selectedLevel = value;
                });
              },
              iconData: Icon(Icons.star),
            ),
            SizedBox(height: 16),

            // Date picker button
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        formatDate(selectedDate),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: selectedDate != null
                              ? Colors.black87
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Certificate input button
            GestureDetector(
              onTap: _selectCertificate,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                child: Row(
                  children: [
                    Icon(Icons.attach_file),
                    SizedBox(width: 12),
                    Expanded(
                        child: Text(
                      certificatePath != null
                          ? certificatePath!.split('/').last
                          : 'Select Certificate',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14.0,
                            color: Colors
                                .grey, // Ensure it matches the desired color
                          ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),

            // Submit button using CustomButton
            CustomButton(
              text: 'Submit',
              onPressed: () {
                // Implement submit logic here
                print('Submit button pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
