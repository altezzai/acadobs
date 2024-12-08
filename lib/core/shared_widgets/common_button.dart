import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback? onPressed;
  const CommonButton(
      {super.key, required this.onPressed, required this.widget});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: widget,
    );
  }
}
