import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
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

  late NoticeController noticeController;
  @override
  void initState() {
    super.initState();
    noticeController = Provider.of<NoticeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      noticeController.clearSelectedImages();
    });
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
                  context.pushNamed(AppRouteConst.bottomNavRouteName,
                      extra: UserType.admin);
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
              SizedBox(height: 12),

              // Add Cover Photo
              GestureDetector(
                onTap: () {
                  context.read<NoticeController>().pickMultipleImages();
                },
                child: Consumer<NoticeController>(
                  builder: (context, noticeController, _) {
                    final files =
                        noticeController.chosenFiles; // Access the chosen files
                    return Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: files != null && files.isNotEmpty
                          ? ListView.builder(
                              scrollDirection:
                                  Axis.horizontal, // Horizontal scrolling
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(files[index].path),
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 100, // Adjust width as needed
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, size: 40),
                                  SizedBox(height: 8),
                                  Text(
                                    'Add Event images',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
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
