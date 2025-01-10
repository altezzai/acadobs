import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/form_validators.dart';
//import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
//import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/leave_request/controller/teacherLeaveReq_controller.dart';

class AddTeacherLeaveRequest extends StatefulWidget {
  const AddTeacherLeaveRequest({super.key});

  @override
  State<AddTeacherLeaveRequest> createState() => _AddTeacherLeaveRequestState();
}

class _AddTeacherLeaveRequestState extends State<AddTeacherLeaveRequest> {
    final _formKey = GlobalKey<FormState>();
  String? selectedLeaveType;
  final teacherId = SecureStorageService.getUserId();
  // textediting controllers
  final TextEditingController _teacherIdController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonForLeaveController =
      TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _teacherIdController.dispose();

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
                  title: "Add Leave Request",
                  isProfileIcon: false,
                  onTap: () {
                    context.pop();
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
                //   controller: _teacherIdController,
                //   hintText: 'Teacher ID',
                //   iconData: Icon(Icons.person),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Teacher ID is required';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(
                //   height: Responsive.height * 1,
                // ),
                CustomDropdown(
                  dropdownKey: 'leaveType',
                  label: 'Leave Type',
                  icon: Icons.person_2_outlined,
                  items: ['Sick Leave', 'Casual Leave', 'Other'],
                   validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Leave Type"),
                ),
                SizedBox(
                  height: Responsive.height * 1,
                ),
                CustomDatePicker(
                  label: "Start Date",
                  dateController: _startDateController,
                  onDateSelected: (selectedDate) {
                    print("Start Date selected: $selectedDate");
                  },
                   validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Start Date"),
                ),
                SizedBox(
                  height: Responsive.height * 1,
                ),
                CustomDatePicker(
                  label: "End Date",
                  dateController: _endDateController,
                  onDateSelected: (selectedDate) {
                    print("End Date selected: $selectedDate");
                  },
                   validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "End Date"),
                ),
                SizedBox(
                  height: Responsive.height * 1,
                ),
                CustomTextfield(
                  controller: _reasonForLeaveController, //Add controller
                  hintText: 'Reason For Leave',
                  iconData: Icon(Icons.question_mark_rounded),
                   validator: (value) => FormValidator.validateNotEmpty(value,fieldName: "Reason "),
                ),
                SizedBox(
                  height: Responsive.height * 1,
                ),
                Consumer<TeacherLeaveRequestController>(
                    builder: (context, value, child) {
                  return CommonButton(
                    onPressed: () {
                       if (_formKey.currentState?.validate() ?? false) {
                          try {
                      final selectedLeaveType = context
                          .read<DropdownProvider>()
                          .getSelectedItem('leaveType');
                      // final int? teacherId = int.tryParse(_teacherIdController.text);
            
                      context
                          .read<TeacherLeaveRequestController>()
                          .addNewTeacherLeaveRequest(
                            context,
                            // teacherId: _teacherIdController.text,
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
                    },
                    widget: value.isloadingTwo ? ButtonLoading() : Text('Submit'),
                  );
                }),
                // CustomButton(
                //     text: 'Submit',
                //     onPressed: () {
                //       final selectedLeaveType = context
                //           .read<DropdownProvider>()
                //           .getSelectedItem('leaveType');
                //       // final int? teacherId = int.tryParse(_teacherIdController.text);
            
                //       context
                //           .read<TeacherLeaveRequestController>()
                //           .addNewTeacherLeaveRequest(
                //             context,
                //             teacherId: _teacherIdController.text,
                //             leaveType: selectedLeaveType,
                //             startDate: _startDateController.text,
                //             endDate: _endDateController.text,
                //             reasonForLeave: _reasonForLeaveController.text,
                //           );
                //     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
