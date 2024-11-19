import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  String? selectedFile;
  String? coverPhoto;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first.name;
      });
    }
  }

  Future<void> pickCoverPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        coverPhoto = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Custom AppBar
              CustomAppbar(
                title: "Add Event",
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),

              // Event Details Heading
              Text(
                'Event Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),

              // Add Cover Photo
              // GestureDetector(
              //   onTap: pickCoverPhoto, // Call pickCoverPhoto here
              //   child: Container(
              //     height: 150,
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey),
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     child: Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(Icons.camera_alt, size: 40),
              //           SizedBox(height: 8),
              //           Text(
              //             coverPhoto ?? 'Add Cover Photo',
              //             style: TextStyle(fontSize: 16),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),

              // Add Cover Photo
              GestureDetector(
                onTap: () {
                  context
                      .read<NoticeController>()
                      .pickImage(ImageSource.gallery);
                },
                child: Consumer<NoticeController>(
                  builder: (context, noticeController, _) {
                    final file = noticeController.chosenFile;
                    return Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                        image: file != null
                            ? DecorationImage(
                                image: FileImage(File(file.path)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: file == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, size: 40),
                                  SizedBox(height: 8),
                                  Text(
                                    'Add Cover Photo',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // Title Input (styled similar to Add Notice)
              CustomTextfield(
                controller: _titleController,
                label: 'Title',
                iconData: Icon(Icons.title),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Description Input
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write here....',
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: Colors.grey, // Change label text color here
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 75.0), // Adjust this value to your needs
                    child: Icon(Icons.description),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),

              SizedBox(height: 16),

              // Date Picker (styled similar to Add Notice)
              CustomDatePicker(
                label: "dd-mm-yyyy",
                dateController: _dateController,
                onDateSelected: (selectedDate) {
                  print("Event Date selected: $selectedDate");
                },
              ),
              SizedBox(height: 16),

              // Document Upload Button (styled like Add Notice)
              GestureDetector(
                onTap: pickFile,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
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

              // Submit Button
              Center(
                child: CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    context.read<NoticeController>().addEvent(
                          context,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date: _dateController.text,
                          coverPhoto:
                              coverPhoto, // Use the selected cover photo
                        );
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
