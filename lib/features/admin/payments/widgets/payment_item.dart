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
        return Colors.orange;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getStatusColor().withOpacity(0.2),
        child: Icon(Icons.currency_rupee, color: _getStatusColor()),
      ),
      title: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min, // Shrinks the row to fit the child
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor().withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: _getStatusColor(),
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Keeps the trailing widget compact
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
