import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';
// import 'package:school_app/features/admin/notices/models/event_model.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;
  const EditEventScreen({
    super.key,
    required this.event,
  });

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String? selectedFile;
  String? coverPhoto;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late NoticeController noticeController;
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.event.title ?? "";
    _descriptionController.text = widget.event.description ?? "";
    _dateController.text = widget.event.eventDate != null
        ? DateFormat('yyyy-MM-dd').format(widget.event.eventDate as DateTime)
        : "";
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
                title: "Edit Event",
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: Responsive.height * 2),

              // Event Details Heading
              Text(
                'Event Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),

              // Add Cover Photo
              GestureDetector(
                onTap: () {
                  context.read<NoticeController>().pickMultipleImages();
                },
                child: Consumer<NoticeController>(
                  builder: (context, noticeController, _) {
                    final files = noticeController.chosenFiles;
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
                                return Stack(
                                  children: [
                                    // Display the image
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(files[index].path),
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                    // Cancel icon to remove the image
                                    Positioned(
                                      top: 5,
                                      right: 15,
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<NoticeController>()
                                              .removeImage(index);
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.grey,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

              SizedBox(height: Responsive.height * 2),

              // Title Input (styled similar to Add Notice)
              CustomTextfield(
                controller: _titleController,
                label: 'Title',
                iconData: Icon(Icons.title),
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
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),

              SizedBox(height: 16),

              // Date Picker (styled similar to Add Notice)
              CustomDatePicker(
                label: "dd-mm-yyyy",
                lastDate: DateTime(2026),
                dateController: _dateController,
                onDateSelected: (selectedDate) {
                  print("Event Date selected: $selectedDate");
                },
                // validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Date"),
              ),
              SizedBox(height: 16),

              // Submit Button
              Consumer<NoticeController>(builder: (context, value, child) {
                return CommonButton(
                  onPressed: () {
                    context.read<NoticeController>().editEvent(
                          context,
                          eventId: widget.event.eventId ?? 0,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date: _dateController.text,
                        );
                  },
                  widget: value.isloadingTwo ? Loading() : Text('Edit Event'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
