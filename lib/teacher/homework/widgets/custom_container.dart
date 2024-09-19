import 'package:flutter/material.dart';
import 'package:school_app/theme/text_theme.dart';
import 'package:school_app/utils/responsive.dart';

class CustomContainer extends StatelessWidget {
  final IconData leadingIcon;
  final String text;
  final IconData? trailingIcon;
  final double width;

  const CustomContainer(
      {Key? key,
      required this.leadingIcon,
      required this.text,
      this.trailingIcon,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.height * 2),
      decoration: BoxDecoration(
        color: Color(0xffEAEAEA),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Icon(leadingIcon, color: Colors.black),
          SizedBox(
            width: Responsive.width * 3,
          ),
          Text(
            text,
            style: textThemeData.bodyMedium!.copyWith(fontSize: 16),
          ),
          SizedBox(
            width: width,
          ),
          Icon(trailingIcon, color: Colors.black),
        ],
      ),
    );
  }
}
