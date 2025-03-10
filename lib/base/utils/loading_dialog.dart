import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context, {String message = "Please wait..."}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents manual closing
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(message, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
