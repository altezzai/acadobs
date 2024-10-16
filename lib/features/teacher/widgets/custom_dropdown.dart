// import 'package:flutter/material.dart';

// class CustomDropdown extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final List<DropdownMenuItem<String>> items; // Accept items dynamically
//   final String? selectedValue; // Accept the currently selected value
//   final Function(String?) onChanged; // Callback for when a value is selected

//   const CustomDropdown({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.items,
//     this.selectedValue,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       // isDense: false, // Prevents dropdown from adopting the field's shape
//       menuMaxHeight: 200,
//       // Sets a max height for the dropdown menu
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.grey),
//         ),
//         prefixIcon: Padding(
//           padding: const EdgeInsets.only(left: 6),
//           child: Icon(icon),
//         ),
//       ),
//       icon: const Icon(Icons.arrow_drop_down), // Customize dropdown icon
//       value: selectedValue,
//       hint: Text(title),
//       items: items,
//       onChanged: onChanged,
//       dropdownColor: Colors.white, // Set dropdown background color
//       style: const TextStyle(color: Colors.black), // Style dropdown text
//       borderRadius: BorderRadius.circular(24), // Set shape of the dropdown menu
//     );
//   }
// }
