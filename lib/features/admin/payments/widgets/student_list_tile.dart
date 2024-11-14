import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';

class StudentListTile extends StatelessWidget {
  final String rollNumber;
  final String name;
  final int index; // Unique index for each student

  const StudentListTile({
    Key? key,
    required this.rollNumber,
    required this.name,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentIdController>(
      builder: (context, selectionProvider, child) {
        return Container(
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                child: Text(rollNumber, style: TextStyle(fontSize: 12)),
              ),
              SizedBox(width: 10),
              Text(capitalizeFirstLetter(name), style: TextStyle(fontSize: 16)),
              Spacer(),
              Checkbox(
                value: selectionProvider.isSelected(index),
                onChanged: (bool? selected) {
                  selectionProvider.toggleSelection(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
