import 'package:flutter/material.dart';

class DropdownProvider with ChangeNotifier {
  Map<String, String> _selectedItems = {}; // Store selected items for multiple dropdowns

  String getSelectedItem(String dropdownKey) {
    return _selectedItems[dropdownKey] ?? '';
  }

  void setSelectedItem(String dropdownKey, String newValue) {
    _selectedItems[dropdownKey] = newValue;
    notifyListeners(); // Notify listeners when the value changes
  }
}
