import 'package:flutter/material.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';

class AddHomeworkPage extends StatefulWidget {
  @override
  _AddHomeworkPageState createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedClass;
  String? selectedDivision;
  String? selectedStudent;
  String? selectedSubject;
  String? startDate;
  String? endDate;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final List<String> classes = ['V', 'VI', 'VII', 'VIII', 'IX', 'X'];
  final List<String> divisions = ['A', 'B', 'C'];
  final List<String> students = [
    'Muhammad Rafasl N',
    'Livie Kenter',
    'Kaiya Siphron',
    'Abram Bator',
    'Allison Lipshulz',
    'Diana Lipshulz',
    'Justin Levin',
  ];
  final List<String> subjects = ['Math', 'Science', 'History'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Homework',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Class and Division Dropdowns
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'class',
                    label: 'Class',
                    items: classes,
                    icon: Icons.class_,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // Responsive spacing
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'division',
                    label: 'Division',
                    items: divisions,
                    icon: Icons.account_tree,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Student Dropdown
            CustomDropdown(
              dropdownKey: 'select student',
              label: 'Select student',
              items: students,
              icon: Icons.person,
            ),
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Subject Dropdown
            CustomDropdown(
              dropdownKey: 'select subject',
              label: 'Select subject',
              items: subjects,
              icon: Icons.subject,
            ),
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Start Date and End Date Fields
            Row(
              children: [
                Expanded(
                  child: CustomDatePicker(
                    label: "Start Date",
                    dateController:
                        _startDateController, // Unique controller for end date
                    onDateSelected: (selectedDate) {
                      print("Start Date selected: $selectedDate");
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // Responsive spacing
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
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Homework Title
            CustomTextfield(
              hintText: 'Title',
              iconData: Icon(Icons.title),
              onChanged: (value) {
                titleController.text = value;
              },
            ),
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Homework Description
            CustomTextfield(
              hintText: 'Description',
              iconData: Icon(Icons.description),
              onChanged: (value) {
                descriptionController.text = value;
              },
            ),
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Submit Button
            Center(
                child: CommonButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Handle form submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Form successfully submitted!')),
                  );
                }
              },
              widget: Text('Submit'),
            )
                // CustomButton(
                //   text: 'Submit',
                //   onPressed: () {
                //     if (_formKey.currentState?.validate() ?? false) {
                //       // Handle form submission logic here
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Form successfully submitted!')),
                //       );
                //     }
                //   },
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
