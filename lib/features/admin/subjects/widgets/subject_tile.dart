import 'package:flutter/material.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';

class SubjectTile extends StatelessWidget {
  final String subjectName;
  final String description;
  final String iconPath;
  final Color iconColor;
  final VoidCallback onEdit;
  final double topRadius;
  final double bottomRadius;

  const SubjectTile({
    Key? key,
    required this.subjectName,
    required this.description,
    required this.iconPath,
    required this.iconColor,
    required this.onEdit,
    this.topRadius=10,
    this.bottomRadius=10,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return 
      
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomRadius),
              bottomRight: Radius.circular(bottomRadius),
              topLeft: Radius.circular(topRadius),
              topRight: Radius.circular(topRadius)),
        ),
        child: Row(
          children: [
            Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    // borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    iconPath,
                    height: 22,
                    width: 20,
                  ),
                )),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   capitalizeFirstLetter(subjectName),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                
                         Text(
                          capitalizeFirstLetter(description),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                     
                     
                    ],
                  ),),
                   const Spacer(),
          TextButton(
          onPressed: onEdit,
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.black),
          ),
        ),
                ],
                 
              ),
            );
          
    
      
    
  }}
//   Widget build(BuildContext context) {
//     return Card(
//      padding: EdgeInsets.all(12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(topRadius ),
//           topRight: Radius.circular(topRadius ),
//           bottomLeft: Radius.circular(bottomRadius ),
//           bottomRight: Radius.circular(bottomRadius ),
//         ),
//         side: BorderSide(
//           color: Colors.grey.shade300,
//           width: 1.0,
//         ),
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: iconColor.withOpacity(0.2),
//           child: Image.asset(iconPath, width: 24, height: 24),
//         ),
//         title: Text(capitalizeFirstLetter(
//           subjectName,),
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         subtitle: Text(capitalizeFirstLetter(
//           description),
//           style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//         ),
//         trailing: TextButton(
//           onPressed: onEdit,
//           child: Text(
//             'Edit',
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//       ),
//     );
//   }
// }
