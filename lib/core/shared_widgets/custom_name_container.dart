import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart'; // Assuming you're using a responsive utility

class CustomNameContainer extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double horizontalWidth;

  const CustomNameContainer(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.horizontalWidth = 13})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.height * 3,
            horizontal: Responsive.width * horizontalWidth,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: const Color(0xff555556),
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
