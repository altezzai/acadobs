import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';

class CustomFilePicker extends StatelessWidget {
  final String label;
  final String fieldName;
  final String? Function(String?)? validator; // Added validator parameter
  final bool isImagePicker; 

  CustomFilePicker({
    required this.label,
    required this.fieldName,
    this.validator, // Accept validator in the constructor
    this.isImagePicker = false, // Default to all files
  });

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FilePickerProvider>(context);
    //final selectedFile = fileProvider.getFile(fieldName)?.path;

    return FormField<String>(
      validator: validator, // Use the passed validator here
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                 // Restrict to images if `isImagePicker` is true
                await fileProvider.pickFile(fieldName, imagesOnly: isImagePicker);
                state.didChange(fileProvider.getFile(fieldName)?.path);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        fileProvider.getFile(fieldName)?.name ??
                            'No file selected',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    const Icon(Icons.upload_file, color: Colors.grey),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
