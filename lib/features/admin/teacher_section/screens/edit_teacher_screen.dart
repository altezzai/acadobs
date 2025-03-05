import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';

class EditTeacherScreen extends StatefulWidget {
  final Teacher teacher;
  const EditTeacherScreen({Key? key, required this.teacher}) : super(key: key);

  @override
  _EditTeacherScreenState createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late FilePickerProvider filePickerProvider;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the teacher data
    _nameController =
        TextEditingController(text: widget.teacher.fullName ?? "");
    // _dateOfBirthController =
    //     TextEditingController(text: widget.teacher.dateOfBirth??Dta);
    _addressController =
        TextEditingController(text: widget.teacher.address?.name ?? "");
    _phoneController =
        TextEditingController(text: widget.teacher.contactNumber ?? "");
    _emailController =
        TextEditingController(text: widget.teacher.emailAddress ?? "");
    filePickerProvider = context.read<FilePickerProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filePickerProvider.clearFile('profile photo');
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    filePickerProvider.clearFile('profile photo');
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.height * 1),
              CustomAppbar(
                title: "Edit Teacher",
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Teacher Details',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: Responsive.height * 2),
              CustomTextfield(
                controller: _nameController,
                label: 'Name',
                iconData: const Icon(Icons.person),
              ),
              SizedBox(height: Responsive.height * 1),
              TextField(
                controller: _emailController,
                enabled: false,
              ),
              SizedBox(height: Responsive.height * 1),
              CustomTextfield(
                controller: _addressController,
                label: 'Address',
                iconData: const Icon(Icons.location_on),
                keyBoardtype: TextInputType.streetAddress,
              ),
              SizedBox(height: Responsive.height * 1),
              CustomTextfield(
                controller: _phoneController,
                label: 'Phone Number',
                iconData: const Icon(Icons.phone),
                keyBoardtype: TextInputType.phone,
              ),
              SizedBox(height: Responsive.height * 1),
              CustomFilePicker(
                label: 'Teacher Photo',
                fieldName: 'profile photo',
              ),
              SizedBox(height: Responsive.height * 10),
              Consumer<TeacherController>(
                builder: (context, value, child) {
                  return CommonButton(
                    onPressed: () {
                      final profilePhoto = context
                          .read<FilePickerProvider>()
                          .getFile('profile photo');
                      final profilePhotoPath = profilePhoto?.path;

                      context.read<TeacherController>().editTeacher(
                            context,
                            teacherId: widget.teacher.id ?? 0,
                            fullName: _nameController.text,
                            email: widget.teacher.emailAddress ?? "",
                            address: _addressController.text,
                            contactNumber: _phoneController.text,
                            profilePhoto: profilePhotoPath,
                          );
                    },
                    widget: value.isloadingTwo
                        ? ButtonLoading()
                        : const Text('Edit Teacher'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
