import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/features/admin/subjects/model/subject_model.dart';

class EditSubjectPage extends StatefulWidget {
  final Subject subjects;
  const EditSubjectPage({
    super.key,
    required this.subjects,
  });

  @override
  State<EditSubjectPage> createState() => _EditSubjectPageState();
}

class _EditSubjectPageState extends State<EditSubjectPage> {
  final TextEditingController _editedSubjectNameController =
      TextEditingController();
  final TextEditingController _editedSubjectDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with existing data
    _editedSubjectNameController.text =
        capitalizeEachWord(widget.subjects.subject ?? '');
    _editedSubjectDescriptionController.text =
        capitalizeEachWord(widget.subjects.description ?? '');
    context.read<SubjectController>().getSubjects();
  }

  @override
  void dispose() {
    _editedSubjectNameController.dispose();
    _editedSubjectDescriptionController.dispose();
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
              title: 'Edit Subject',
              isProfileIcon: false,
              onTap: () =>
                  context.pushNamed(AppRouteConst.SubjectsPageRouteName),
            ),
            // SizedBox(height: Responsive.height * 2),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Subject:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.edit),
              hintText: 'Enter Subject Name',
              controller: _editedSubjectNameController,
            ),
            SizedBox(height: Responsive.height * 2),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Description:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.description),
              hintText: 'Enter Subject Description',
              controller: _editedSubjectDescriptionController,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: Responsive.height * 4),
              child: CommonButton(
                onPressed: () {
                  context.read<SubjectController>().editSubjects(
                        context,
                        subjectid: widget.subjects.id!,
                        subject: _editedSubjectNameController.text,
                        description: _editedSubjectDescriptionController.text,
                      );
                },
                widget: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
