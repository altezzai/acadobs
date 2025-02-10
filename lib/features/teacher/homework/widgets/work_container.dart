import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/responsive.dart';

class WorkContainer extends StatelessWidget {
  final Color bcolor;
  final Color icolor;
  final String? iconPath;
  final IconData icon;
  final String work;
  final String sub;
  final String prefixText;
  final Color prefixColor;
  final VoidCallback? onTap;
  final double bottomRadius;
  final double topRadius;

  const WorkContainer(
      {super.key,
      this.bcolor = const Color(0xffFFFCCE),
      this.icolor = const Color(0xffBCB54F),
      this.iconPath ,
      this.icon=Icons.invert_colors_on_sharp,
      required this.sub,
      required this.work,
      this.prefixText = "View",
      this.prefixColor = blackColor,
      this.onTap,
      this.bottomRadius = 10,
      this.topRadius = 10});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomRadius),
              bottomRight: Radius.circular(bottomRadius),
              topLeft: Radius.circular(topRadius),
              topRight: Radius.circular(topRadius)),
        ),
        // border: Border.all(color: Colors.grey.shade300, width: 1),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade300,
        //     blurRadius: 1,
        //     // spreadRadius: 3,
        //   ),
        // ],

        child: Row(
          children: [
             Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: bcolor,
                    // borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child:  iconPath != null
                    ?Image.asset(
                    iconPath??"",
                    color: icolor,
                    height: 22,
                    width: 20,
                  ):Icon(icon , size: 22, color: icolor),
                )),
           
           SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(capitalizeFirstLetter(work),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      )),
                      SizedBox(height: 4),
                  Text(
                    capitalizeFirstLetter(sub),
                   style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                  )
                ],
              ),
            ),
            Spacer(),
            Text(
              prefixText,
             style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),
            ),
            // SizedBox(
            //   width: Responsive.width * 4,
            // ),
          ],
        ),
      ),
    );
  }
}
