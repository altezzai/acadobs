import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    context.read<PaymentController>().getPayments();
    super.initState();
  }

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
          child: Consumer<PaymentController>(builder: (context, controller, _) {
            // Sort payments by date (newest first)
            final sortedPayments = controller.payments
              ..sort((a, b) => b.paymentDate!.compareTo(a.paymentDate!));

            // Group payments by date
            final groupedPayments = <String, List<dynamic>>{};
            for (var payment in sortedPayments) {
              final formattedDate = DateFormatter.formatDateString(
                payment.paymentDate.toString(),
              );
              if (!groupedPayments.containsKey(formattedDate)) {
                groupedPayments[formattedDate] = [];
              }
              groupedPayments[formattedDate]!.add(payment);
            }

            // Render grouped payments
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: groupedPayments.entries.map((entry) {
                final date = entry.key;
                final payments = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the date as a section header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    // Render payment cards for the given date
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        final payment = payments[index];
                        return PaymentCard(
                          amountTitle: payment.amountPaid ?? "",
                          name: payment.userId.toString(),
                          paymentMethod: payment.paymentMethod ?? "",
                          transactionId: payment.transactionId ??"",
                          time: TimeFormatter.formatTimeFromString(
                            payment.createdAt.toString(),
                          ),
                          description: payment.paymentStatus.toString(),
                          fileUpload: payment.fileUpload,
                        );
                      },
                    ),
                  ],
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final String amountTitle;
  final String description;
  final String name;
  final String time;
  final String transactionId;
  final String fileUpload;
  final String paymentMethod;

  const PaymentCard(
      {super.key,
      required this.amountTitle,
      required this.name,
      required this.time,
      required this.description,
      required this.transactionId,
      required this.fileUpload,
      required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushReplacementNamed(
          AppRouteConst.ParentPaymentDetailedPageRouteName,
          extra: {
            'amount': amountTitle,
            'description': description,
            'file': fileUpload,
            'transactionId' :transactionId,
          },
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: description == 'Completed'
                ? Colors.green[100]
                : description == 'Failed'
                    ? Colors.red[100]
                    : Colors.orange[100],
            child: Icon(Icons.currency_rupee_sharp,
                color: description == 'Completed'
                    ? Colors.green
                    : description == 'Failed'
                        ? Colors.red
                        : Colors.orange),
          ),
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(paymentMethod),
              Text(transactionId),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: description == 'Completed'
                      ? Colors.green[100]
                      : description == 'Failed'
                          ? Colors.red[100]
                          : description == 'Pending'
                              ? Colors.orange[100]
                              : Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  description,
                  style: TextStyle(
                    color: description == 'Completed'
                        ? Colors.green
                        : description == 'Failed'
                            ? Colors.red
                            : description == 'Pending'
                                ? Colors.orange
                                : Colors.black, // Default color for other cases
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
