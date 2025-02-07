import 'package:flutter/material.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';

class SubjectTile extends StatelessWidget {
  final String subjectName;
  final String description;
  final String iconPath;
  final Color iconColor;
  final VoidCallback onEdit;
  final double? topRadius;
  final double? bottomRadius;

  const SubjectTile({
    Key? key,
    required this.subjectName,
    required this.description,
    required this.iconPath,
    required this.iconColor,
    required this.onEdit,
    this.topRadius,
    this.bottomRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius ?? 8),
          topRight: Radius.circular(topRadius ?? 8),
          bottomLeft: Radius.circular(bottomRadius ?? 8),
          bottomRight: Radius.circular(bottomRadius ?? 8),
        ),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Image.asset(iconPath, width: 24, height: 24),
        ),
        title: Text(capitalizeFirstLetter(
          subjectName,),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(capitalizeFirstLetter(
          description),
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: TextButton(
          onPressed: onEdit,
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
