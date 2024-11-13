import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';

class AddStudentLeaveRequest extends StatefulWidget {
  const AddStudentLeaveRequest({super.key});

  @override
  State<AddStudentLeaveRequest> createState() => _AddStudentLeaveRequestState();
}

class _AddStudentLeaveRequestState extends State<AddStudentLeaveRequest> {
  String? selectedLeaveType;

  // textediting controllers
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonForLeaveController =
      TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _studentIdController.dispose();

    _startDateController.dispose();
    _endDateController.dispose();
    _reasonForLeaveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Responsive.width * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Add Leave Requset",
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(AppRouteConst.ParentHomeRouteName);
                },
              ),
              Text(
                'Leave Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomTextfield(
                controller: _studentIdController,
                hintText: 'student ID',
                iconData: Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'student ID is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomDropdown(
                dropdownKey: 'leaveType',
                label: 'Leave Type',
                icon: Icons.person_2_outlined,
                items: ['Sick Leave', 'Casual Leave', 'Other'],
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomDatePicker(
                label: "Start Date",
                dateController: _startDateController,
                onDateSelected: (selectedDate) {
                  print("Start Date selected: $selectedDate");
                },
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomDatePicker(
                label: "End Date",
                dateController: _endDateController,
                onDateSelected: (selectedDate) {
                  print("End Date selected: $selectedDate");
                },
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomTextfield(
                controller: _reasonForLeaveController, //Add controller
                hintText: 'Reason For Leave',
                iconData: Icon(Icons.location_on),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    final selectedLeaveType = context
                        .read<DropdownProvider>()
                        .getSelectedItem('leaveType');

                    context
                        .read<StudentLeaveRequestController>()
                        .addNewStudentLeaveRequest(
                          context,
                          studentId: _studentIdController.text,
                          leaveType: selectedLeaveType,
                          startDate: _startDateController.text,
                          endDate: _endDateController.text,
                          reasonForLeave: _reasonForLeaveController.text,
                        );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
