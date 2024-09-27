import 'package:flutter/material.dart';
import 'package:school_app/admin/widgets/custom_button.dart';
import 'package:school_app/global%20widgets/custom_appbar.dart';
import 'package:school_app/teacher_section/marks/widgets/mark_tile.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/responsive.dart';

// ignore: must_be_immutable
class StudentMarklist extends StatelessWidget {
  StudentMarklist({super.key});

  TextEditingController markController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const CustomAppbar(
              title: "9th B",
              isBackButton: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "01/09/2024",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Total: 100",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold, color: blackColor),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MarkTile(
                    studentName: "Theodor",
                    studentNumber: (index + 1).toString(),
                    markController: markController,
                    gradeController: gradeController);
              },
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomButton(text: "Submit", onPressed: () {}),
            SizedBox(
              height: Responsive.height * 2,
            ),
          ],
        ),
      ),
    ));
  }
}
