import 'package:flutter/material.dart';
import 'package:school_app/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
      ),
    );
  }
}
