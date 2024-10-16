import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/features/teacher/homework/widgets/date_picker.dart';
import 'package:school_app/features/teacher/widgets/custom_dropdown_2.dart';

// ignore: must_be_immutable
class HomeWork extends StatelessWidget {
  HomeWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pushReplacementNamed(AppRouteConst.homeworkRouteName);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Center(
          child: Text(
            'Add Homework',
            style:
                textThemeData.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height * 3,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: CustomDropdown(
              //           icon: Icons.school,
              //           label: "Select Class",
              //           items: ["1", "2", "3", "4", "5"]),
              //     ),
              //     SizedBox(width: Responsive.width * 6),
              //     Expanded(
              //       child: CustomDropdown(
              //           icon: Icons.school,
              //           label: "Select Division",
              //           items: ["A", "B", "C", "D", "E"]),
              //     ),
              //   ],
              // ),
              SizedBox(height: Responsive.height * 2),
              Row(
                children: [
                  const DatePicker(title: "Start Date"),
                  SizedBox(width: Responsive.width * 2),
                  const DatePicker(title: "End Date")
                ],
              ),
              SizedBox(height: Responsive.height * 2),
              CustomTextfield(
                hintText: "Total Mark",
                iconData: const Icon(Icons.book),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Text(
                'Homework details',
                style: textThemeData.bodyMedium!.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              CustomTextfield(
                hintText: "Title",
                iconData: const Icon(Icons.text_fields),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                cursorHeight: 25.0, // Sets the cursor height
                style: const TextStyle(fontSize: 16),
                minLines: 4,
                maxLines: null,
              ),
              SizedBox(
                height: Responsive.height * 7,
              ),
              CustomButton(text: 'Submit', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
