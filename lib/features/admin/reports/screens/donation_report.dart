import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart'; // Assuming CustomDropdown is imported from this path
import 'package:provider/provider.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/widgets/payment_item.dart'; // Assuming TimeFormatter is imported from this path

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
            Expanded(
              child: _buildClassDivisionDonation(context: context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassDivisionDonation({required BuildContext context}) {
    return Column(
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
                  final selectedClass =
                      context.read<DropdownProvider>().getSelectedItem('class');
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
        Expanded(
          child: Consumer<PaymentController>(
            builder: (context, value, child) {
              if (value.isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!value.isFiltered) {
                // Show image before filtering
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
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }
              if (value.isFiltered && value.filtereddonations.isEmpty) {
                // Show message after filtering with no results
                return Center(
                  child: Text(
                    'No Reports Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  padding: EdgeInsets.zero, // Removes any default padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: value.filtereddonations.length,
                        itemBuilder: (context, index) {
                          final donation = value.filtereddonations[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: PaymentItem(
                              amount: donation.amountDonated ?? "",
                              name: capitalizeFirstLetter(
                                  donation.fullName ?? ""),
                              time: TimeFormatter.formatTimeFromString(
                                  donation.createdAt.toString()),
                              status: donation.purpose ?? "",
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
