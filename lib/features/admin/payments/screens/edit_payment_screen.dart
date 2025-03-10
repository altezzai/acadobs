import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_filepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/model/payment_model.dart';

class EditPaymentScreen extends StatefulWidget {
  final Payment payment;
  const EditPaymentScreen({
    super.key,
    required this.payment,
  });

  @override
  State<EditPaymentScreen> createState() => _EditPaymentScreenState();
}

class _EditPaymentScreenState extends State<EditPaymentScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transactionController = TextEditingController();
  late DropdownProvider dropdownProvider;
  late StudentIdController studentIdController;
  late FilePickerProvider filePickerProvider;

  @override
  void initState() {
    super.initState();
    _dateController.text = widget.payment.paymentDate != null
        ? DateFormat('yyyy-MM-dd')
            .format(widget.payment.paymentDate as DateTime)
        : "";
    _amountController.text = widget.payment.amountPaid ?? "";
    _transactionController.text = widget.payment.transactionId ?? "";

    dropdownProvider = context.read<DropdownProvider>();
    studentIdController = context.read<StudentIdController>();
    filePickerProvider = context.read<FilePickerProvider>();

    // Initialize dropdown selections if values exist in the notice
    if (widget.payment.paymentClass != null) {
      dropdownProvider.setSelectedItem('class', widget.payment.paymentClass!);
    }
    if (widget.payment.section != null) {
      dropdownProvider.setSelectedItem('division', widget.payment.section!);
    }
    if (widget.payment.paymentClass != null) {
      dropdownProvider.setSelectedItem('class', widget.payment.paymentClass!);
    }
    if (widget.payment.year != null) {
      dropdownProvider.setSelectedItem('selectedYear', widget.payment.year!);
    }
    if (widget.payment.month != null) {
      dropdownProvider.setSelectedItem('selectedMonth', widget.payment.month!);
    }
    if (widget.payment.paymentStatus != null) {
      dropdownProvider.setSelectedItem(
          'paymentStatus', widget.payment.paymentStatus!);
    }
    if (widget.payment.paymentMethod != null) {
      dropdownProvider.setSelectedItem(
          'paymentMethod', widget.payment.paymentMethod!);
    }
    log("++++++++++++++Student id: ${widget.payment.userId}");
    // Clear dropdown selections when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // dropdownProvider.clearSelectedItem('class');
      // dropdownProvider.clearSelectedItem('division');
      // dropdownProvider.clearSelectedItem('selectedYear');
      // dropdownProvider.clearSelectedItem('selectedMonth');
      // dropdownProvider.clearSelectedItem('paymentStatus');
      // dropdownProvider.clearSelectedItem('paymentMethod');
      filePickerProvider.clearFile('receipt');
      studentIdController.clearSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Edit Payment",
                isProfileIcon: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'class',
                      label: 'Class',
                      items: AppConstants.classNames,
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
                      items: AppConstants.divisions,
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
              Text("Selected Student:"),
              SizedBox(height: 10),
              // Selected  Student
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    hintText:
                        capitalizeEachWord(widget.payment.fullName ?? "")),
              ),
              // InkWell(
              //   onTap: () {
              //     final classGrade =
              //         context.read<DropdownProvider>().getSelectedItem('class');
              //     final division = context
              //         .read<DropdownProvider>()
              //         .getSelectedItem('division');
              //     final classAndDivision = ClassAndDivision(
              //         className: classGrade, section: division);
              //     context.pushNamed(
              //         AppRouteConst.singlestudentselectionRouteName,
              //         extra: classAndDivision);
              //   },
              //   child: Consumer<StudentIdController>(
              //     builder: (context, value, child) {
              //       final studentId = context
              //           .read<StudentIdController>()
              //           .getSelectedStudentId();
              //       String? selectedStudentName = studentId != null
              //           ? value.students.firstWhere(
              //               (student) => student['id'] == studentId,
              //               orElse: () => {
              //                 'id': null,
              //                 'full_name': null
              //               }, // Default student
              //             )['full_name']
              //           : null;

              //       return TextFormField(
              //         decoration: InputDecoration(
              //           hintText: selectedStudentName == null
              //               ? "Select Student"
              //               : capitalizeEachWord(selectedStudentName),
              //           enabled: false,
              //         ),
              //       );
              //     },
              //   ),
              // ),
              SizedBox(height: Responsive.height * 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child: CustomDropdown(
                        dropdownKey: 'selectedYear',
                        label: 'Year',
                        icon: Icons.calendar_month,
                        items: AppConstants.years,
                      )),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomDropdown(
                          dropdownKey: 'selectedMonth',
                          label: 'Month',
                          icon: Icons.calendar_month,
                          items: AppConstants.months,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.height * 1.6),
                  CustomDatePicker(
                    dateController: _dateController,
                    onDateSelected: (selectedDate) {
                      print("End Date selected: $selectedDate");
                    },
                    label: 'Payment Date',
                    lastDate:
                        DateTime(2100), // Extend to a reasonable future date
                    initialDate: DateTime.now(),
                  ),
                  SizedBox(height: Responsive.height * 1.6),
                  CustomTextfield(
                    hintText: 'Amount',
                    controller: _amountController,
                    iconData: const Icon(Icons.currency_rupee),
                    keyBoardtype: TextInputType.number,
                  ),
                  SizedBox(height: Responsive.height * 1.6),
                  CustomDropdown(
                    dropdownKey: 'paymentMethod',
                    label: 'Payment Method',
                    icon: Icons.payment,
                    items: ['Cash', 'Bank Transfer', 'Credit Card', 'UPI'],
                  ),
                  SizedBox(height: Responsive.height * 1.6),
                  CustomTextfield(
                    hintText: 'Transaction Id',
                    controller: _transactionController,
                    iconData: const Icon(Icons.confirmation_number),
                    keyBoardtype: TextInputType.text,
                  ),
                  SizedBox(height: Responsive.height * 1.6),
                  CustomDropdown(
                    dropdownKey: 'paymentStatus',
                    label: 'Payment Status',
                    icon: Icons.check_circle,
                    items: ['Pending', 'Completed', 'Failed'],
                  )
                ],
              ),
              SizedBox(height: Responsive.height * 1.6),
              CustomFilePicker(
                label: "Add Receipt (Maximum file size: 5MB)",
                fieldName: 'receipt',
              ),
              SizedBox(height: Responsive.height * 1.6),
              Center(child:
                  Consumer<PaymentController>(builder: (context, value, child) {
                return CommonButton(
                    onPressed: () {
                      final selectedYear = context
                          .read<DropdownProvider>()
                          .getSelectedItem('selectedYear');
                      final selectedMonth = context
                          .read<DropdownProvider>()
                          .getSelectedItem('selectedMonth');
                      final paymentMethod = context
                          .read<DropdownProvider>()
                          .getSelectedItem('paymentMethod');
                      final paymentStatus = context
                          .read<DropdownProvider>()
                          .getSelectedItem('paymentStatus');
                      // final studentId = context
                      //     .read<StudentIdController>()
                      //     .getSelectedStudentId();

                      log(">>>>>>>>>>>>${widget.payment.userId}");
                      context.read<PaymentController>().editPayment(
                            context,
                            paymentId: widget.payment.id ?? 0,
                            studentId: widget.payment.userId ?? 0,
                            amount_paid: _amountController.text,
                            payment_date: _dateController.text,
                            month: selectedMonth,
                            year: selectedYear,
                            payment_method: paymentMethod,
                            transaction_id: _transactionController.text,
                            payment_status: paymentStatus,
                          );
                    },
                    widget:
                        value.isloadingTwo ? ButtonLoading() : Text('Submit'));
              })),
            ],
          ),
        ),
      ),
    );
  }
}
