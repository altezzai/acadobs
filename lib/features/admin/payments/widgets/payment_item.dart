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
            vertical: .5, horizontal: 2), // Space around each tile
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadius ?? 8), // Default radius: 8
            topRight: Radius.circular(topRadius ?? 8), // Default radius: 8
            bottomLeft: Radius.circular(bottomRadius ?? 8), // Default radius: 8
            bottomRight:
                Radius.circular(bottomRadius ?? 8), // Default radius: 8
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getStatusColor().withValues(alpha: 51),
            radius: 20,
            child: Image.asset(
              'assets/icons/money.png',
              width: 20,
              height: 20,
              color: _getStatusColor(), // Apply color
              colorBlendMode: BlendMode.srcATop, // Apply blend mode
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹ ${double.tryParse(amount)?.toInt() ?? 0}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4), // Space between amount and name
              Text(
                name,
                style: TextStyle(
                  fontSize: 12,
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
                    color: _getStatusColor().withValues(alpha: 51),
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
