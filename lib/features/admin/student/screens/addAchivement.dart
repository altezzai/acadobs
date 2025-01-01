import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';

class AddAchievementPage extends StatefulWidget {
  final int studentId;

  const AddAchievementPage({super.key, required this.studentId});
  @override
  _AddAchievementPageState createState() => _AddAchievementPageState();
}

class _AddAchievementPageState extends State<AddAchievementPage> {
  // final _formKey = GlobalKey<FormState>();
  // DateTime? selectedDate;
  // String? selectedClass;
  // String? selectedDivision;
  String? studentName;
  // String? selectedLevel;
  String? selectedFile;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();

  // void _handleDateSelection(DateTime date) {
  //   setState(() {
  //     selectedDate = date; // Update the selected date
  //   });
  // }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.single.name;
      });
    } else {
      print('No file selected');
    }
  }

  // void _showCalendar() {
  //   // Show the calendar dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: CustomCalendar(
  //           onSelectDate: (date) {
  //             _handleDateSelection(date);
  //             Navigator.of(context)
  //                 .pop(); // Close the dialog after selecting a date
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Achievement',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CustomDropdown(
            //   dropdownKey: 'class',
            //   label: 'Class',
            //   items: ['V', 'VI', 'VII', 'VIII', 'IX', 'X'],
            //   icon: Icons.class_,
            // ),
            // SizedBox(height: 16),

            // CustomDropdown(
            //   dropdownKey: 'division',
            //   label: 'Division',
            //   items: ['A', 'B', 'C'],
            //   icon: Icons.category,
            // ),

            // SizedBox(height: 13),

            // CustomTextfield(
            //   hintText: 'Student Name',
            //   iconData: Icon(Icons.person),
            //   onChanged: (value) {
            //     setState(() {
            //       studentName = value;
            //     });
            //   },
            // ),
            // SizedBox(height: 24),

            Text(
              'Achievement details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            CustomTextfield(
              hintText: 'Title',
              controller: _titleController,
              iconData: Icon(Icons.title),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Description',
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Colors.grey, // Change label text color here
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 75.0), // Adjust this value to your needs
                  child: Icon(Icons.description),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 16),
            CustomDropdown(
              dropdownKey: 'category',
              label: 'Category',
              items: [
                'Academic',
                'Extracurricular',
                'Sports',
                'Cultural',
                'Research'
              ],
              icon: Icons.category,
            ),

            SizedBox(height: 16),
            CustomDropdown(
              dropdownKey: 'level',
              label: 'Level',
              items: [
                'Class',
                'School',
                'District',
                'State',
                'National',
                'International'
              ],
              icon: Icons.star,
            ),
            SizedBox(height: 16),

            CustomTextfield(
              hintText: 'Awarding Body',
              controller: _awardController,
              iconData: Icon(Icons.add_moderator_outlined),
            ),

            SizedBox(height: 16),

            // Date field styled similarly to the other text fields
            CustomDatePicker(
              label: "Date",
              dateController: _dateController, // Unique controller for end date
              onDateSelected: (selectedDate) {
                print("End Date selected: $selectedDate");
              },
            ),
            SizedBox(height: 16),

            GestureDetector(
              onTap: pickFile,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                child: Row(
                  children: [
                    Icon(Icons.attachment_rounded, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedFile ?? 'Student Photo',
                        style: TextStyle(
                            color: selectedFile != null
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),

            Center(
              child: Consumer<AchievementController>(
                  builder: (context, value, child) {
                return CommonButton(
                  onPressed: () {
                    final category = context
                        .read<DropdownProvider>()
                        .getSelectedItem('category');
                    final level = context
                        .read<DropdownProvider>()
                        .getSelectedItem('level');
                    // final studentId = context
                    //     .read<StudentIdController>()
                    //     .getSelectedStudentId();

                    // log(">>>>>>>>>>>>${studentId}");
                    context.read<AchievementController>().addAchievement(
                        context,
                        studentId: widget.studentId,
                        achievement_title: _titleController.text,
                        description: _descriptionController.text,
                        category: category,
                        level: level,
                        awarding_body: _awardController.text,
                        date_of_achievement: _dateController.text);
                  },
                  widget: value.isloadingTwo ? ButtonLoading() : Text('Submit'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
