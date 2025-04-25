import 'package:flutter/material.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';

class SubjectTile extends StatelessWidget {
  final String subjectName;
  final String description;
  final String iconPath;
  final Color iconColor;
  final VoidCallback onEdit;
  // final VoidCallback onDelete;
  final double topRadius;
  final double bottomRadius;

  const SubjectTile({
    Key? key,
    required this.subjectName,
    required this.description,
    required this.iconPath,
    required this.iconColor,
    required this.onEdit,
    // required this.onDelete,
    this.topRadius = 10,
    this.bottomRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, bottom: 12, top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomRadius),
          bottomRight: Radius.circular(bottomRadius),
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
        ),
      ),
      child: Row(
        children: [
          // Subject Icon
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 51),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                iconPath,
                height: 22,
                width: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Subject Name & Description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalizeFirstLetter(subjectName),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                capitalizeFirstLetter(description),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Spacer(),
          // Three-dot menu button
          PopupMenuButton<String>(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            elevation: 4, // Adds slight shadow for better visibility
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: const [
                    Icon(Icons.edit, size: 18, color: Colors.blueAccent),
                    SizedBox(width: 8),
                    Text('Edit', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              // PopupMenuItem(
              //   value: 'delete',
              //   child: Row(
              //     children: const [
              //       Icon(Icons.delete, size: 18, color: Colors.redAccent),
              //       SizedBox(width: 8),
              //       Text('Delete', style: TextStyle(fontSize: 14)),
              //     ],
              //   ),
              // ),
            ],
            icon: const Icon(Icons.more_vert, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
