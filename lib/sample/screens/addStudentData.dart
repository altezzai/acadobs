import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';

class AddStudentData extends StatefulWidget {
  @override
  _AddStudentDataState createState() => _AddStudentDataState();
}

class _AddStudentDataState extends State<AddStudentData> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _admissionNumberController =
      TextEditingController();
  final TextEditingController _aadhaarNumberController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fatherFullNameController =
      TextEditingController();
  final TextEditingController _motherFullNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Student")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: _dateOfBirthController,
                decoration:
                    InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
              ),
              TextField(
                controller: _classController,
                decoration: InputDecoration(labelText: 'Class'),
              ),
              TextField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: _classController,
                decoration: InputDecoration(labelText: 'Class'),
              ),
              TextField(
                controller: _sectionController,
                decoration: InputDecoration(labelText: 'Section'),
              ),
              TextField(
                controller: _rollNumberController,
                decoration: InputDecoration(labelText: 'Roll Number'),
              ),
              TextField(
                controller: _admissionNumberController,
                decoration: InputDecoration(labelText: 'Admission Number'),
              ),
              TextField(
                controller: _aadhaarNumberController,
                decoration: InputDecoration(labelText: 'Aadhaar Number'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
              ),
              TextField(
                controller: _fatherFullNameController,
                decoration: InputDecoration(labelText: "Father's Full Name"),
              ),
              TextField(
                controller: _motherFullNameController,
                decoration: InputDecoration(labelText: "Mother's Full Name"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitForm(context);
                },
                child: Text("Add Student"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    // Create StudentData from form data
    final student = StudentData(
      fullName: _fullNameController.text,
      dateOfBirth: DateTime.parse(_dateOfBirthController.text),
      gender: _genderController.text,
      studentDatumClass: _classController.text,
      section: _sectionController.text,
      rollNumber: int.tryParse(_rollNumberController.text),
      admissionNumber: _admissionNumberController.text,
      aadhaarNumber: _aadhaarNumberController.text,
      residentialAddress: _addressController.text,
      contactNumber: _contactNumberController.text,
      email: _emailController.text,
      fatherFullName: _fatherFullNameController.text,
      motherFullName: _motherFullNameController.text,
      bloodGroup: null, // Optional, add other fields as needed
    );

    // Call the addStudent method in the controller
    context.read<SampleController>().addStudent(student);
  }
}
