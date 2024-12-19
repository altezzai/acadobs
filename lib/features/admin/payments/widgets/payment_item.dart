import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  final String amount;
  final String name;
  final String time;
  final String? status;
  final VoidCallback? onTap;
  final double? topRadius; // Added property
  final double? bottomRadius; // Added property

  const PaymentItem({
    required this.amount,
    required this.name,
    required this.time,
    this.status,
    this.onTap,
    this.topRadius, // Initialize property
    this.bottomRadius, // Initialize property
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
        return Colors.green; // Default color for unknown status
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 2, horizontal: 2), // Space around each tile
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadius ?? 8), // Default radius: 8
            topRight: Radius.circular(topRadius ?? 8), // Default radius: 8
            bottomLeft: Radius.circular(bottomRadius ?? 8), // Default radius: 8
            bottomRight: Radius.circular(bottomRadius ?? 8), // Default radius: 8
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getStatusColor().withOpacity(0.2),
            child: Icon(Icons.currency_rupee, color: _getStatusColor()),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4), // Space between amount and name
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600], // Subdued color for the name
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 4), // Space between time and status
              if (status != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    status!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(),
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

