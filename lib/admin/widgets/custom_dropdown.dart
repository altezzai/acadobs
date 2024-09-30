import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Icon? iconData;

  CustomDropdown({
    Key? key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDropdown(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey), // Match CustomTextField
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
          child: Row(
            children: [
              if (iconData != null) ...[
                iconData!,
                SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  value ?? hintText,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: value != null ? Colors.black87 : Colors.grey,
                  ),
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100), // Adjust position if needed
      items: items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Text(
              item,
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
            ),
          ),
        );
      }).toList(),
    ).then((String? newValue) {
      if (newValue != null) {
        onChanged(newValue);
      }
    });
  }
}