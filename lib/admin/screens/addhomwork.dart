import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_dropdown';
import 'package:school_app/admin/widgets/custom_textfield.dart';

class AddHomeworkPage extends StatefulWidget {
  @override
  _AddHomeworkPageState createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  String? selectedClass;
  String? selectedDivision;
  String? selectedStudent;
  String? selectedSubject;
  String? startDate;
  String? endDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  Future<void> _pickDate(
      BuildContext context, Function(String?) onDatePicked) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // button text color
              ),
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the picker
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      onDatePicked("${pickedDate.month}/${pickedDate.day}/${pickedDate.year}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Homework',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
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
                  child: CustomTextfield(
                    hintText: startDate ?? 'mm/dd/yyyy',
                    iconData: Icon(Icons.calendar_today),
                    onTap: () => _pickDate(context, (value) {
                      setState(() {
                        startDate = value;
                      });
                    }),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // Responsive spacing
                Expanded(
                  child: CustomTextfield(
                    hintText: endDate ?? 'mm/dd/yyyy',
                    iconData: Icon(Icons.calendar_today),
                    onTap: () => _pickDate(context, (value) {
                      setState(() {
                        endDate = value;
                      });
                    }),
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
            ElevatedButton(
              onPressed: () {
                // Handle submit action
                print('Homework Added');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
