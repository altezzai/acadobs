import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  String? _selectedClass;

  String? get selectedClass => _selectedClass;

  String? _selectedDivision;
  String? get selectedDivision => _selectedDivision;

  String? _selectedLeaveType;
  String? get selectedLeaveType=> _selectedLeaveType;

  String? _selectedSubject;
  String? get selectedSubject=> _selectedSubject;

  String? _selectedPeriod;
  String? get selectedPeriod=> _selectedPeriod;


  void setSelectedClass(String? value) {
    _selectedClass = value;
    notifyListeners(); // Notify listeners to rebuild widgets that depend on this state
  }

   void setSelectedDivision(String? value) {
    _selectedDivision = value;
    notifyListeners();
  }

  void setSelectedLeaveType(String? value) {
    _selectedLeaveType = value;
    notifyListeners();
  }

  void setSelectedSubject(String? value) {
    _selectedSubject = value;
    notifyListeners();
  }

   void setSelectedPeriod(String? value) {
    _selectedPeriod = value;
    notifyListeners();
  }

}
