import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  final String amount;
  final String name;
  final String time;

  const PaymentItem({
    required this.amount,
    required this.name,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[100],
        child: Icon(Icons.currency_rupee, color: Colors.green),
      ),
      title: Text(
        amount,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        name,
        style: TextStyle(fontSize: 16),
      ),
      trailing: Text(
        time,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}