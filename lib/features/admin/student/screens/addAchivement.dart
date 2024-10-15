import 'package:flutter/material.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart'
    as custom_widgets;
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/shared_widgets/custom_calendar.dart';
import '../../../../core/shared_widgets/custom_datepicker.dart';

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
  String? certificatePath;
  final TextEditingController _dateController = TextEditingController();

  final List<String> classes = ['V', 'VI', 'VII', 'VIII', 'IX', 'X'];
  final List<String> divisions = ['A', 'B', 'C'];
  final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  void _handleDateSelection(DateTime date) {
    setState(() {
      selectedDate = date; // Update the selected date
    });
  }

  Future<void> _selectCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );
    if (result != null) {
      setState(() {
        certificatePath = result.files.single.path;
      });
    }
  }

  void _showCalendar() {
    // Show the calendar dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: CustomCalendar(
            onSelectDate: (date) {
              _handleDateSelection(date);
              Navigator.of(context)
                  .pop(); // Close the dialog after selecting a date
            },
          ),
        );
      },
    );
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
            custom_widgets.CustomDropdown(
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

            custom_widgets.CustomDropdown(
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

            CustomTextfield(
              hintText: 'Student Name',
              iconData: Icon(Icons.person),
              onChanged: (value) {
                setState(() {
                  studentName = value;
                });
              },
            ),
            SizedBox(height: 24),

            Text(
              'Achievement details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            CustomTextfield(
              hintText: 'Title',
              iconData: Icon(Icons.title),
            ),
            SizedBox(height: 16),

            custom_widgets.CustomDropdown(
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

            // Date field styled similarly to the other text fields
            CustomDatePicker(
              label: "Date",
              dateController: _dateController, // Unique controller for end date
              onDateSelected: (selectedDate) {
                print("End Date selected: $selectedDate");
              },
            ),
            SizedBox(height: 16),

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
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),

            CustomButton(
              text: 'Submit',
              onPressed: () {
                // Implement submit logic here
                print('Submit button pressed');
                // You can also validate inputs here before submission
              },
            ),
          ],
        ),
      ),
    );
  }
}
