import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  final String amount;
  final String name;
  final String time;
  final String? status;

  const PaymentItem({
    required this.amount,
    required this.name,
    required this.time,
    this.status,
  });

  // Method to get color based on status
  Color _getStatusColor() {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.yellow;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(width: 10),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: _getStatusColor(), // Use color based on status
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
