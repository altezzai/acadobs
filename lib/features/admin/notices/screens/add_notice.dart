import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';

class AddNoticePage extends StatefulWidget {
  @override
  _AddNoticePageState createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  String? selectedDivision;
  String? selectedClass;
  String? selectedAudience;
  String? selectedFile;
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late DropdownProvider dropdownProvider;
  late FilePickerProvider filePickerProvider;
  @override
  void initState() {
    super.initState();
    dropdownProvider = Provider.of<DropdownProvider>(context, listen: false);
    filePickerProvider = context.read<FilePickerProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('targetAudience');
      filePickerProvider.clearFile();
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
              title: "Add Notice",
              isProfileIcon: false,
              onTap: () {
                context.pushNamed(AppRouteConst.bottomNavRouteName,
                    extra: UserType.admin);
              },
            ),
            Text(
              'Target audience',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
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
                            label: 'Select Class',
                            icon: Icons.school,
                            items: ['8', '9', '10'],
                          ),
                        ),
                        SizedBox(width: 16), // Space between the dropdowns
                        // Expanded dropdown for Division
                        Expanded(
                          child: CustomDropdown(
                            dropdownKey: 'division',
                            label: 'Select Division',
                            icon: Icons.group,
                            items: ['A', 'B', 'C'],
                          ),
                        ),
                      ],
                    );
            }),
            SizedBox(height: 16),
            // Date Picker
            CustomDatePicker(
              label: "dd-mm-yyyy",
              dateController: _dateController, // Unique controller for end date
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

            // Title Input
            CustomTextfield(
              controller: _titleController,
              // hintText: 'Title',
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
            CustomFilePicker(label: "Add Receipt"),
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
                  context.read<NoticeController>().addNotice(context,
                      className: selectedClass,
                      division: selectedDivision,
                      audience_type: selected_Audience,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: _dateController.text);
                },
                widget: value.isloading ? Loading() : Text('Submit'),
              );
            }),
            // Center(
            //   child: CustomButton(
            //     text: 'Submit',
            //     onPressed: () {
            //       final selected_Audience = context
            //           .read<DropdownProvider>()
            //           .getSelectedItem('targetAudience');
            //       String selectedClass =
            //           context.read<DropdownProvider>().getSelectedItem('class');
            //       String selectedDivision = context
            //           .read<DropdownProvider>()
            //           .getSelectedItem('division');
            //       context.read<NoticeController>().addNotice(context,
            //           className: selectedClass,
            //           division: selectedDivision,
            //           audience_type: selected_Audience,
            //           title: _titleController.text,
            //           description: _descriptionController.text,
            //           date: _dateController.text);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}
