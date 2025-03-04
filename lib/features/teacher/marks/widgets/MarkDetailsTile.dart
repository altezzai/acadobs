import 'package:flutter/material.dart';
import 'package:school_app/base/utils/constants.dart';

// ignore: must_be_immutable
class MarkDetailsTile extends StatefulWidget {
  final String studentName;
  final String studentNumber;
  final TextEditingController markController;
  //final TextEditingController gradeController;
  String? attendanceStatus; // Use the status from MarksUploadModel
  //final ValueChanged<String?> onAttendanceChanged;

  MarkDetailsTile({
    super.key,
    required this.studentName,
    required this.studentNumber,
    required this.markController,
    //required this.gradeController,
    this.attendanceStatus,
    //required this.onAttendanceChanged,
  });

  @override
  _MarkDetailsTileState createState() => _MarkDetailsTileState();
}

class _MarkDetailsTileState extends State<MarkDetailsTile> {
  late String? attendanceStatus;

  @override
  void initState() {
    super.initState();
    attendanceStatus = widget.attendanceStatus; // Default to "Present" if null
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: greyColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // Student Number with Circle Avatar
          SizedBox(
            width: 40, // Fixed width for the avatar column
            child: CircleAvatar(
              radius: 15,
              backgroundColor: whiteColor,
              child: Text(
                widget.studentNumber,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Student Name
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 120),
            child: Text(
              widget.studentName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          const Spacer(),

          // Editable Mark Field
          SizedBox(
            width: 60,
            child: _markField(controller: widget.markController, hintText: "0"),
          ),

          // // Editable Grade Field
          // SizedBox(
          //   width: 60,
          //   child:
          //       _markField(controller: widget.gradeController, hintText: "A"),
          // ),

          // Dropdown for Attendance Status
          SizedBox(
            width: 100,
            child: _attendanceBox(attendanceStatus??"")
            
          ),
        ],
      ),
    );
  }

  Widget _markField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 20, color: greyColor),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
  Widget _attendanceBox(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
