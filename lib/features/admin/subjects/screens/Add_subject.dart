import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/form_validators.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({super.key});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _subjectDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    _subjectNameController.dispose();
    _subjectDescriptionController.dispose();
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
                  context.pushNamed(AppRouteConst.SubjectsPageRouteName);
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
              CustomTextfield(
                iconData: Icon(Icons.title),
                // hintText: 'Description',
                label: "Description*",
                controller: _subjectDescriptionController,
              ),
              SizedBox(height: Responsive.height * 2),
              // Add button
              Padding(
                padding: EdgeInsets.only(bottom: Responsive.height * 4),
                child: Consumer<SubjectController>(
                  builder: (context, value, child) {
                    return CommonButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<SubjectController>().addNewSubjects(
                                context,
                                subject: _subjectNameController.text,
                                description: _subjectDescriptionController.text,
                              );
                        }
                        // else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content:
                        //           Text('Please fill in all required fields.'),
                        //     ),
                        //   );
                        // }
                      },
                      widget: value.isloadingTwo ? Loading() : Text('Add'),
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
