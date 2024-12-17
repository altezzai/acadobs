import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  String? selectedGender;

  // textediting controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

   late DropdownProvider dropdownProvider;
  
  late FilePickerProvider filePickerProvider;
   @override
  void initState() {
    super.initState();
    filePickerProvider = context.read<FilePickerProvider>();
    dropdownProvider=context.read<DropdownProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      filePickerProvider.clearFile('profile photo');
      dropdownProvider.clearSelectedItem('gender');

    });
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Responsive.width * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Add Teacher",
                isProfileIcon: false,
                onTap: () {
                  context.pushNamed(AppRouteConst.AdminteacherRouteName);
                },
              ),
              Text(
                'Teacher Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomTextfield(
                controller: _nameController,
                hintText: 'Name',
                iconData: Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomDatePicker(
                label: "Date of Birth",
                dateController: _dateOfBirthController,
                onDateSelected: (selectedDate) {
                  print("End Date selected: $selectedDate");
                },
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomDropdown(
                dropdownKey: 'gender',
                label: 'Gender',
                icon: Icons.person_2_outlined,
                items: ['Male', 'Female', 'Other'],
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                controller: _addressController, //Add controller
                hintText: 'Address',
                iconData: Icon(Icons.location_on),
                keyBoardtype: TextInputType.streetAddress,
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                controller: _phoneController, //Add controller
                hintText: 'Phone Number',
                iconData: Icon(Icons.phone),
                keyBoardtype: TextInputType.phone,
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                controller: _emailController, //Add controller
                hintText: 'Email',
                iconData: Icon(Icons.email),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomFilePicker(label: 'Teacher Photo', fieldName: 'profile photo',),
              SizedBox(
                height: Responsive.height * 30,
              ),
              
              Consumer<TeacherController>(builder: (context, value, child) {
                return CommonButton(
                  onPressed: () {
                    final selectedGender = context
                        .read<DropdownProvider>()
                        .getSelectedItem('gender');
                    final profilePhoto = context.read<FilePickerProvider>().getFile('profile photo');
                    final profilePhotoPath=profilePhoto?.path;
                    context.read<TeacherController>().addNewTeacher(context,
                        fullName: _nameController.text,
                        dateOfBirth: _dateOfBirthController.text,
                        gender: selectedGender,
                        address: _addressController.text,
                        contactNumber: _phoneController.text,
                        emailAddress: _emailController.text,
                        profilePhoto: profilePhotoPath);
                  },
                  widget: value.isloading ? ButtonLoading() : Text('Submit'),
                );
              })
              // CustomButton(
              //     text: 'Submit',
              //     onPressed: () {
              //       final selectedGender = context
              //           .read<DropdownProvider>()
              //           .getSelectedItem('gender');
              //       context.read<TeacherController>().addNewTeacher(context,
              //           fullName: _nameController.text,
              //           dateOfBirth: _dateOfBirthController.text,
              //           gender: selectedGender,
              //           address: _addressController.text,
              //           contactNumber: _phoneController.text,
              //           emailAddress: _emailController.text);
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
