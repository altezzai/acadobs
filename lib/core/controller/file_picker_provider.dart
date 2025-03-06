// import 'dart:io';

import 'dart:io';

import 'package:archive/archive_io.dart'; // For zipping PDFs
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class FilePickerProvider with ChangeNotifier {
  final Map<String, PlatformFile?> _files = {};

  PlatformFile? getFile(String fieldName) => _files[fieldName];

  Future<void> pickFile(String fieldName) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile selectedFile = result.files.first;
      File file = File(selectedFile.path!);

      if (_isImage(file.path)) {
        File? compressedFile = await _compressImage(file);
        _storeFile(fieldName, compressedFile ?? file);
      } else if (_isPDF(file.path)) {
        File? compressedPDF = await _compressPDF(file);
        _storeFile(fieldName, compressedPDF ?? file);
      } else {
        _storeFile(fieldName, file);
      }

      notifyListeners();
    }
  }

  void clearFile(String fieldName) {
    _files.remove(fieldName);
    notifyListeners();
  }

  void clearAllFiles() {
    _files.clear();
    notifyListeners();
  }

  void _storeFile(String fieldName, File file) {
    _files[fieldName] = PlatformFile(
      name: file.path.split('/').last,
      path: file.path,
      size: file.lengthSync(),
    );
  }

  bool _isImage(String filePath) {
    return filePath.endsWith('.jpg') ||
        filePath.endsWith('.jpeg') ||
        filePath.endsWith('.png') ||
        filePath.endsWith('.gif');
  }

  bool _isPDF(String filePath) {
    return filePath.endsWith('.pdf');
  }

  Future<File?> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    String targetPath =
        '${dir.path}/${file.path.split('/').last}_compressed.jpg';

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 85,
    );

    return compressedFile != null ? File(compressedFile.path) : null;
  }

  Future<File?> _compressPDF(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      String zipPath = '${dir.path}/${file.path.split('/').last}.zip';

      final zipFile = File(zipPath);
      final archive = Archive()
        ..addFile(ArchiveFile(file.path.split('/').last, file.lengthSync(),
            await file.readAsBytes()));

      await zipFile.writeAsBytes(ZipEncoder().encode(archive)!);
      return zipFile;
    } catch (e) {
      print("PDF Compression Error: $e");
      return null;
    }
  }
}
