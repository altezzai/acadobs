import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
// Ensure you have imported your custom widgets

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  String? selectedClass;
  String? selectedDivision;

  // Dummy data for dropdowns
  List<String> classList = ['V', 'VI', 'VII', 'VIII', 'IX', 'X'];
  List<String> divisionList = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Add Student',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              Text(
                'Student Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Name Input
              CustomTextfield(
                hintText: 'Name',
                iconData: Icon(Icons.person),
              ),
              SizedBox(height: 20),

              // ID Number Input
              CustomTextfield(
                hintText: 'ID No',
                iconData: Icon(Icons.badge),
              ),
              SizedBox(height: 20),

              // Class and Division dropdowns
              Row(
                children: [
                  // Class Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.school),
                      ),
                      value: selectedClass,
                      hint: Text(
                        'Class',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: classList.map((String className) {
                        return DropdownMenuItem<String>(
                          value: className,
                          child: Text(className),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedClass = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),

                  // Division Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.filter_list),
                      ),
                      value: selectedDivision,
                      hint: Text(
                        'Division',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: divisionList.map((String division) {
                        return DropdownMenuItem<String>(
                          value: division,
                          child: Text(division),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedDivision = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Date of Joining Input
              CustomTextfield(
                hintText: 'Date of joining',
                iconData: Icon(Icons.calendar_today),
                keyBoardtype: TextInputType.datetime,
              ),
              SizedBox(height: 20),

              // Date of Birth Input
              CustomTextfield(
                hintText: 'Date of Birth',
                iconData: Icon(Icons.calendar_today),
                keyBoardtype: TextInputType.datetime,
              ),
              SizedBox(height: 20),

              // Address Input
              CustomTextfield(
                hintText: 'Address',
                iconData: Icon(Icons.location_on),
                keyBoardtype: TextInputType.streetAddress,
              ),
              SizedBox(height: 20),

              // ID Card Input
              CustomTextfield(
                hintText: 'ID Card',
                iconData: Icon(Icons.credit_card),
              ),
              SizedBox(height: 20),

              Text(
                'Parent Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Father's Name Input
              CustomTextfield(
                hintText: 'Father\'s Name',
                iconData: Icon(Icons.person_outline),
              ),
              SizedBox(height: 20),

              // Father's Phone Number Input
              CustomTextfield(
                hintText: 'Father\'s Phone Number',
                iconData: Icon(Icons.phone),
                keyBoardtype: TextInputType.phone,
              ),
              SizedBox(height: 20),

              // Mother's Name Input
              CustomTextfield(
                hintText: 'Mother\'s Name',
                iconData: Icon(Icons.person_outline),
              ),
              SizedBox(height: 20),

              // Mother's Phone Number Input
              CustomTextfield(
                hintText: 'Mother\'s Phone Number',
                iconData: Icon(Icons.phone),
                keyBoardtype: TextInputType.phone,
              ),
              SizedBox(height: 40),

              // Submit Button
              Center(
                child: CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    // Handle form submission logic here
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
