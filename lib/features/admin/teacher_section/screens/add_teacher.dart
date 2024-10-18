import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
import 'package:school_app/features/teacher/widgets/custom_dropdown.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  String? selectedGender;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();

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
                  context.goNamed(AppRouteConst.AdminteacherRouteName);
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
                dropdownKey: 'Gender',
                label: 'Gender',
                icon: Icons.person_2_outlined,
                items: ['male', 'female', 'other'],
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: 'Address',
                iconData: Icon(Icons.location_on),
                keyBoardtype: TextInputType.streetAddress,
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: 'Phone Number',
                iconData: Icon(Icons.phone),
                keyBoardtype: TextInputType.phone,
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: 'Email',
                iconData: Icon(Icons.email),
              ),
              SizedBox(
                height: Responsive.height * 30,
              ),
              CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    context.read<TeacherController>().addTeacher();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
