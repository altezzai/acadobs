import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/notices/models/event_model.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;
  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
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
    noticeController.getSingleEvent(eventId: widget.event.eventId ?? 0);
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
              CustomAppbar(
                title: "Edit Event",
                isProfileIcon: false,
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: Responsive.height * 2),
              Text('Event Details', style: TextStyle(fontSize: 16)),
              SizedBox(height: 12),
              Consumer<NoticeController>(
                builder: (context, noticeController, _) {
                  final newImages = noticeController.chosenFiles;
                  final existingImages = noticeController.singleevent[0].images;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...existingImages!.asMap().entries.map((entry) {
                            String imageUrl =
                                "${baseUrl}${Urls.eventPhotos}${entry.value.imagePath}";
                            return _buildSmallImageTile(
                              image: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error, color: Colors.red),
                              ),
                              onRemove: () => noticeController.deleteEventImage(
                                  context,
                                  imageId: entry.value.imageId ?? 0,
                                  eventId:
                                      noticeController.singleevent[0].eventId ??
                                          0),
                            );
                          }).toList(),
                          ...newImages!.asMap().entries.map((entry) {
                            File file = File(entry.value.path);
                            return _buildSmallImageTile(
                              image: Image.file(file, fit: BoxFit.cover),
                              onRemove: () {
                                print(
                                    "Cross icon tapped! Removing image at index: ${entry.key}");
                                noticeController.removeImage(entry.key);
                              },
                            );
                          }).toList(),
                        ],
                      ),
                      SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => noticeController.pickMultipleImages(),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, size: 40),
                                SizedBox(height: 8),
                                Text('Add More Images',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: Responsive.height * 2),
              CustomTextfield(
                  controller: _titleController,
                  label: 'Title',
                  iconData: Icon(Icons.title)),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write here....',
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 75.0),
                    child: Icon(Icons.description),
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomDatePicker(
                label: "dd-mm-yyyy",
                lastDate: DateTime(2026),
                dateController: _dateController,
                onDateSelected: (selectedDate) =>
                    print("Event Date selected: $selectedDate"),
              ),
              SizedBox(height: 16),
              Consumer<NoticeController>(
                builder: (context, value, child) {
                  return CommonButton(
                    onPressed: () {
                      noticeController.editEvent(
                        context,
                        eventId: widget.event.eventId ?? 0,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        date: _dateController.text,
                      );
                    },
                    widget: value.isloadingTwo ? Loading() : Text('Edit Event'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallImageTile(
      {required Widget image, required VoidCallback onRemove}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(height: 60, width: 60, child: image),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              print("Cross icon tapped! Calling onRemove...");
              onRemove(); // Call the remove function
            },
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Icon(Icons.close, color: Colors.white, size: 12),
            ),
          ),
        ),
      ],
    );
  }
}
