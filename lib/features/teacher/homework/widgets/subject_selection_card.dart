import 'package:flutter/material.dart';

class SubjectSelectionCard extends StatelessWidget {
  final String subjectName;
  final int subjectId;
  final bool isSelected;
  final Function(bool?) onSelect;

  const SubjectSelectionCard({
    super.key,
    required this.subjectName,
    required this.subjectId,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(subjectName, style: TextStyle(fontSize: 16)),
          Spacer(),
          Checkbox(
            value: isSelected,
            onChanged: onSelect,
          ),
        ],
      ),
    );
  }
}
