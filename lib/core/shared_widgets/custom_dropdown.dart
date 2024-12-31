import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';

class CustomDropdown extends StatelessWidget {
  final String dropdownKey; // Unique key for each dropdown
  final String label;
  final IconData icon;
  final List<String> items;
  final onChanged;
  final validator;

  const CustomDropdown(
      {Key? key,
      required this.dropdownKey, // Unique key
      required this.label,
      required this.icon,
      required this.items,
      this.onChanged, // Add onChanged callback parameter
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownProvider>(
      builder: (context, dropdownProvider, child) {
        return DropdownButtonFormField<String>(
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(icon),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          value: dropdownProvider.getSelectedItem(dropdownKey).isNotEmpty
              ? dropdownProvider.getSelectedItem(dropdownKey)
              : null,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              dropdownProvider.setSelectedItem(dropdownKey, newValue);
              onChanged?.call(newValue); // Invoke the callback if provided
            }
          },
          dropdownColor: Colors.white,
          style: const TextStyle(color: Colors.black),
          menuMaxHeight: 200,
          borderRadius: BorderRadius.circular(24),
        );
      },
    );
  }
}
