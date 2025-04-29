import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

Widget CustomContainer({
  required Color color,
  required String text,
  IconData icon = Icons.dashboard_customize_outlined,
  required VoidCallback ontap,
  bool isCenterText = false,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(Responsive.height * 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment:
            isCenterText ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
