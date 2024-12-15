import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
//import 'package:go_router/go_router.dart';
//import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';

class AddNote extends StatefulWidget {
  final Student student; // Replace with int studentId if only ID is passed

  const AddNote({required this.student});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  // String? selectedClass;
  // String? selectedDivision;
  // String? selectedStudent;
  String? selectedFile;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomAppbar(
                title: "Add Notes",
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(
                    AppRouteConst.NotesRouteName,
                  );
                },
              ),
              // SizedBox(
              //   height: Responsive.height * 1,
              // ),
              // Row(
              //   children: [
              //     // Class Dropdown
              //     Expanded(
              //       child: CustomDropdown(
              //         dropdownKey: 'class',
              //         label: 'Class',
              //         items: ['5', '6', '7', '8', '9', '10'],
              //         icon: Icons.school,
              //       ),
              //     ),
              //     SizedBox(
              //       width: Responsive.width * 1,
              //     ),

              //     // Division Dropdown
              //     Expanded(
              //       child: CustomDropdown(
              //         dropdownKey: 'division',
              //         label: 'Division',
              //         items: ['A', 'B', 'C'],
              //         icon: Icons.group,
              //       ),
              //     ),
              //   ],
              // ),

              // SizedBox(
              //   height: Responsive.height * 1,
              // ),
              // CustomDropdown(
              //   dropdownKey: 'selectedStudent',
              //   label: 'Select Student',
              //   items: ['A', 'B', 'C'],
              //   icon: Icons.person,
              // ),
              // SizedBox(
              //   height: Responsive.height * 1,
              // ),
              const Align(
                alignment: Alignment.centerLeft, // Aligns the text to the left
                child: Text(
                  'Note Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: 'Title',
                controller: _titleController,
                iconData: const Icon(Icons.description),
              ),

              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: 'Description',
                controller: _descriptionController,
                iconData: const Icon(Icons.description),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomFilePicker(
                label: 'Document',
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CommonButton(
                onPressed: () {
                  context.read<NotesController>().addParentNote(
                      context: context,
                      studentId: widget.student.id ?? 0,
                      title: _titleController.text,
                      description: _descriptionController.text);
                },
                widget: Text('Submit'),
              ),
              // CustomButton(text: 'Submit', onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}
