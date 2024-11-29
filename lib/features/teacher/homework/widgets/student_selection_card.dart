import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/controller/student_id_controller.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';

class StudentSelectionCard extends StatelessWidget {
  final String name;
  final int studentId; // Change to int to match teacherId type
  final int index;

  const StudentSelectionCard({
    super.key,
    required this.name,
    required this.studentId,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final studentController = Provider.of<StudentIdController>(context);

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
            backgroundColor: Colors.black26,
            child: Text(studentId.toString(),
                style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          SizedBox(width: 10),
          Text(capitalizeFirstLetter(name), style: TextStyle(fontSize: 16)),
          Spacer(),
          Checkbox(
            value: studentController.isStudentSelected(studentId),
            onChanged: (bool? selected) {
              studentController.toggleStudentSelection(studentId);
            },
          ),
        ],
      ),
    );
  }
}
