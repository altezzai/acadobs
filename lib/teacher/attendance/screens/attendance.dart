import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/admin/widgets/custom_textfield.dart';
import 'package:school_app/teacher/attendance/widgets/attendance_tile.dart';
import 'package:school_app/teacher/attendance/widgets/custom_dropdown.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class Attendance extends StatelessWidget {
  Attendance({super.key});

  List<String> titles = [
    "Set Holiday",
    "Set All Present",
    "Set All Absent",
    "Set All Leave"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: Responsive.height * 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Responsive.width * 30,
                  ),
                  Text(
                    "Attendance",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/admin.png'),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 5),
              Row(
                children: [
                  const Expanded(
                    child: CustomDropdown(title: "Class", icon: Icons.school),
                  ),
                  SizedBox(width: Responsive.width * 6),
                  const Expanded(
                    child:  CustomDropdown(
                        title: "Division", icon: Icons.filter_list),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height * 1),
              CustomTextfield(
                hintText: "dd/mm/yyyy",
                iconData: const Icon(Icons.calendar_month),
              ),
              SizedBox(height: Responsive.height * 2),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return AttendanceTile(title: titles[index]);
                    }),
              ),
              SizedBox(height: Responsive.height * 2),
              const Text("Or"),
              SizedBox(height: Responsive.height * 2),
              const AttendanceTile(title: "Take Attendance"),
              SizedBox(height: Responsive.height * 3),
              CustomButton(text: "Submit", onPressed: () {})
            ],
          ),
        )),
      ),
    );
  }
}
