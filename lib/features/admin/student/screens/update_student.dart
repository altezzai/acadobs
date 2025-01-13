import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  const EditStudentScreen({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  late FilePickerProvider filePickerProvider;
  late StudentController studentController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _parentEmailController = TextEditingController();
  final TextEditingController _fatherContactController =
      TextEditingController();
  final TextEditingController _motherContactController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    filePickerProvider = context.read<FilePickerProvider>();

    // Initialize form fields
    _nameController.text = widget.student.fullName ?? '';
    _classController.text = widget.student.studentClass ?? '';
    _sectionController.text = widget.student.section ?? '';
    _phoneController.text = widget.student.contactNumber ?? '';
    _emailController.text = widget.student.email ?? '';
    // _parentEmailController.text = widget.student.parentEmail ?? '';
    _fatherContactController.text = widget.student.fatherContactNumber ?? '';
    _motherContactController.text = widget.student.motherContactNumber ?? '';

    // Clear file paths for the edit screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filePickerProvider.clearFile('student photo');
      filePickerProvider.clearFile('parent photo');
      studentController = context.read<StudentController>();
      studentController.getIndividualStudentDetails(
          studentId: widget.student.id ?? 0);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _sectionController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    // _parentEmailController.dispose();
    _fatherContactController.dispose();
    _motherContactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  title: 'Edit Student',
                  isProfileIcon: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                CustomTextfield(
                  iconData: Icon(Icons.person),
                  hintText: 'Enter Student Name',
                  controller: _nameController,
                ),
                SizedBox(height: Responsive.height * 2),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        iconData: Icon(Icons.class_),
                        hintText: 'Enter Class',
                        controller: _classController,
                      ),
                    ),
                    SizedBox(width: Responsive.width * 2),
                    Expanded(
                      child: CustomTextfield(
                        iconData: Icon(Icons.group),
                        hintText: 'Enter Division',
                        controller: _sectionController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height * 2),
                CustomTextfield(
                  iconData: Icon(Icons.phone),
                  hintText: 'Enter Phone Number',
                  controller: _phoneController,
                ),
                SizedBox(height: Responsive.height * 2),
                CustomTextfield(
                  iconData: Icon(Icons.email),
                  hintText: 'Enter Email',
                  controller: _emailController,
                ),
                // SizedBox(height: Responsive.height * 2),
                // CustomTextfield(
                //   iconData: Icon(Icons.email_outlined),
                //   hintText: 'Enter Parent Email',
                //   controller: _parentEmailController,
                // ),
                SizedBox(height: Responsive.height * 2),
                CustomTextfield(
                  iconData: Icon(Icons.phone_android),
                  hintText: 'Enter Father\'s Contact Number',
                  controller: _fatherContactController,
                ),
                SizedBox(height: Responsive.height * 2),
                CustomTextfield(
                  iconData: Icon(Icons.phone_android),
                  hintText: 'Enter Mother\'s Contact Number',
                  controller: _motherContactController,
                ),
                SizedBox(height: Responsive.height * 2),
                CustomFilePicker(
                  label: 'Student Photo',
                  fieldName: 'student photo',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),
                CustomFilePicker(
                  label: 'Parent Photo',
                  fieldName: 'parent photo',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.height * 2),
                Consumer<StudentController>(
                  builder: (context, loadingController, child) {
                    return CommonButton(
                      onPressed: () {
                        // Retrieve selected files
                        final selectedStudentPhoto = context
                            .read<FilePickerProvider>()
                            .getFile('student photo');

                        final parentPhoto = context
                            .read<FilePickerProvider>()
                            .getFile('parent photo');

                        // Extract paths, handling null values
                        final studentPhotoPath = selectedStudentPhoto?.path;
                        final parentPhotoPath = parentPhoto?.path;

                        // Call updateStudent with conditional handling for photo paths
                        context.read<StudentController>().updateStudent(
                              context,
                              studentId: widget.student.id ?? 0,
                              fullName: _nameController.text.trim(),
                              studentClass: _classController.text.trim(),
                              section: _sectionController.text.trim(),
                              contactNumber: _phoneController.text.trim(),
                              email: _emailController.text.trim(),
                              fatherContactNumber:
                                  _fatherContactController.text.trim(),
                              motherContactNumber:
                                  _motherContactController.text.trim(),
                              studentPhoto: studentPhotoPath ??
                                  "", // Pass null if not selected
                              fatherMotherPhoto: parentPhotoPath ??
                                  "", // Pass null if not selected
                            );
                      },
                      widget: loadingController.isLoadingTwo
                          ? ButtonLoading()
                          : Text('Update'),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
