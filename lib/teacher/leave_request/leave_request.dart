import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/controller/dropdown_controller.dart';
import 'package:school_app/global%20widgets/custom_dropdown.dart';
import 'package:school_app/teacher/data/dropdown_data.dart';
import 'package:school_app/teacher/homework/widgets/date_picker.dart';
import 'package:school_app/teacher/routes/app_route_const.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class LeaveRequest extends StatelessWidget {
  LeaveRequest({super.key});

  List<DropdownMenuItem<String>> leaveTypes = DropdownData.leaveTypes;

  @override
  Widget build(BuildContext context) {
    final dropdownProvider = Provider.of<DropdownProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pushReplacementNamed(AppRouteConst.homeRouteName);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Center(
          child: Text(
            'Leave Request',
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
                  const DatePicker(title: "Start Date"),
                  SizedBox(width: Responsive.width * 2),
                  const DatePicker(title: "End Date"),
                ],
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                'Leave Details',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomDropdown(
                title: 'Select LeaveType',
                icon: Icons.school,
                items: leaveTypes,
                selectedValue: dropdownProvider.selectedLeaveType,
                onChanged: (value) {
                  dropdownProvider.setSelectedLeaveType(
                      value); // Update the state using provider
                },
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
                height: Responsive.height * 2,
              ),
              CustomTextfield(
                hintText: "Dcoument Upload",
                iconData: const Icon(Icons.link),
              ),
              SizedBox(
                height: Responsive.height * 7,
              ),
              CustomButton(text: "Submit", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
