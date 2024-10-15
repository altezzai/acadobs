import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateProvider with ChangeNotifier {
  DateTime? _selectedDate;
  String _formattedDate = '';

  DateTime? get selectedDate => _selectedDate;
  String get formattedDate => _formattedDate;

  void selectDate(DateTime date) {
    _selectedDate = date;
    _formattedDate = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners(); // Notify listeners about the change
  }
}
