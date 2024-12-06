import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/core/shared_widgets/custom_textfield.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({super.key});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal:Responsive.width * 4,), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(title: 'Add Subject', isProfileIcon: false, onTap: () {
                context.pushNamed(AppRouteConst.SubjectsPageRouteName);
              },),
              SizedBox(height: Responsive.height * 2,),
            Expanded(
              child: CustomTextfield(iconData: Icon(Icons.title),
              hintText: 'Subject Name',),
            ),
            Padding(padding:EdgeInsets.only(bottom: Responsive.height*4),
            child: CustomButton(text: 'Add', onPressed: (){

            }),)
          ],
        ),) 
      ,
    );
  }
}