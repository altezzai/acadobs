import 'package:flutter/material.dart';

class ReportTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final double? topRadius; // Optional top corner radius
  final double? bottomRadius; // Optional bottom corner radius

  const ReportTile({
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.topRadius,
    this.bottomRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 4, horizontal: 2), // Tile spacing
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadius ?? 8),
            topRight: Radius.circular(topRadius ?? 8),
            bottomLeft: Radius.circular(bottomRadius ?? 8),
            bottomRight: Radius.circular(bottomRadius ?? 8),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.blue.withValues(alpha: 51), // Icon background
            child: Icon(icon, color: Colors.blue), // Icon with primary color
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle ?? "",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600], // Subdued subtitle color
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
