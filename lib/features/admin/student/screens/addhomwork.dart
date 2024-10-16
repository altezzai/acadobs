import 'package:flutter/material.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';

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
                ),
                SizedBox(width: screenWidth * 0.02), // Responsive spacing
                Expanded(
                  child: CustomDropdown(
                    hintText: 'Division',
                    value: selectedDivision,
                    items: divisions,
                    onChanged: (value) {
                      setState(() {
                        selectedDivision = value;
                      });
                    },
                    iconData: Icon(Icons.account_tree),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Student Dropdown
            CustomDropdown(
              hintText: 'Select Student',
              value: selectedStudent,
              items: students,
              onChanged: (value) {
                setState(() {
                  selectedStudent = value;
                });
              },
              iconData: Icon(Icons.person),
            ),
            SizedBox(height: screenWidth * 0.04), // Responsive spacing

            // Subject Dropdown
            CustomDropdown(
              hintText: 'Select Subject',
              value: selectedSubject,
              items: subjects,
              onChanged: (value) {
                setState(() {
                  selectedSubject = value;
                });
              },
              iconData: Icon(Icons.subject),
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
    );
  }
}
