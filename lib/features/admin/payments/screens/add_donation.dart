import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({super.key});

  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  String? selectedClass;
  // final _formKey = GlobalKey<FormState>();
  String? selectedDivision;
  String? selectedStudent;
  String? selectedFile;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _donationtypeController = TextEditingController();
  final TextEditingController _methodController = TextEditingController();
  final TextEditingController _transactionController = TextEditingController();

  // Method to pick a file from the device
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // You can specify the file types here
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.single.name; // Store the file name
      });
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Adjust layout when the keyboard appears
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Add padding around the entire content
        child: Column(
          children: [
            CustomAppbar(
              title: "Add Donation",
              isProfileIcon: false,
              onTap: () {
                context.goNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin, // Pass the userType to the next screen
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                      label: 'Select studenr',
                      items: ['Student 1', 'Student 2', 'Student 3'],
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
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
                        CustomTextfield(
                          hintText: 'Donation Type',
                          controller: _donationtypeController,
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
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: CustomButton(
                text: 'Submit',
                onPressed: () {
                  context.read<PaymentController>().addDonation(
                        context,
                        amount_donated: _amountController.text,
                        donation_date: _dateController.text,
                        purpose: _purposeController.text,
                        donation_type: _donationtypeController.text,
                        payment_method: _methodController.text,
                        transaction_id: _transactionController.text,
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
