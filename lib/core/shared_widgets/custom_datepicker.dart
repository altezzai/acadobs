import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController dateController; // Expose the controller
  final Function(DateTime) onDateSelected;
  final String? hintText;
  final String label;
  final String? Function(String?)? validator;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate; // Add customizable initial date

  CustomDatePicker({
    required this.dateController,
    required this.onDateSelected,
    required this.label,
    this.hintText,
    this.validator,
    DateTime? firstDate,
    DateTime? lastDate,
    this.initialDate, // Optional initial date
  })  : firstDate = firstDate ?? DateTime(2000), // Default firstDate
        lastDate = lastDate ?? DateTime.now(); // Default lastDate

  Future<void> _selectDate(BuildContext context) async {
    // Determine the effective initial date
    final DateTime effectiveInitialDate = dateController.text.isNotEmpty
        ? DateFormat('yyyy-MM-dd').parse(dateController.text)
        : (initialDate ?? DateTime.now());

    final DateTime clampedInitialDate = effectiveInitialDate.isBefore(firstDate)
        ? firstDate
        : (effectiveInitialDate.isAfter(lastDate)
            ? lastDate
            : effectiveInitialDate);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: clampedInitialDate, // Updated logic
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
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
    return TextFormField(
      validator: validator,
      controller: dateController, // Use the external controller
      readOnly: true,
      style: TextStyle(
          fontSize: 14,
          fontWeight:
              FontWeight.normal), // Smaller font size for the input text
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey, // Change label text color here
        ), // Adjust label font size
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_month,
            size: 22,
          ),
          onPressed: () => _selectDate(context),
        ),
      ),
    );
  }
}
