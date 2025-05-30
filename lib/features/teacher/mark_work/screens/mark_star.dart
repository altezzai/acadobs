import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/mark_work/widgets/star_container.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';

class MarkStar extends StatefulWidget {
  const MarkStar({super.key});

  @override
  _MarkStarState createState() => _MarkStarState();
}

class _MarkStarState extends State<MarkStar> {
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    _updateDate();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateDate());
  }

  void _updateDate() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    setState(() {
      currentDate = formattedDate;
    });
  }

  final students = [
    {"id": 1, "name": "Theodore T.C. Calvin"},
    {"id": 2, "name": "Rick Wright"},
    {"id": 3, "name": "Tom Selleck"},
    {"id": 4, "name": "Theodore T.C. Calvin"},
    {"id": 5, "name": "Rick Wright"},
    {"id": 6, "name": "Tom Selleck"},
    {"id": 7, "name": "Theodore T.C. Calvin"},
    {"id": 8, "name": "Rick Wright"},
    {"id": 9, "name": "Tom Selleck"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            CustomAppbar(
              title: 'Hindi Imposition',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: Text(
                currentDate,
                style: textThemeData.labelSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(Responsive.height * .5),
                    child: StarContainer(
                      rollNo: students[index]['id']!.toString(),
                      name: students[index]['name']!.toString(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            CommonButton(
              onPressed: () {},
              widget: Text('Submit'),
            ),
            // CustomButton(
            //   text: 'Submit',
            //   onPressed: () {},
            // ),
            SizedBox(
              height: Responsive.height * 2,
            ),
          ],
        ),
      ),
    );
  }
}
