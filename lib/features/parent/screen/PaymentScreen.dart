import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            context.pushReplacementNamed(
              AppRouteConst.ParentHomeRouteName,
            );
          },
        ),
        title: const Text(
          'Payments',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              PaymentCard(
                amountTitle: "1000",
                name: "\tMuhammed Rafsal N",
                time: "09:00 am",
              ),
              const SizedBox(height: 20),

              // Yesterday Events Section
              const Text(
                "Yesterday",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              PaymentCard(
                amountTitle: "250",
                name: "\tMuhammed Rafsal N",
                time: "09:00 am",
              ),
              PaymentCard(
                amountTitle: "1500",
                name: "\tManuprasad K",
                time: "09:00 am",
              ),
              PaymentCard(
                amountTitle: "500",
                name: "\tAswin Koroth",
                time: "09:00 am",
              ),
              PaymentCard(
                amountTitle: "1000",
                name: "\tMuhammed Rafsal N",
                time: "09:00 am",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final String amountTitle;
  final String name;
  final String time;

  const PaymentCard({
    super.key,
    required this.amountTitle,
    required this.name,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushReplacementNamed(
          AppRouteConst.ParentPaymentDetailedPageRouteName,
          extra: {
            'amount': amountTitle,
            'description': "8th class 2nd Semester Fee",
          },
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PaymentDetailPage(
        //       amount: amountTitle, // Pass amountTitle dynamically
        //       description: "8th class 2nd Semester Fee",
        //     ),
        //   ),
        // );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.green[100],
              child:
                  const Icon(Icons.currency_rupee_sharp, color: Colors.green)),
          title: Row(
            children: [
              const Icon(
                Icons.currency_rupee_rounded,
                size: 18,
              ),
              Text(amountTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          subtitle: Text(name),
          trailing: Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
