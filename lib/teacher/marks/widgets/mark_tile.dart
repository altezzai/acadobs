import 'package:flutter/material.dart';
import 'package:school_app/utils/constants.dart';

class MarkTile extends StatelessWidget {
  final String studentName;
  final String studentNumber;
  final TextEditingController markController;
  final TextEditingController gradeController;

  const MarkTile({
    super.key,
    required this.studentName,
    required this.studentNumber,
    required this.markController,
    required this.gradeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: greyColor, // Border color to match the screenshot
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // Student Number with Circle Avatar
          CircleAvatar(
            radius: 15,
            backgroundColor: whiteColor, // Light grey background
            child: Text(
              studentNumber,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Student Name
          Expanded(
            flex: 3,
            child: Text(
              studentName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          // Editable Mark Field
          Expanded(
              flex: 1,
              child: _markField(controller: markController, hintText: "0")),

          // Editable Grade Field
          Expanded(
              flex: 1,
              child: _markField(controller: gradeController, hintText: "A")),
        ],
      ),
    );
  }

  Widget _markField(
      {required TextEditingController controller, required String hintText}) {
    return TextField(
      controller: controller,
      // keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 28, color: greyColor),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: greyColor),
            borderRadius: BorderRadius.zero),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: greyColor),
        ),
        errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero),

        border: InputBorder.none, // Remove borders around the text field
      ),
    );
  }
}
