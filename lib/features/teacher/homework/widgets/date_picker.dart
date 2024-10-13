import 'package:flutter/material.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';

class DatePicker extends StatelessWidget {
  final String title;
  const DatePicker({super.key, required this.title,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textThemeData.bodyMedium!.copyWith(fontSize: 18),
          ),
          SizedBox(height: Responsive.height * 1),
          CustomTextfield(
            hintText: "dd/mm/yyyy",
            iconData: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}