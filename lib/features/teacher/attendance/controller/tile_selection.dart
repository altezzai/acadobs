import 'package:flutter/material.dart';

class TileSelectionProvider extends ChangeNotifier {
  String? _selectedTitle;

  String? get selectedTitle => _selectedTitle;

  void selectTitle(String title) {
    _selectedTitle = title;
    notifyListeners();
  }

  bool isSelected(String title) => _selectedTitle == title;
}
