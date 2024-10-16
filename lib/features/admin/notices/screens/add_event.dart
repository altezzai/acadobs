import 'package:flutter/material.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedFile;
  final TextEditingController _dateController = TextEditingController();
  Future<void> pickFile() async {
    // ignore: unused_local_variable
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add Event'),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       context.pushReplacementNamed(AppRouteConst.AdminHomeRouteName);
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Add Event",
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                'Event Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Add cover photo action
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add Cover Photo',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextfield(
                hintText: 'Title',
                iconData: Icon(Icons.title),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              SizedBox(height: 20),
              CustomDatePicker(
                label: "Date",
                dateController:
                    _dateController, // Unique controller for end date
                onDateSelected: (selectedDate) {
                  print("End Date selected: $selectedDate");
                },
              ),
              SizedBox(height: 20),
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
                      Icon(Icons.attachment_rounded, color: Colors.black),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedFile ?? 'Document',
                          style: TextStyle(
                              color: selectedFile != null
                                  ? Colors.black
                                  : Colors.grey,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
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
      ),
    );
  }
}
