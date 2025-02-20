import 'package:flutter/material.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';

class TeacherdutyTile extends StatelessWidget {
  
  final String? iconPath;
  final IconData icon;
  final String work;
  final String sub;
  final String status;
  
  final VoidCallback? onTap;
  final double bottomRadius;
  final double topRadius;

  const TeacherdutyTile(
      {super.key,
      
      this.iconPath,
      this.icon = Icons.invert_colors_on_sharp,
      required this.sub,
      required this.work,
      required this.status ,
     
      this.onTap,
      this.bottomRadius = 10,
      this.topRadius = 10});

    static getStatusColor(String? status) {
    switch (status) {
      case 'Pending':
        return Color(0xFFA86637);
      case 'Completed':
        return Color(0xFF44A837);
      case 'Not attended':
        return Color(0xFFA83737);
    

    }
  }


  static getStatusIcon(String? status) {
    switch (status) {
      case 'Pending':
        return Icons.access_time;
      case 'Completed':
        return Icons.done;
      case 'Not attended':
        return Icons.cancel;
    
    }
  }

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
                    color: getStatusColor(status).withOpacity(0.2),
                    // borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: iconPath != null
                      ? Image.asset(
                          iconPath ?? "",
                          color: getStatusColor(status),
                          height: 22,
                          width: 20,
                        )
                      : Icon(getStatusIcon(status), size: 22, color: getStatusColor(status)),
                )),

            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalizeFirstLetter(work),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
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
              status,
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: getStatusColor(status)),
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
