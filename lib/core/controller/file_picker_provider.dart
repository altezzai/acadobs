import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerProvider with ChangeNotifier {
  PlatformFile? _selectedFile;

  PlatformFile? get selectedFile => _selectedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectedFile = result.files.first;
      notifyListeners();
    }
  }

  void clearFile() {
    _selectedFile = null;
    notifyListeners();
  }
}
