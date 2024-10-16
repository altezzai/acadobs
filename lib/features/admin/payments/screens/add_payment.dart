import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
// ignore: unused_import
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key});

  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedClass;
  String? selectedDivision;
  String? selectedStudent;
  String? selectedFile;
  // ignore: unused_field
  final TextEditingController _dateController = TextEditingController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.single.name;
      });
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
              title: "Add Payment",
              isProfileIcon: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
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
                const SizedBox(width: 16),
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
                    iconData: const Icon(Icons.account_circle),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomDropdown(
              hintText: 'Select Student',
              value: selectedStudent,
              items: ['Student 1', 'Student 2', 'Student 3'],
              onChanged: (value) {
                setState(() {
                  selectedStudent = value;
                });
              },
              iconData: const Icon(Icons.person),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        hintText: 'Year',
                        iconData: const Icon(Icons.calendar_today),
                        keyBoardtype: TextInputType.number,
                        onChanged: (value) {
                          // Handle year input
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextfield(
                        hintText: 'Month',
                        iconData: const Icon(Icons.date_range),
                        keyBoardtype: TextInputType.number,
                        onChanged: (value) {
                          // Handle month input
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hintText: 'Amount',
                  iconData: const Icon(Icons.currency_rupee),
                  keyBoardtype: TextInputType.number,
                  onChanged: (value) {
                    // Handle amount input
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                    Icon(Icons.attach_file, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedFile ?? 'Add Receipt',
                        style: TextStyle(
                            color: selectedFile != null
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
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
