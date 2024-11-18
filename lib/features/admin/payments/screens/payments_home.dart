import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/widgets/payment_item.dart';

class PaymentsHomeScreen extends StatefulWidget {
  @override
  _PaymentsHomeScreenState createState() => _PaymentsHomeScreenState();
}

class _PaymentsHomeScreenState extends State<PaymentsHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomAppbar(
              title: "Payments",
              isBackButton: false,
            ),
            Row(
              children: [
                Expanded(
                  child: AddButton(
                    iconPath: paymentIcon,
                    onPressed: () {
                      context.pushNamed(AppRouteConst.AddPaymentRouteName);
                    },
                    text: "Add Payment",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AddButton(
                    iconPath: donationIcon,
                    onPressed: () {
                      context.pushNamed(AppRouteConst.AddDonationRouteName);
                    },
                    text: "Add Donation",
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Payments'),
                Tab(text: 'Donations'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(child: _buildPaymentsList()),
                  _buildDonationsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentsList() {
    context.read<PaymentController>().getPayments();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(child: CircularProgressIndicator());
      }

      // Get today's and yesterday's dates.
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));

      // Group payments by their respective dates.
      Map<String, List> groupedPayments = {};

      for (var payment in value.payments) {
        final paymentDate = DateTime.tryParse(payment.paymentDate.toString());
        if (paymentDate == null) continue;

        String formattedDate;
        if (paymentDate.isAtSameMomentAs(today)) {
          formattedDate = "Today";
        } else if (paymentDate.isAtSameMomentAs(yesterday)) {
          formattedDate = "Yesterday";
        } else {
          formattedDate = DateFormat.yMMMMd().format(paymentDate);
        }

        if (!groupedPayments.containsKey(formattedDate)) {
          groupedPayments[formattedDate] = [];
        }
        groupedPayments[formattedDate]!.add(payment);
      }

      // Sort the grouped dates such that "Today" and "Yesterday" are at the top,
      // followed by other dates in descending order.
      List<MapEntry<String, List>> sortedEntries = [];
      if (groupedPayments.containsKey('Today')) {
        sortedEntries.add(MapEntry('Today', groupedPayments['Today']!));
        groupedPayments.remove('Today');
      }
      if (groupedPayments.containsKey('Yesterday')) {
        sortedEntries.add(MapEntry('Yesterday', groupedPayments['Yesterday']!));
        groupedPayments.remove('Yesterday');
      }

      sortedEntries.addAll(groupedPayments.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)));

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sortedEntries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateHeader(entry.key),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: entry.value.length,
                  itemBuilder: (context, index) {
                    final payment = entry.value[index];
                    return PaymentItem(
                      amount: payment.amountPaid ?? "",
                      name: capitalizeFirstLetter(payment.fullName ?? ""),
                      time: TimeFormatter.formatTimeFromString(
                          value.payments[index].createdAt.toString()),
                      status: payment.paymentStatus ?? "",
                    );
                  },
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildDonationsList() {
    context.read<PaymentController>().getDonations();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(child: CircularProgressIndicator());
      }

      // Get today's and yesterday's dates.
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));

      // Group donations by their respective dates.
      Map<String, List> groupedDonations = {};

      for (var donation in value.donations) {
        final donationDate =
            DateTime.tryParse(donation.donationDate.toString());
        if (donationDate == null) continue;

        String formattedDate;
        if (donationDate.isAtSameMomentAs(today)) {
          formattedDate = "Today";
        } else if (donationDate.isAtSameMomentAs(yesterday)) {
          formattedDate = "Yesterday";
        } else {
          formattedDate = DateFormat.yMMMMd().format(donationDate);
        }

        if (!groupedDonations.containsKey(formattedDate)) {
          groupedDonations[formattedDate] = [];
        }
        groupedDonations[formattedDate]!.add(donation);
      }

      // Sort the grouped dates such that "Today" and "Yesterday" are at the top,
      // followed by other dates in descending order.
      List<MapEntry<String, List>> sortedEntries = [];
      if (groupedDonations.containsKey('Today')) {
        sortedEntries.add(MapEntry('Today', groupedDonations['Today']!));
        groupedDonations.remove('Today');
      }
      if (groupedDonations.containsKey('Yesterday')) {
        sortedEntries
            .add(MapEntry('Yesterday', groupedDonations['Yesterday']!));
        groupedDonations.remove('Yesterday');
      }

      sortedEntries.addAll(groupedDonations.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)));

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sortedEntries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateHeader(entry.key),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: entry.value.length,
                  itemBuilder: (context, index) {
                    final donation = entry.value[index];
                    return PaymentItem(
                      amount: donation.amountDonated ?? "",
                      name: capitalizeFirstLetter(donation.fullName ?? ""),
                      time: TimeFormatter.formatTimeFromString(
                          value.donations[index].createdAt.toString()),
                      status: donation.purpose ?? "",
                    );
                  },
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Text(date, style: textThemeData.bodyMedium),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isAtSameMomentAs(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
