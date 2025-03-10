import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/form_validators.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';

import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/parent/leave_request/controller/studentLeaveReq_controller.dart';

class AddStudentLeaveRequest extends StatefulWidget {
  final int studentId;
  const AddStudentLeaveRequest({super.key, required this.studentId, });

  @override
  State<AddStudentLeaveRequest> createState() => _AddStudentLeaveRequestState();
}

class _AddStudentLeaveRequestState extends State<AddStudentLeaveRequest> {
   final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  title: "Add Leave Requset",
                  isProfileIcon: false,
                  onTap: () {
                    Navigator.pop(context);
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
                // CustomTextfield(
                //   controller: _studentIdController,
                //   hintText: 'student ID',
                //   iconData: Icon(Icons.person),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'student ID is required';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(
                //   height: Responsive.height * 2,
                // ),
                CustomDropdown(
                  dropdownKey: 'leaveType',
                  label: 'Leave Type*',
                  icon: Icons.person_2_outlined,
                  items: AppConstants.leaveTypes,
                  validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Leave Type"),
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                CustomDatePicker(
                  label: "Start Date*",
                  dateController: _startDateController,
                  onDateSelected: (selectedDate) {
                    print("Start Date selected: $selectedDate");
                  },
                  validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Start Date"),
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                CustomDatePicker(
                  label: "End Date*",
                  dateController: _endDateController,
                  onDateSelected: (selectedDate) {
                    print("End Date selected: $selectedDate");
                  },
                  validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "End Date"),
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                CustomTextfield(
                  controller: _reasonForLeaveController, //Add controller
                  hintText: 'Reason For Leave*',
                  iconData: Icon(Icons.question_mark_rounded),
                  validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Reason"),
                ),
                SizedBox(
                  height: Responsive.height * 2,
                ),
                Padding(
                   padding: const EdgeInsets.only(top: 45),
                   child: Consumer<StudentLeaveRequestController>(
                        builder: (context, value, child) {
                      return 
                   CommonButton(
                      
                      onPressed: () {
                         if (_formKey.currentState?.validate() ?? false) {
                          try {
                        final selectedLeaveType = context
                            .read<DropdownProvider>()
                            .getSelectedItem('leaveType');
                              
                        context
                            .read<StudentLeaveRequestController>()
                            .addNewStudentLeaveRequest(
                              context,
                              studentId: widget.studentId.toString(),
                              leaveType: selectedLeaveType,
                              startDate: _startDateController.text,
                              endDate: _endDateController.text,
                              reasonForLeave: _reasonForLeaveController.text,
                            );
                       } catch (e) {
                          // Handle any errors and show an error message
                          CustomSnackbar.show(context,
            message: "Failed to add leave request.Please try again", type: SnackbarType.failure);
                        }
                      } else {
                        // Highlight missing fields if the form is invalid
                       CustomSnackbar.show(context,
            message: "Please complete all required fields", type: SnackbarType.warning);
                      }
                    }, widget: value.isloadingTwo ? ButtonLoading() : Text('Submit'),);})
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
