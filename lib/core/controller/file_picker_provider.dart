import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerProvider with ChangeNotifier {
 Map<String, PlatformFile?> _files = {};

  PlatformFile? getFile(String fieldName) => _files[fieldName];

  // Method to pick a file for a specific field
  Future<void> pickFile(String fieldName) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _files[fieldName] = result.files.first;
      notifyListeners();
    }
  }

  void clearFile(String fieldName) {
    _files.remove(fieldName);
    notifyListeners();
  }

  // Method to clear all files
  void clearAllFiles() {
    _files.clear();
    notifyListeners();
  }
}
