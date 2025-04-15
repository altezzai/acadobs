import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  late DropdownProvider dropdownProvider;
  late StudentIdController studentIdController;
  late FilePickerProvider fileProvider;

  @override
  void initState() {
    super.initState();
    dropdownProvider = context.read<DropdownProvider>();
    studentIdController = context.read<StudentIdController>();
    fileProvider = context.read<FilePickerProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('classGrade');
      dropdownProvider.clearSelectedItem('division');
      fileProvider.clearFile('note document');
      if (studentIdController.selectedStudentIds.isNotEmpty) {
        studentIdController.clearSelection();
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
              SizedBox(height: Responsive.height * 2),
              CustomAppbar(
                title: "Add Notes",
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(AppRouteConst.NotesRouteName);
                },
              ),

              /// Class & Division Dropdowns
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'classGrade',
                      label: 'Class',
                      items: ['5', '6', '7', '8', '9', '10'],
                      icon: Icons.school,
                      onChanged: (selectedClass) {
                        final selectedDivision = context
                            .read<DropdownProvider>()
                            .getSelectedItem('division');
                        context
                            .read<StudentIdController>()
                            .getStudentsFromClassAndDivision(
                              className: selectedClass,
                              section: selectedDivision,
                            );
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
                            .getSelectedItem('classGrade');
                        context
                            .read<StudentIdController>()
                            .getStudentsFromClassAndDivision(
                              className: selectedClass,
                              section: selectedDivision,
                            );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.height * 2),

              /// Selected Students Field
              Text("Selected students:"),
              SizedBox(height: 10),

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
                    // Get names of selected students
                    String selectedStudentNames = value.selectedStudentIds
                        .map((id) => value.students.firstWhere(
                            (student) => student['id'] == id,
                            orElse: () => {'full_name': ''})['full_name'])
                        .where((name) => name.isNotEmpty)
                        .join(", ");

                    return TextFormField(
                      decoration: InputDecoration(
                        hintText: selectedStudentNames.isEmpty
                            ? "Select Students"
                            : selectedStudentNames,
                        enabled: false,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: Responsive.height * 2),

              /// Note Details
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Note Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Responsive.height * 1),

              CustomTextfield(
                hintText: 'Title',
                controller: _titleController,
                iconData: const Icon(Icons.title),
              ),

              SizedBox(height: Responsive.height * 1),

              CustomTextfield(
                hintText: 'Description',
                controller: _descriptionController,
                iconData: const Icon(Icons.description),
              ),

              SizedBox(height: Responsive.height * 2),

              /// File Picker
              CustomFilePicker(
                label: 'Document',
                fieldName: 'note document',
              ),

              SizedBox(height: Responsive.height * 2),

              /// Submit Button
              Consumer2<StudentIdController, NotesController>(
                builder: (context, studentController, notesController, child) {
                  final studentIds = studentController.selectedStudentIds;
                  log("Selected student IDs: ${studentIds.toString()}");

                  return CommonButton(
                    onPressed: () async {
                      await context.read<NotesController>().addParentNote(
                            context: context,
                            studentIds: studentIds,
                            title: _titleController.text,
                            description: _descriptionController.text,
                          );

                      // Clear selections after submission
                      studentController.clearSelection();
                      _titleController.clear();
                      _descriptionController.clear();
                      fileProvider.clearFile('note document');

                      // Notify UI update
                      setState(() {});
                    },
                    widget: notesController.isloadingTwo
                        ? ButtonLoading()
                        : Text('Submit'),
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
