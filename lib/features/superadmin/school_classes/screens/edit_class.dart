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
import 'package:school_app/features/superadmin/models/classes_model.dart';
import 'package:school_app/features/superadmin/school_classes/controller/school_classes_controller.dart';

class EditClassPage extends StatefulWidget {
  final SchoolClass schoolClass;
  const EditClassPage({
    super.key,
    required this.schoolClass,
  });

  @override
  State<EditClassPage> createState() => _EditClassPageState();
}

class _EditClassPageState extends State<EditClassPage> {
  final TextEditingController _editedYearController = TextEditingController();
  final TextEditingController _editedClassNameController =
      TextEditingController();
  late DropdownProvider dropdownProvider;

  @override
  void initState() {
    super.initState();
    dropdownProvider = Provider.of<DropdownProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.setSelectedItem(
          'division', widget.schoolClass.division ?? "");
    });

    _editedYearController.text = widget.schoolClass.year.toString();
    _editedClassNameController.text =
        capitalizeEachWord(widget.schoolClass.classname);
  }

  @override
  void dispose() {
    _editedYearController.dispose();
    _editedClassNameController.dispose();
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
              title: 'Edit Class',
              isProfileIcon: false,
              onTap: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Year:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.calendar_today),
              hintText: 'Enter Year',
              controller: _editedYearController,
            ),
            SizedBox(height: Responsive.height * 2),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Class Name:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomTextfield(
              iconData: Icon(Icons.class_),
              hintText: 'Enter Class Name',
              controller: _editedClassNameController,
            ),
            SizedBox(height: Responsive.height * 2),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text("Division:"),
            ),
            SizedBox(height: Responsive.height * 1),
            CustomDropdown(
              dropdownKey: 'division',
              label: "Division",
              icon: Icons.school,
              items: ["A", "B", "C", "D", "E"],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: Responsive.height * 4),
              child: Consumer<SchoolClassController>(
                builder: (context, controller, child) {
                  return CommonButton(
                    onPressed: () {
                      final selectedDivision =
                          dropdownProvider.getSelectedItem('division');
                      context.read<SchoolClassController>().editClass(
                            context,
                            classId: widget.schoolClass.id,
                            year: _editedYearController.text.trim(),
                            classname: _editedClassNameController.text.trim(),
                            division: selectedDivision,
                          );
                    },
                    widget: controller.isLoadingTwo
                        ? Loading()
                        : const Text('Update'),
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
