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
                transactionId: "",
                description: "",
                fileUpload: "",
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
              Consumer<PaymentController>(builder: (context, value, child) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.payments.take(4).length,
                  itemBuilder: (context, index) {
                    return PaymentCard(
                      amountTitle: value.payments[index].amountPaid ?? "",
                      name: value.payments[index].userId.toString(),
                      transactionId:
                          value.payments[index].transactionId.toString(),
                      time: TimeFormatter.formatTimeFromString(
                        value.payments[index].createdAt.toString(),
                      ),
                      description:
                          value.payments[index].paymentStatus.toString(),
                      fileUpload: value.payments[index].fileUpload,

                      // description:
                      //     value.notices[index].description ?? "",
                      // noticeTitle: value.notices[index].title ?? "",
                      // date: DateFormatter.formatDateString(
                      //     value.notices[index].date.toString()),
                      // time: TimeFormatter.formatTimeFromString(
                      //     value.notices[index].createdAt.toString())
                    );
                  },
                );
              }),
              // PaymentCard(
              //   amountTitle: "250",
              //   name: "\tMuhammed Rafsal N",
              //   time: "09:00 am",
              // ),
              // PaymentCard(
              //   amountTitle: "1500",
              //   name: "\tManuprasad K",
              //   time: "09:00 am",
              // ),
              // PaymentCard(
              //   amountTitle: "500",
              //   name: "\tAswin Koroth",
              //   time: "09:00 am",
              // ),
              // PaymentCard(
              //   amountTitle: "1000",
              //   name: "\tMuhammed Rafsal N",
              //   time: "09:00 am",
              // ),
            ],
          ),
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

  const PaymentCard({
    super.key,
    required this.amountTitle,
    required this.name,
    required this.time,
    required this.description,
    required this.transactionId,
    required this.fileUpload,
  });

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
          },
        );
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
          subtitle: Text(transactionId),
          trailing: Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
