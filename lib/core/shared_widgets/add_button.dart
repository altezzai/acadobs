import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const AddButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width * 36,
      height: Responsive.height * 8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(text)),
    );
  }
}
