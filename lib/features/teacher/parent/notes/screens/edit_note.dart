import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
//import 'package:go_router/go_router.dart';
//import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';
import 'package:school_app/features/teacher/parent/model/parent_note_model.dart';

class EditNote extends StatefulWidget {
  final ParentNote note;
  const EditNote({
    super.key,
    required this.note,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  String? selectedFile;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  late DropdownProvider dropdownProvider;
  late StudentIdController studentIdController;
  late FilePickerProvider fileprovider;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.data?.noteTitle ?? "";
    _descriptionController.text = widget.note.data?.noteContent ?? "";

    dropdownProvider = context.read<DropdownProvider>();
    studentIdController = context.read<StudentIdController>();
    fileprovider = context.read<FilePickerProvider>();
    // Clear dropdown selections when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('classGrade');
      dropdownProvider.clearSelectedItem('division');
      fileprovider.clearFile('note document');
      if (studentIdController.selectedStudentIds.isNotEmpty) {
        studentIdController.clearStudentIdsSelection();
      }
    });
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
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomAppbar(
                title: "Edit Note",
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(
                    AppRouteConst.NotesRouteName,
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'classGrade',
                      label: 'Class',
                      items: ['8', '9', '10'],
                      icon: Icons.school,
                      onChanged: (selectedClass) {
                        final selectedDivision = context
                            .read<DropdownProvider>()
                            .getSelectedItem('division');
                        context
                            .read<StudentIdController>()
                            .getStudentsFromClassAndDivision(
                                className: selectedClass,
                                section: selectedDivision);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'division',
                      label: 'Division',
                      items: ['A', 'B', 'C'],
                      icon: Icons.group,
                      onChanged: (selectedDivision) {
                        final selectedClass = context
                            .read<DropdownProvider>()
                            .getSelectedItem('class');
                        context
                            .read<StudentIdController>()
                            .getStudentsFromClassAndDivision(
                                className: selectedClass,
                                section: selectedDivision);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 2),
              Text("Selected students:"),
              SizedBox(height: 10),
              // Select Staffs
              InkWell(
                onTap: () {
                  final classGrade = context
                      .read<DropdownProvider>()
                      .getSelectedItem('classGrade');
                  final division = context
                      .read<DropdownProvider>()
                      .getSelectedItem('division');
                  final classAndDivision = ClassAndDivision(
                      className: classGrade, section: division);
                  context.pushNamed(AppRouteConst.studentSelectionRouteName,
                      extra: classAndDivision);
                },
                child: Consumer<StudentIdController>(
                  builder: (context, value, child) {
                    return TextFormField(
                      decoration: InputDecoration(
                        hintText: "Select Students",
                        enabled: false,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
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
                fieldName: 'note document',
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Consumer2<StudentIdController, NotesController>(
                  builder: (context, value1, value2, child) {
                final studentIds = value1.selectedStudentIds;
                log(">>>>>>>>>>>>${studentIds.toString()}");
                return CommonButton(
                  onPressed: () {
                    context.read<NotesController>().editNote(
                          noteId: widget.note.data?.id ?? 0,
                          context: context,
                          studentId: studentIds,
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );
                  },
                  widget:
                      value2.isloadingTwo ? ButtonLoading() : Text('Submit'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
