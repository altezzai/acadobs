import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/superadmin/models/school_subject_model.dart';
import 'package:school_app/features/superadmin/school_subjects/controller/school_subjects_controller.dart';

class EditSubjectPage extends StatefulWidget {
  final SchoolSubject subjects;
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
  late DropdownProvider dropdownProvider;

  @override
  void initState() {
    super.initState();
    dropdownProvider = Provider.of<DropdownProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.setSelectedItem(
          'classRange', widget.subjects.classRange);
    });
    _editedSubjectNameController.text =
        capitalizeEachWord(widget.subjects.subjectName);
    _editedSubjectDescriptionController.text =
        capitalizeEachWord(widget.subjects.classRange);
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
              onTap: () => Navigator.pop(context),
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
              child: Text("Class Range:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomDropdown(
                dropdownKey: 'classRange',
                label: "Class Range",
                icon: Icons.school,
                items: ["1-4", "5-7", "8-10", "11-12", "other"]),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: Responsive.height * 4),
              child: Consumer<SchoolSubjectsController>(
                  builder: (context, value, child) {
                return CommonButton(
                  onPressed: () {
                    final selectedClassRange =
                        dropdownProvider.getSelectedItem('classRange');
                    context.read<SchoolSubjectsController>().editSubject(
                          context,
                          subjectId: widget.subjects.id,
                          subjectName: _editedSubjectNameController.text,
                          classRange: selectedClassRange,
                        );
                  },
                  widget: value.isLoadingTwo ? Loading() : Text('Update'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
