import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/controller/dropdown_controller.dart';
import 'package:school_app/global%20widgets/custom_dropdown.dart';
import 'package:school_app/teacher_section/data/dropdown_data.dart';
import 'package:school_app/teacher_section/homework/widgets/date_picker.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class HomeWork extends StatelessWidget {
   HomeWork({super.key});

    List<DropdownMenuItem<String>> allClasses = DropdownData.allClasses;
    List<DropdownMenuItem<String>> allDivisions = DropdownData.allDivisions;


  @override
  Widget build(BuildContext context) {
    final dropdownProvider = Provider.of<DropdownProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Center(
          child: Text(
            'Add Homework',
            style:
                textThemeData.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height * 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      title: 'Select  Class',
                      icon: Icons.school,
                      items: allClasses,
                      selectedValue: dropdownProvider.selectedClass,
                      onChanged: (value) {
                        dropdownProvider.setSelectedClass(
                            value); // Update the state using provider
                      },
                    ),
                  ),
                  SizedBox(width: Responsive.width * 6),
                  Expanded(
                    child: CustomDropdown(
                      title: 'Select Division',
                      icon: Icons.school,
                      items: allDivisions,
                      selectedValue: dropdownProvider.selectedDivision,
                      onChanged: (value) {
                        dropdownProvider.setSelectedDivision(
                            value); // Update the state using provider
                      },
                    ),
                  ),
                ],
              ),
              // SizedBox(height: Responsive.height * 2),
              // const CustomDropdown(title: "Select Student", icon: Icons.person),
              // SizedBox(height: Responsive.height * 2),
              // const CustomDropdown(title: "Select Subject", icon: Icons.note),
              SizedBox(height: Responsive.height * 2),
              Row(
                children: [
                  const DatePicker(title: "Start Date"),
                  SizedBox(width: Responsive.width * 2),
                  const DatePicker(title: "End Date")
                ],
              ),
              SizedBox(height: Responsive.height * 2),
              CustomTextfield(
                hintText: "Total Mark",
                iconData: const Icon(Icons.book),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                'Homework details',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: "Title",
                iconData: const Icon(Icons.text_fields),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                cursorHeight: 25.0, // Sets the cursor height
                style: const TextStyle(fontSize: 16),
                minLines: 4,
                maxLines: null,
              ),
              SizedBox(
                height: Responsive.height * 7,
              ),
              CustomButton(text: 'Submit', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
