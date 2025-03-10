import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/app_constants.dart';
import 'package:school_app/base/utils/button_loading.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_snackbar.dart';
import 'package:school_app/base/utils/form_validators.dart';
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

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({super.key});

  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedClass;

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

    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Clear dropdown selections when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownProvider.clearSelectedItem('class');
      dropdownProvider.clearSelectedItem('division');
      dropdownProvider.clearSelectedItem('donationType');
      dropdownProvider.clearSelectedItem('paymentMethod');
      filePickerProvider.clearFile('donation receipt');
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  title: "Add Donation",
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
                        label: 'Class*',
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
                        label: 'Division*',
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
                InkWell(
                  onTap: () {
                    final classGrade = context
                        .read<DropdownProvider>()
                        .getSelectedItem('class');
                    final division = context
                        .read<DropdownProvider>()
                        .getSelectedItem('division');
                    final classAndDivision = ClassAndDivision(
                        className: classGrade, section: division);
                    context.pushNamed(
                        AppRouteConst.singlestudentselectionRouteName,
                        extra: classAndDivision);
                  },
                  child: Consumer<StudentIdController>(
                    builder: (context, value, child) {
                      final studentId = context
                          .read<StudentIdController>()
                          .getSelectedStudentId();
                      String? selectedStudentName = studentId != null
                          ? value.students.firstWhere(
                              (student) => student['id'] == studentId,
                              orElse: () => {
                                'id': null,
                                'full_name': null
                              }, // Default student
                            )['full_name']
                          : null;

                      return TextFormField(
                        decoration: InputDecoration(
                          hintText: selectedStudentName == null
                              ? "Select Student*"
                              : capitalizeEachWord(selectedStudentName),
                          enabled: false,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Responsive.height * 1,
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
                      label: 'Title*',
                      controller: _purposeController,
                      iconData: const Icon(Icons.title),
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Title"),
                    ),
                    SizedBox(height: Responsive.height * 1.6),
                    CustomTextfield(
                      label: 'Amount*',
                      controller: _amountController,
                      iconData: const Icon(Icons.currency_rupee),
                      keyBoardtype: TextInputType.number,
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Amount"),
                    ),
                    SizedBox(height: Responsive.height * 1.6),
                    CustomDatePicker(
                      dateController: _dateController,
                      onDateSelected: (selectedDate) {
                        print(
                          "End Date selected: $selectedDate",
                        );
                      },
                      label: 'Donation Date*',
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Donation Date"),
                    ),
                    SizedBox(height: Responsive.height * 1.6),
                    CustomDropdown(
                      dropdownKey: 'donationType',
                      label: 'Donation Type*',
                      items: ['One-time', 'Recurring', 'Event-based'],
                      icon: Icons.category,
                    ),
                    SizedBox(height: Responsive.height * 1.6),
                    CustomDropdown(
                      dropdownKey: 'paymentMethod',
                      label: 'Payment Method*',
                      items: AppConstants.paymentMethods,
                      icon: Icons.currency_rupee,
                      validator: (value) => FormValidator.validateNotEmpty(
                          value,
                          fieldName: "Payment Method"),
                    ),
                    SizedBox(height: Responsive.height * 1.6),
                    CustomTextfield(
                      hintText: 'Transaction Id',
                      controller: _transactionController,
                      iconData: const Icon(Icons.currency_rupee),
                      // validator: (value) => FormValidator.validateNotEmpty(
                      //     value,
                      //     fieldName: "Transaction Id"),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height * 1.6),
                CustomFilePicker(
                  label: "Add Receipt (Maximum file size: 5MB)",
                  fieldName: 'donation receipt',
                ),
                Padding(
                    padding: EdgeInsets.only(top: Responsive.height * 1.6),
                    child: Consumer<PaymentController>(
                        builder: (context, value, child) {
                      return CommonButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
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
                            } catch (e) {
                              // Handle any errors and show an error message
                              CustomSnackbar.show(context,
                                  message:
                                      "Failed to add notice.Please try again",
                                  type: SnackbarType.failure);
                            }
                          } else {
                            // Highlight missing fields if the form is invalid
                            CustomSnackbar.show(context,
                                message: "Please complete all required fields",
                                type: SnackbarType.warning);
                          }
                        },
                        widget: value.isloadingTwo
                            ? ButtonLoading()
                            : Text('Submit'),
                      );
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
