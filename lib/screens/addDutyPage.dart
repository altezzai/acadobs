import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // imported for date formatting
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

  // Variables to hold selected dates
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  // Function to format date
  String formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Function to show the date picker and set the selected date
  Future<void> _selectDate(BuildContext context,
      {required bool isStartDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = pickedDate;
        } else {
          selectedEndDate = pickedDate;
        }
      });
    }
  }

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
                hintStyle: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 20),

              // Description Input
              CustomTextfield(
                hintText: 'Description',
                iconData: Icon(Icons.description),
                keyBoardtype: TextInputType.multiline,
                hintStyle: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 20),

              // Date Inputs (Start and End Date) with DatePicker
              Row(
                children: [
                  // Start Date Field
                  Expanded(
                    child: CustomTextfield(
                      hintText: formatDate(selectedStartDate),
                      iconData: Icon(Icons.calendar_today),
                      hintStyle: TextStyle(fontSize: 14.0),
                      textStyle:
                          TextStyle(fontSize: 14.0, color: Colors.black87),
                      isPasswordField: false,
                      keyBoardtype: TextInputType.none,
                      onTap: () => _selectDate(context, isStartDate: true),
                    ),
                  ),
                  SizedBox(width: 10),

                  // End Date Field
                  Expanded(
                    child: CustomTextfield(
                      hintText: formatDate(selectedEndDate),
                      iconData: Icon(Icons.calendar_today),
                      hintStyle: TextStyle(fontSize: 14.0),
                      textStyle:
                          TextStyle(fontSize: 14.0, color: Colors.black87),
                      isPasswordField: false,
                      keyBoardtype: TextInputType.none,
                      onTap: () => _selectDate(context, isStartDate: false),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Select Staffs Dropdown
              Container(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person, size: 20),
                    hintText: 'Select Staffs...',
                    hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  value: selectedStaff,
                  icon: Icon(Icons.arrow_drop_down, size: 20),
                  items: staffList.map((String staff) {
                    return DropdownMenuItem<String>(
                      value: staff,
                      child: Text(
                        staff,
                        style: TextStyle(
                            fontSize: 14.0), // Text inside dropdown items
                      ),
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
                  onTap: () {
                    // Optionally clear the dropdown selection when it's opened
                    // setState(() {
                    //   selectedStaff = null;
                    // });
                  },
                  onSaved: (value) {
                    // Optionally clear the dropdown selection when the dropdown is closed
                    setState(() {
                      selectedStaff = null;
                    });
                  },
                ),
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
