import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/core/controller/file_picker_provider.dart';

class CustomFilePicker extends StatelessWidget {
  final String label;

  CustomFilePicker({required this.label});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FilePickerProvider>(context);

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
            await fileProvider.pickFile();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fileProvider.selectedFile?.name ?? 'No file selected',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const Icon(Icons.upload_file, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
