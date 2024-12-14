import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/widgets/student_list_tile.dart';

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({super.key});

  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  String? selectedClass;
  // final _formKey = GlobalKey<FormState>();
  // String? selectedDivision;
  // String? selectedStudent;
  // String? selectedFile;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _transactionController = TextEditingController();
  late DropdownProvider dropdownProvider;
  late StudentIdController studentIdController;
  late FilePickerProvider filePickerProvider;

  @override
  void initState() {
    super.initState();
    // Ensure `StudentIdController` fetches data on dropdown change
    dropdownProvider = context.read<DropdownProvider>();
    studentIdController = context.read<StudentIdController>();
    filePickerProvider = context.read<FilePickerProvider>();

    // Clear dropdown selections when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('donationType');
      dropdownProvider.clearSelectedItem('paymentMethod');
      filePickerProvider.clearFile();
      studentIdController.clearSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Add padding around the entire content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Add Donation",
                isProfileIcon: false,
                onTap: () {
                  context.pushNamed(
                    AppRouteConst.bottomNavRouteName,
                    extra:
                        UserType.admin, // Pass the userType to the next screen
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'class',
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
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                "Select Student",
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Consumer<StudentIdController>(
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: value.students.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: StudentListTile(
                              rollNumber:
                                  (value.students[index]['id'].toString()),
                              name: value.students[index]['full_name'],
                              index: index),
                        );
                      });
                },
              ),
              SizedBox(height: Responsive.height * 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Donation details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    hintText: 'Title',
                    controller: _purposeController,
                    iconData: const Icon(Icons.title),
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    hintText: 'Amount',
                    controller: _amountController,
                    iconData: const Icon(Icons.currency_rupee),
                    keyBoardtype: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomDatePicker(
                      dateController: _dateController,
                      onDateSelected: (selectedDate) {
                        print(
                          "End Date selected: $selectedDate",
                        );
                      },
                      label: 'Donation Date'),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    dropdownKey: 'donationType',
                    label: 'Donation Type',
                    items: ['One-time', 'Recurring', 'Event-based'],
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    dropdownKey: 'paymentMethod',
                    label: 'Payment Method',
                    items: [
                      'Bank Transfer',
                      'Cash',
                      'Cheque',
                      'Credit Card',
                      'UPI'
                    ],
                    icon: Icons.currency_rupee,
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    hintText: 'Transaction Id',
                    controller: _transactionController,
                    iconData: const Icon(Icons.currency_rupee),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomFilePicker(label: "Add Receipt"),
              Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Consumer<PaymentController>(
                      builder: (context, value, child) {
                    return CommonButton(
                      onPressed: () {
                        final donationType = context
                            .read<DropdownProvider>()
                            .getSelectedItem('donationType');
                        final paymentMethod = context
                            .read<DropdownProvider>()
                            .getSelectedItem('paymentMethod');
                        final studentId = context
                            .read<StudentIdController>()
                            .getSelectedStudentId();

                        log(">>>>>>>>>>>>${studentId}");
                        context.read<PaymentController>().addDonation(
                              context,
                              userId: studentId ?? 0,
                              amount_donated: _amountController.text,
                              donation_date: _dateController.text,
                              purpose: _purposeController.text,
                              donation_type: donationType,
                              payment_method: paymentMethod,
                              transaction_id: _transactionController.text,
                            );
                      },
                      widget:
                          value.isloading ? ButtonLoading() : Text('Submit'),
                    );
                  })
                  // CustomButton(
                  //   text: 'Submit',
                  //   onPressed: () {
                  //     final donationType = context
                  //         .read<DropdownProvider>()
                  //         .getSelectedItem('donationType');
                  //     final paymentMethod = context
                  //         .read<DropdownProvider>()
                  //         .getSelectedItem('paymentMethod');
                  //     final studentId = context
                  //         .read<StudentIdController>()
                  //         .getSelectedStudentId();

                  //     log(">>>>>>>>>>>>${studentId}");
                  //     context.read<PaymentController>().addDonation(
                  //           context,
                  //           userId: studentId ?? 0,
                  //           amount_donated: _amountController.text,
                  //           donation_date: _dateController.text,
                  //           purpose: _purposeController.text,
                  //           donation_type: donationType,
                  //           payment_method: paymentMethod,
                  //           transaction_id: _transactionController.text,
                  //         );
                  //   },
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
