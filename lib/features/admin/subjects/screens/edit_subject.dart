import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';


class EditSubjectPage extends StatefulWidget {
  const EditSubjectPage({super.key});

  @override
  State<EditSubjectPage> createState() => _EditSubjectPageState();
}

class _EditSubjectPageState extends State<EditSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(padding: EdgeInsets.symmetric(horizontal:  Responsive.width * 4),
        child: Column(
          children: [
            CustomAppbar(title: 'Edit Subject',
             isProfileIcon: false,
             onTap:(){ context.pushNamed(AppRouteConst.SubjectsPageRouteName);
             },
             ),
             SizedBox(height: Responsive.height * 2,),
             Expanded(
               child: CustomTextfield(iconData: Icon(Icons.title),
               hintText: 'Maths',),
             ),
            
                // child: Align(
                //   alignment: Alignment.bottomCenter,
                  // child: Padding(
                  //   padding: EdgeInsets.only(bottom: Responsive.height * 3),
                     Padding(padding:EdgeInsets.only(bottom: Responsive.height*4),
                     child:CustomButton(
                      text: 'Update',
                      onPressed: () {
                        // Add your update functionality here
                      },
                    ),)
                  

             
          ],
        )

        ),
      
    );
  }
}