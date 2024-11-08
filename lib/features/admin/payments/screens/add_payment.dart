import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_datepicker.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key});

  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  String? selectedFile;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transactionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure `StudentIdController` fetches data on dropdown change
    final dropdownProvider = context.read<DropdownProvider>();

    // Clear dropdown selections when page loads
    dropdownProvider.clearSelectedItem('class');
    dropdownProvider.clearSelectedItem('division');
    dropdownProvider.clearSelectedItem('selectedStudent');
    dropdownProvider.clearSelectedItem('selectedYear');
    dropdownProvider.clearSelectedItem('selectedMonth');
    dropdownProvider.clearSelectedItem('paymentMethod');
    dropdownProvider.clearSelectedItem('paymentStatus');

    dropdownProvider.addListener(() {
      final selectedClass = dropdownProvider.getSelectedItem('class');
      final selectedDivision = dropdownProvider.getSelectedItem('division');
      context.read<StudentIdController>().getStudentsFromClassAndDivision(
          className: selectedClass, section: selectedDivision);
    });
  }

  Future<void> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomAppbar(
                title: "Add Payment",
                isProfileIcon: false,
                onTap: () {
                  context.goNamed(
                    AppRouteConst.bottomNavRouteName,
                    extra: UserType.admin,
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
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDropdown(
                      dropdownKey: 'division',
                      label: 'Division',
                      items: ['A', 'B', 'C'],
                      icon: Icons.group,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Consumer<StudentIdController>(
                builder: (context, studentController, child) {
                  return CustomDropdown(
                    dropdownKey: 'selectedStudent',
                    label: 'Select student',
                    items: studentController.students
                        .map((student) =>
                            '${student['id'].toString()}. ${student['full_name']}')
                        .toList(),
                    icon: Icons.person,
                  );
                },
              ),
              const SizedBox(height: 16),
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
                          items: ['2023', '2024', '2025'],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomDropdown(
                          dropdownKey: 'selectedMonth',
                          label: 'Month',
                          icon: Icons.calendar_month,
                          items: [
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            'August',
                            'September',
                            'October',
                            'November',
                            'December'
                          ],
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
                    label: 'Payment Date',
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    hintText: 'Amount',
                    controller: _amountController,
                    iconData: const Icon(Icons.currency_rupee),
                    keyBoardtype: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    dropdownKey: 'paymentMethod',
                    label: 'Payment Method',
                    icon: Icons.payment,
                    items: ['Cash', 'Bank Transfer', 'Credit Card', 'UPI'],
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    hintText: 'Transaction Id',
                    controller: _transactionController,
                    iconData: const Icon(Icons.confirmation_number),
                    keyBoardtype: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    dropdownKey: 'paymentStatus',
                    label: 'Payment Status',
                    icon: Icons.check_circle,
                    items: ['Pending', 'Completed', 'Failed'],
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
              const SizedBox(height: 45),
              Center(
                child: CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    final selectedStudent = context
                        .read<DropdownProvider>()
                        .getSelectedItem('selectedStudent');
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
                    final studentId = selectedStudent.split('.').first;

                    log(">>>>>>>>>>>>${studentId}");
                    context.read<PaymentController>().addPayment(
                          context,
                          userId: int.parse(studentId),
                          amount_paid: _amountController.text,
                          payment_date: _dateController.text,
                          month: selectedMonth,
                          year: selectedYear,
                          payment_method: paymentMethod,
                          transaction_id: _transactionController.text,
                          payment_status: paymentStatus,
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
