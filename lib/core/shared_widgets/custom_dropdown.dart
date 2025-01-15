import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';

class CustomDropdown extends StatelessWidget {
  final String dropdownKey; // Unique key for each dropdown
  final String label;
  final IconData icon;
  final List<String> items;
  final Function(String)? onChanged; // Callback for value changes
  final String? Function(String?)? validator; // Validator for the dropdown

  const CustomDropdown({
    Key? key,
    required this.dropdownKey, // Unique key
    required this.label,
    required this.icon,
    required this.items,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownProvider>(
      builder: (context, dropdownProvider, child) {
        final selectedValue =
            dropdownProvider.getSelectedItem(dropdownKey).isNotEmpty
                ? dropdownProvider.getSelectedItem(dropdownKey)
                : null;

        return DropdownButtonFormField<String>(
          value: selectedValue,
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
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              dropdownProvider.setSelectedItem(dropdownKey, newValue);
              if (onChanged != null) {
                onChanged!(newValue); // Trigger the external callback
              }
            }
          },
          validator: validator,
          dropdownColor: Colors.white,
          style: const TextStyle(color: Colors.black),
          menuMaxHeight: 200,
          borderRadius: BorderRadius.circular(24),
        );
      },
    );
  }
}
