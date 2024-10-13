import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/features/admin/payments/widgets/payment_item.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/features/teacher/widgets/custom_appbar.dart';
import 'package:school_app/base/routes/app_route_const.dart';

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
                  child: CustomButton(
                    text: 'Add Payment',
                    onPressed: () {
                      context.pushNamed(
                          AppRouteConst.AddPaymentRouteName);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Add Donation',
                    onPressed: () {
                      context.pushNamed(
                          AppRouteConst.AddDonationRouteName);
                    },
                  ),
                ),
              ],
            ),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Payments'),
                Tab(text: 'Donations'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPaymentsList(),
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
    return ListView(
      children: [
        _buildDateHeader('Today'),
        PaymentItem(amount: '₹2500', name: 'Muhammed Rafsal N', time: '09:00 am'),
        _buildDateHeader('Yesterday'),
        PaymentItem(amount: '₹2500', name: 'Muhammed Rafsal N', time: '09:00 am'),
        PaymentItem(amount: '₹2500', name: 'Muhammed Rafsal N', time: '09:00 am'),
        PaymentItem(amount: '₹2500', name: 'Muhammed Rafsal N', time: '09:00 am'),
        PaymentItem(amount: '₹2500', name: 'Muhammed Rafsal N', time: '08:00 am'),
        PaymentItem(amount: '₹2500', name: 'Muhammed Rafsal N', time: '09:00 am'),
      ],
    );
  }

  Widget _buildDonationsList() {
    return ListView(
      children: [
        _buildDateHeader('Today'),
        PaymentItem(amount: '₹250', name: 'Muhammed Rafsal N', time: '09:00 am'),
        _buildDateHeader('Yesterday'),
        PaymentItem(amount: '₹1500', name: 'Muhammed Rafsal N', time: '09:00 am'),
        PaymentItem(amount: '₹700', name: 'Muhammed Rafsal N', time: '09:00 am'),
        PaymentItem(amount: '₹300', name: 'Muhammed Rafsal N', time: '09:00 am'),
        PaymentItem(amount: '₹2500', name: 'Muhammed Rafsal N', time: '08:00 am'),
        PaymentItem(amount: '₹400', name: 'Muhammed Rafsal N', time: '09:00 am'),
      ],
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        date,
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}