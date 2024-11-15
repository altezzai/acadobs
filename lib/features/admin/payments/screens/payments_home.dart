import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
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
                      text: "Add Payment"),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: AddButton(
                      iconPath: donationIcon,
                      onPressed: () {
                        context.pushNamed(AppRouteConst.AddDonationRouteName);
                      },
                      text: "Add Donation"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: CustomButton(
            //         text: 'Add Payment',
            //         onPressed: () {
            //           context.pushNamed(AppRouteConst.AddPaymentRouteName);
            //         },
            //       ),
            //     ),
            //     SizedBox(width: 10),
            //     Expanded(
            //       child: CustomButton(
            //         text: 'Add Donation',
            //         onPressed: () {
            //           context.pushNamed(AppRouteConst.AddDonationRouteName);
            //         },
            //       ),
            //     ),
            //   ],
            // ),
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
    context.read<PaymentController>().getPayments();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: value.payments.length,
          itemBuilder: (context, index) {
            return PaymentItem(
              amount: value.payments[index].amountPaid ?? "",
              name: value.payments[index].transactionId ?? "",
              time: DateFormatter.formatDateString(
                  value.payments[index].paymentDate.toString()),
              status: value.payments[index].paymentStatus ?? "",
            );
          });
    });
  }

  Widget _buildDonationsList() {
    context.read<PaymentController>().getDonations();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: value.donations.length,
          itemBuilder: (context, index) {
            return PaymentItem(
              amount: value.donations[index].amountDonated ?? "",
              name: value.donations[index].purpose ?? "",
              time: DateFormatter.formatDateString(
                  value.donations[index].donationDate.toString()),
            );
          });
    });
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
