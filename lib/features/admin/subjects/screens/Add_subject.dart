import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/form_validators.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/features/superadmin/school_subjects/controller/school_subjects_controller.dart';

class AddSubject extends StatefulWidget {
  final bool fromSchoolAdmin;
  const AddSubject({super.key, required this.fromSchoolAdmin});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final TextEditingController _subjectNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Clear the selected item in the dropdown when the widget is built
      context.read<DropdownProvider>().clearSelectedItem('classRange');
    });
  }

  @override
  void dispose() {
    _subjectNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.width * 4,
        ), // Responsive padding
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.height * 1),
              CustomAppbar(
                title: 'Add Subject',
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: Responsive.height * 2),
              CustomTextfield(
                iconData: Icon(Icons.title),
                // hintText: 'Subject Name',
                label: "Subject Name*",
                controller: _subjectNameController,
                validator: (value) =>
                    FormValidator.validateNotEmpty(value, fieldName: "Name"),
              ),
              SizedBox(height: Responsive.height * 2),
              CustomDropdown(
                  dropdownKey: 'classRange',
                  label: "Class Range",
                  icon: Icons.school,
                  items: ["1-4", "5-7", "8-10", "11-12", "other"]),

              SizedBox(height: Responsive.height * 2),
              // Add button
              Padding(
                padding: EdgeInsets.only(bottom: Responsive.height * 4),
                child: Consumer2<SubjectController, SchoolSubjectsController>(
                  builder: (context, schoolAdminController,
                      superAdminController, child) {
                    return CommonButton(
                      onPressed: () {
                        final classRange = context
                            .read<DropdownProvider>()
                            .getSelectedItem('classRange');
                        if (_formKey.currentState?.validate() ?? false) {
                          widget.fromSchoolAdmin
                              ? context
                                  .read<SubjectController>()
                                  .addNewSubjects(
                                    context,
                                    subject: _subjectNameController.text,
                                    description: classRange,
                                  )
                              : context
                                  .read<SchoolSubjectsController>()
                                  .addNewSubject(
                                    context,
                                    subjectName: _subjectNameController.text,
                                    classRange: classRange,
                                  );
                        }
                      },
                      widget: widget.fromSchoolAdmin
                          ? schoolAdminController.isloadingTwo
                              ? Loading()
                              : Text('Add')
                          : superAdminController.isLoadingTwo
                              ? Loading()
                              : Text('Add'),
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
