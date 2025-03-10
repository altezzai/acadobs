import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/notices/models/notice_model.dart';

class EditNoticeScreen extends StatefulWidget {
  final Notice notice;
  const EditNoticeScreen({
    super.key,
    required this.notice,
  });

  @override
  State<EditNoticeScreen> createState() => _EditNoticeScreenState();
}

class _EditNoticeScreenState extends State<EditNoticeScreen> {
  String? selectedDivision;
  String? selectedClass;
  String? selectedAudience;
  String? selectedFile;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late DropdownProvider dropdownProvider;
  late FilePickerProvider filePickerProvider;
  @override
  @override
  void initState() {
    super.initState();

    dropdownProvider = Provider.of<DropdownProvider>(context, listen: false);
    filePickerProvider = context.read<FilePickerProvider>();

    // Initialize text fields with values from the notice
    _titleController.text = widget.notice.title ?? "";
    _descriptionController.text = widget.notice.description ?? "";
    _dateController.text = widget.notice.date != null
        ? DateFormat('yyyy-MM-dd').format(widget.notice.date as DateTime)
        : "";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // dropdownProvider.clearSelectedItem('class');
      // dropdownProvider.clearSelectedItem('division');
      // dropdownProvider.clearSelectedItem('targetAudience');
      filePickerProvider.clearFile('notice file');

      // Initialize dropdown selections if values exist in the notice
      if (widget.notice.audienceType != null) {
        dropdownProvider.setSelectedItem(
            'targetAudience', widget.notice.audienceType!);
      }
      if (widget.notice.noticeClass != null) {
        dropdownProvider.setSelectedItem('class', widget.notice.noticeClass!);
      }
      if (widget.notice.division != null) {
        dropdownProvider.setSelectedItem('division', widget.notice.division!);
      }
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
              title: "Edit Notice",
              isProfileIcon: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Target audience',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: Responsive.height * 2),
            // Target Audience Dropdown
            CustomDropdown(
              dropdownKey: 'targetAudience',
              label: 'Select Audience',
              icon: Icons.school,
              items: ['All', 'Specific Class'],
            ),
            SizedBox(height: Responsive.height * 2),
            // Row for Class and Division Dropdowns
            Consumer<DropdownProvider>(builder: (context, value, child) {
              final dropdownValue = value.getSelectedItem('targetAudience');
              return dropdownValue == 'All'
                  ? SizedBox.shrink()
                  : Row(
                      children: [
                        // Expanded dropdown for Class
                        Expanded(
                          child: CustomDropdown(
                            dropdownKey: 'class',
                            label: 'Class',
                            icon: Icons.school,
                            items: AppConstants.classNames,
                          ),
                        ),
                        SizedBox(width: 16), // Space between the dropdowns
                        // Expanded dropdown for Division
                        Expanded(
                          child: CustomDropdown(
                            dropdownKey: 'division',
                            label: 'Division',
                            icon: Icons.group,
                            items: AppConstants.divisions,
                          ),
                        ),
                      ],
                    );
            }),
            SizedBox(height: 16),
            // Date Picker
            CustomDatePicker(
              label: "Date",
              dateController: _dateController, // Unique controller for end date
              lastDate: DateTime(2026),
              onDateSelected: (selectedDate) {
                print("End Date selected: $selectedDate");
              },
            ),
            SizedBox(height: Responsive.height * 3),
            Text(
              'Notice Details',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),

            CustomTextfield(
              controller: _titleController,
              // hintText: 'Title',
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
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),

            SizedBox(height: 16),
            CustomFilePicker(
              label: 'Add Receipt (Maximum file size: 5MB)',
              fieldName: 'notice file',
            ),
            SizedBox(height: 40),
            Consumer<NoticeController>(builder: (context, value, child) {
              return CommonButton(
                onPressed: () {
                  final selected_Audience = context
                      .read<DropdownProvider>()
                      .getSelectedItem('targetAudience');
                  String selectedClass =
                      context.read<DropdownProvider>().getSelectedItem('class');
                  String selectedDivision = context
                      .read<DropdownProvider>()
                      .getSelectedItem('division');
                  context.read<NoticeController>().editNotice(context,
                      noticeId: widget.notice.id ?? 0,
                      className: selectedClass,
                      division: selectedDivision,
                      audience_type: selected_Audience,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: _dateController.text);
                },
                widget: value.isloadingTwo ? Loading() : Text('Submit'),
              );
            }),
          ],
        ),
      ),
    ));
  }
}
