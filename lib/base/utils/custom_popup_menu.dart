import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomPopupMenu({
    Key? key,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      elevation: 4, // Adds slight shadow
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
      itemBuilder: (context) => [
        _buildMenuItem('edit', Icons.edit, 'Edit', Colors.blueAccent),
        _buildMenuItem('delete', Icons.delete, 'Delete', Colors.redAccent),
      ],
      icon: const Icon(Icons.more_vert, color: Colors.black54),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
      String value, IconData icon, String text, Color iconColor) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
