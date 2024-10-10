import 'package:flutter/material.dart';

class Work {
  final String workType;
  final String subject;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;

  Work({
    required this.workType,
    required this.subject,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });
}
