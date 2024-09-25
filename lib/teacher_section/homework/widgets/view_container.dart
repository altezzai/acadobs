import 'package:flutter/material.dart';
import 'package:school_app/utils/responsive.dart';

class ViewContainer extends StatelessWidget {
  final Color bcolor;
  final Color icolor;
  final IconData icon;
  const ViewContainer({
    super.key,
    required this.bcolor,
    required this.icolor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.width * 20,
          vertical: Responsive.height * 3,
        ),
        decoration: BoxDecoration(
          color: bcolor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          size: Responsive.width * 50,
          color: icolor,
        ),
      ),
    );
  }
}
