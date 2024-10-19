import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/teacher/controller/dropdown_provider.dart';

class CustomDropdown extends StatelessWidget {
  final String dropdownKey; // Unique key for each dropdown
  final String label;
  final IconData icon;
  final List<String> items;

  const CustomDropdown({
    Key? key,
    required this.dropdownKey, // Unique key
    required this.label,
    required this.icon,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownProvider>(
      builder: (context, dropdownProvider, child) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(icon),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
          value: dropdownProvider.getSelectedItem(dropdownKey).isNotEmpty
              ? dropdownProvider.getSelectedItem(dropdownKey)
              : null,
          // hint: Text(label), // Hint text
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              dropdownProvider.setSelectedItem(dropdownKey, newValue);
            }
          },
          dropdownColor: Colors.white, // Dropdown background color
          style: const TextStyle(color: Colors.black), // Style dropdown text
          menuMaxHeight: 200, // Sets a max height for the dropdown menu
          borderRadius: BorderRadius.circular(24), // Dropdown menu shape
        );
      },
    );
  }
}
