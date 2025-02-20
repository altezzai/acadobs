import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class CommonFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CommonFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20), // Adjust height from bottom
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: Responsive.width * 90,
          height: 60,
          child: FloatingActionButton.extended(
            onPressed: onPressed,
            label: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: Colors.black,
            elevation: 6,
          ),
        ),
      ),
    );
  }
}
