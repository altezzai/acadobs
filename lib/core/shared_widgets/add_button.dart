import 'package:flutter/material.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String iconPath;
  const AddButton({
    super.key,
    required this.iconPath,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width * 36,
      height: Responsive.height * 9,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 22,
                width: 20,
                color: whiteColor,
              ),
              const SizedBox(height: 6),
              Text(text),
            ],
          )),
    );
  }
}
