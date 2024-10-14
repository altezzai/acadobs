import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController dateController; // Expose the controller
  final Function(DateTime) onDateSelected;
  final String label;

  CustomDatePicker({
    required this.dateController,
    required this.onDateSelected,
    required this.label,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              // Adjust the font size for the calendar picker
              bodyMedium: TextStyle(fontSize: 14), // Smaller font for dates
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      onDateSelected(pickedDate); // Trigger callback
      dateController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate); // Update controller text
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController, // Use the external controller
      readOnly: true,
      style: TextStyle(fontSize: 14), // Smaller font size for the input text
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 18),
        labelText: label,
        labelStyle: TextStyle(fontSize: 14), // Adjust label font size
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_today,
            size: 18,
          ),
          onPressed: () => _selectDate(context),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
