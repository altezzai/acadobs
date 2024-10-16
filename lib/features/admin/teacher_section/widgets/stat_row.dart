import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatItem(count: '23', label: 'Presents'),
        StatItem(count: '7', label: 'Late'),
        StatItem(count: '3', label: 'Absent'),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final String count;
  final String label;

  const StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}
