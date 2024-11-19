import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';

class StaffSelectionCard extends StatelessWidget {
  final String name;
  final int staffId; // Change to int to match teacherId type
  final int index;

  const StaffSelectionCard({
    super.key,
    required this.name,
    required this.staffId,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final teacherController = Provider.of<TeacherController>(context);

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
            child: Text(staffId.toString(),
                style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
          SizedBox(width: 10),
          Text(capitalizeFirstLetter(name), style: TextStyle(fontSize: 16)),
          Spacer(),
          Checkbox(
            value: teacherController.isTeacherSelected(staffId),
            onChanged: (bool? selected) {
              teacherController.toggleTeacherSelection(staffId);
            },
          ),
        ],
      ),
    );
  }
}
