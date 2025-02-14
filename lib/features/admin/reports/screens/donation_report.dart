import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart'; // Assuming CustomDropdown is imported from this path
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';

class DonationReport extends StatefulWidget {
  const DonationReport({Key? key}) : super(key: key);

  @override
  State<DonationReport> createState() => _DonationReportState();
}

class _DonationReportState extends State<DonationReport> {
  late DropdownProvider dropdownprovider;

  @override
  void initState() {
    dropdownprovider = context.read<DropdownProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownprovider.clearSelectedItem('class');
      dropdownprovider.clearSelectedItem('division');

      context.read<PaymentController>().clearDonationList();
      context.read<PaymentController>().resetFilter();
      // super.dispose();
    });
    super.initState();

    context.read<PaymentController>().getDonations();
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
              title: "Donation Report",
              isBackButton: true,
              onTap: () {
                context.pushNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin,
                );
              },
            ),
            const SizedBox(height: 16),
            // Use Flexible instead of Expanded
            _buildClassDivisionPayment(context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildClassDivisionPayment({required BuildContext context}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  dropdownKey: 'class',
                  label: 'Class',
                  items: ['5', '6', '7', '8', '9', '10'],
                  icon: Icons.school,
                  onChanged: (selectedClass) {
                    final selectedDivision = context
                        .read<DropdownProvider>()
                        .getSelectedItem('division');
                    context
                        .read<PaymentController>()
                        .getDonationsByClassAndDivision(
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
                    final selectedClass = context
                        .read<DropdownProvider>()
                        .getSelectedItem('class');
                    context
                        .read<PaymentController>()
                        .getDonationsByClassAndDivision(
                          className: selectedClass,
                          section: selectedDivision,
                        );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Use SizedBox instead of Expanded
          Consumer<PaymentController>(
            builder: (context, value, child) {
              if (value.isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!value.isFiltered) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/money.png',
                        height: Responsive.height * 45,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No filter applied. Please select a class and division.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              } else if (value.isFiltered && value.filtereddonations.isEmpty) {
                return Center(
                  child: Text(
                    'No Reports Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Responsive.height * 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: DataTable(
                          headingRowColor:
                              WidgetStatePropertyAll(Colors.grey.shade400),
                          border: TableBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          columns: [
                            DataColumn(
                                label: Text("ID",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Amount Donated",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Purpose",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: value.filtereddonations.map((donation) {
                            return DataRow(
                              cells: [
                                DataCell(Center(
                                    child: Text(donation.id.toString()))),
                                DataCell(Text(donation.fullName ?? "")),
                                DataCell(Center(
                                    child: Text(donation.amountDonated ?? ""))),
                                DataCell(Center(
                                    child: Text(donation.purpose ?? ""))),
                                DataCell(Center(
                                    child: Text(DateFormatter.formatDateString(
                                        donation.createdAt.toString())))),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
