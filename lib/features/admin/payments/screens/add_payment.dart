import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
// ignore: unused_import
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key});

  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  // final _formKey = GlobalKey<FormState>();
  String? selectedClass;
  String? selectedDivision;
  String? selectedStudent;
  String? selectedFile;
  // ignore: unused_field
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _methodController = TextEditingController();
  final TextEditingController _transactionController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
              title: "Add Payment",
              isProfileIcon: false,
              onTap: () {
                context.goNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin, // Pass the userType to the next screen
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'class',
                    label: 'Class',
                    items: ['Class 1', 'Class 2', 'Class 3'],
                    icon: Icons.school,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomDropdown(
                    dropdownKey: 'division',
                    label: 'Division',
                    items: ['Division A', 'Division B', 'Division C'],
                    icon: Icons.group,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomDropdown(
              dropdownKey: 'select student',
              label: 'Select student',
              items: ['Student 1', 'Student 2', 'Student 3'],
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        hintText: 'Year',
                        controller: _yearController,
                        iconData: const Icon(Icons.calendar_today),
                        keyBoardtype: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextfield(
                        hintText: 'Month',
                        controller: _monthController,
                        iconData: const Icon(Icons.date_range),
                        keyBoardtype: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomDatePicker(
                    dateController: _dateController,
                    onDateSelected: (selectedDate) {
                      print("End Date selected: $selectedDate");
                    },
                    label: 'Payment Date'),
                const SizedBox(height: 16),
                CustomTextfield(
                  hintText: 'Amount',
                  controller: _amountController,
                  iconData: const Icon(Icons.currency_rupee),
                  keyBoardtype: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hintText: 'Payment Method',
                  controller: _methodController,
                  iconData: const Icon(Icons.currency_rupee),
                  keyBoardtype: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hintText: 'Transaction Id',
                  controller: _transactionController,
                  iconData: const Icon(Icons.currency_rupee),
                  keyBoardtype: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                  hintText: 'Payment Status',
                  controller: _statusController,
                  iconData: const Icon(Icons.currency_rupee),
                  keyBoardtype: TextInputType.number,
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                    Icon(Icons.attach_file, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedFile ?? 'Add Receipt',
                        style: TextStyle(
                            color: selectedFile != null
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 45),
            Center(
              child: CustomButton(
                text: 'Submit',
                onPressed: () {
                  context.read<PaymentController>().addPayment(context,
                      amount_paid: _amountController.text,
                      payment_date: _dateController.text,
                      month: _monthController.text,
                      year: _yearController.text,
                      payment_method: _methodController.text,
                      transaction_id: _transactionController.text,
                      payment_status: _statusController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
