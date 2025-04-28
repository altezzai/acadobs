import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/superadmin/models/school_model.dart';
import 'package:school_app/features/superadmin/schools/controller/school_controller.dart';

class EditSchoolPage extends StatefulWidget {
  final School school;

  const EditSchoolPage({
    super.key,
    required this.school,
  });

  @override
  State<EditSchoolPage> createState() => _EditSchoolPageState();
}

class _EditSchoolPageState extends State<EditSchoolPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.school.name);
    _emailController = TextEditingController(text: widget.school.email);
    _phoneController = TextEditingController(text: widget.school.phone);
    _addressController = TextEditingController(text: widget.school.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.height * 2),
            CustomAppbar(
              title: 'Edit School',
              isProfileIcon: false,
              onTap: () => Navigator.pop(context),
            ),

            // School Name
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("School Name:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.school),
              hintText: 'Enter School Name',
              controller: _nameController,
            ),
            SizedBox(height: Responsive.height * 2),

            // Email
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Email:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.email),
              hintText: 'Enter Email',
              controller: _emailController,
            ),
            SizedBox(height: Responsive.height * 2),

            // Phone
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Phone:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.phone),
              hintText: 'Enter Phone Number',
              controller: _phoneController,
            ),
            SizedBox(height: Responsive.height * 2),

            // Address
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Address:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.location_on),
              hintText: 'Enter Address',
              controller: _addressController,
            ),
            SizedBox(height: Responsive.height * 2),

            // File Picker (Optional)

            SizedBox(height: Responsive.height * 1),
            CustomFilePicker(
              label: "Upload Logo:",
              fieldName: "logo",
            ),

            Spacer(),

            // Update Button
            Padding(
              padding: EdgeInsets.only(bottom: Responsive.height * 4),
              child: Consumer<SchoolController>(
                builder: (context, controller, child) {
                  return CommonButton(
                    onPressed: () {
                      // Only pass data to controller
                      context.read<SchoolController>().editSchool(
                            context,
                            schoolId: widget.school.id,
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            phone: _phoneController.text.trim(),
                            address: _addressController.text.trim(),
                          );
                    },
                    widget:
                        controller.isLoading ? Loading() : const Text('Update'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
