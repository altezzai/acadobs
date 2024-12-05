import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart'; // Assuming CustomDropdown is imported from this path
import 'package:provider/provider.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/widgets/payment_item.dart'; // Assuming TimeFormatter is imported from this path

class PaymentReport extends StatefulWidget {
  const PaymentReport({Key? key}) : super(key: key);

  @override
  State<PaymentReport> createState() => _PaymentReportState();
}

class _PaymentReportState extends State<PaymentReport> {

   @override
  void initState() {
    super.initState();
    context.read<PaymentController>().getPayments();
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
              title: "Payment Report",
              isBackButton: true,
              onTap: () {
                context.pushNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin,
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildClassDivisionPayment(context: context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassDivisionPayment({required BuildContext context}) {
    return Column(
      children: [
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
                      .read<PaymentController>()
                      .getPaymentsByClassAndDivision(
                        className: selectedClass,
                        section: selectedDivision,
                      );
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CustomDropdown(
                dropdownKey: 'division',
                label: 'Division',
                items: ['A', 'B', 'C'],
                icon: Icons.group,
                onChanged: (selectedDivision) {
                  final selectedClass =
                      context.read<DropdownProvider>().getSelectedItem('class');
                  context
                      .read<PaymentController>()
                      .getPaymentsByClassAndDivision(
                        className: selectedClass,
                        section: selectedDivision,
                      );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<PaymentController>(
            builder: (context, value, child) {
              if (value.isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (value.filteredpayments.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/empty.png',
                        height: Responsive.height * 45,
                      ),
                    ],
                  ),
                );
              }
                return SingleChildScrollView(
                    padding: EdgeInsets.zero, // Removes any default padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets
                              .zero,
                itemCount: value.filteredpayments.length,
                itemBuilder: (context, index) {
                  final payment = value.filteredpayments[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: PaymentItem(
                      amount: payment.amountPaid ?? "",
                      name: payment.fullName ?? "",
                      time: TimeFormatter.formatTimeFromString(
                          payment.createdAt.toString()),
                      status: payment.paymentStatus ?? "",
                    ),
                  );
                },
              )],),);
            },
          ),
        ),
      ],
    );
  }
}
