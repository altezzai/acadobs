import 'package:flutter/material.dart';
import 'package:school_app/widgets/custom_button.dart';
import 'package:school_app/widgets/custom_textfield.dart';

class AddDutyPage extends StatefulWidget {
  @override
  _AddDutyPageState createState() => _AddDutyPageState();
}

class _AddDutyPageState extends State<AddDutyPage> {
  List<String> staffList = [
    'Kaiya Mango',
    'Lindsey Calzoni',
    'Adison Rhiel Madsen'
  ];
  String? selectedStaff;
  List<String> selectedStaffs = [];

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
            Navigator.pop(context); // Navigate back
          },
        ),
        centerTitle: true,
        title: Text(
          'Add Duty',
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
              // Title Input
              CustomTextfield(
                hintText: 'Title',
                iconData: Icon(Icons.title),
              ),
              SizedBox(height: 20),

              // Description Input
              CustomTextfield(
                hintText: 'Description',
                iconData: Icon(Icons.description),
                keyBoardtype: TextInputType.multiline,
              ),
              SizedBox(height: 20),

              // Date Inputs (Start and End Date)
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      hintText: 'Start date',
                      iconData: Icon(Icons.calendar_today),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomTextfield(
                      hintText: 'End date',
                      iconData: Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Select Staffs Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Staffs...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: selectedStaff,
                icon: Icon(Icons.arrow_drop_down),
                items: staffList.map((String staff) {
                  return DropdownMenuItem<String>(
                    value: staff,
                    child: Text(staff),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedStaff = newValue;
                    if (newValue != null &&
                        !selectedStaffs.contains(newValue)) {
                      selectedStaffs.add(newValue);
                    }
                  });
                },
              ),
              SizedBox(height: 20),

              // Selected Staffs Display
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: selectedStaffs.map((staff) {
                  return _buildStaffChip(staff);
                }).toList(),
              ),
              SizedBox(height: 20),

              // Add Documents Button
              CustomButton(
                text: 'Add Documents',
                onPressed: () {
                  // Handle document upload
                },
              ),
              SizedBox(height: 30),

              // Submit Button
              Center(
                child: CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    // Handle form submission
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Staff Chip Widget with delete functionality
  Widget _buildStaffChip(String staffName) {
    return Chip(
      label: Text(staffName),
      deleteIcon: Icon(Icons.cancel, color: Colors.red),
      onDeleted: () {
        setState(() {
          selectedStaffs.remove(staffName);
        });
      },
    );
  }
}
