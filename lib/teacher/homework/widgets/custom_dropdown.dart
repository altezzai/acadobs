import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomDropdown({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        isDense: true,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          prefixIcon: Icon(icon),
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(title),
        ),
        items: const [
          DropdownMenuItem(
              alignment: Alignment.bottomLeft,
              value: 'Select',
              child: Text('V')),
          DropdownMenuItem(value: 'Select', child: Text('VI')),
        ],
        onChanged: (value) {});
  }
}
