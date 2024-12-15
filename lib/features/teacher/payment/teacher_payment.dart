import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/widgets/payment_item.dart';

class TeacherPaymentScreen extends StatefulWidget {
  @override
  _TeacherPaymentScreenState createState() => _TeacherPaymentScreenState();
}

class _TeacherPaymentScreenState extends State<TeacherPaymentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    context.read<PaymentController>().getPaymentsByRecordId();
    context.read<PaymentController>().getDonationByRecordId();
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

  /// Reusable function to group items by date.
  Map<String, List<T>> groupItemsByDate<T>(
    List<T> items,
    DateTime Function(T) getDate, // Function to extract the date from the item
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    Map<String, List<T>> groupedItems = {};

    for (var item in items) {
      final itemDate = getDate(item);
      String formattedDate;
      if (itemDate.isAtSameMomentAs(today)) {
        formattedDate = "Today";
      } else if (itemDate.isAtSameMomentAs(yesterday)) {
        formattedDate = "Yesterday";
      } else {
        formattedDate = DateFormat.yMMMMd().format(itemDate);
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
      }
      groupedItems[formattedDate]!.add(item);
    }

    // Sort grouped dates with "Today" and "Yesterday" on top, followed by descending dates.
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey("Today")) {
      sortedEntries.add(MapEntry("Today", groupedItems["Today"]!));
      groupedItems.remove("Today");
    }
    if (groupedItems.containsKey("Yesterday")) {
      sortedEntries.add(MapEntry("Yesterday", groupedItems["Yesterday"]!));
      groupedItems.remove("Yesterday");
    }

    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = DateFormat.yMMMMd().parse(a.key, true);
          final dateB = DateFormat.yMMMMd().parse(b.key, true);
          return dateB.compareTo(dateA); // Sort descending by date
        }),
    );

    return Map.fromEntries(sortedEntries);
  }

  Widget _buildPaymentsList() {
    context.read<PaymentController>().getPaymentsByRecordId();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
        return Column(
          children: [
            SizedBox(
              height: Responsive.height * 30,
            ),
            Loading(
              color: Colors.grey,
            ),
          ],
        );
      }

      final groupedPayments = groupItemsByDate(
        value.teacherPayments,
        (payment) =>
            DateTime.tryParse(payment.paymentDate.toString()) ?? DateTime.now(),
      );

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: groupedPayments.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 1),
                _buildDateHeader(entry.key),
                SizedBox(height: Responsive.height * 1),
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
                          payment.createdAt.toString()),
                      status: payment.paymentStatus ?? "",
                      onTap: () {
                        context.pushNamed(
                          AppRouteConst.PaymentViewRouteName,
                          extra: entry.value[index],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: Responsive.height * 1),
              ],
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildDonationsList() {
    context.read<PaymentController>().getDonationByRecordId();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
        return Column(
          children: [
            SizedBox(
              height: Responsive.height * 30,
            ),
            Loading(
              color: Colors.grey,
            ),
          ],
        );
      }

      final groupedDonations = groupItemsByDate(
        value.teacherdonations,
        (donation) =>
            DateTime.tryParse(donation.donationDate.toString()) ??
            DateTime.now(),
      );

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: groupedDonations.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 1),
                _buildDateHeader(entry.key),
                SizedBox(height: Responsive.height * 1),
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
                          donation.createdAt.toString()),
                      status: donation.purpose ?? "",
                      onTap: () {
                        context.pushNamed(
                          AppRouteConst.DonationViewRouteName,
                          extra: entry.value[index],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: Responsive.height * 1),
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
