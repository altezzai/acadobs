import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_button.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';




class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
 

  

 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
        child:Column(
        children: [
          CustomAppbar(title: 'Subjects',isProfileIcon: false,onTap:(){ context.pushNamed(AppRouteConst.bottomNavRouteName,extra: UserType.admin);},),
          // Wrap ListView.builder in Expanded to constrain its height
          Expanded(

            child: _buildSubjects()
          ),
          Padding(
            padding:EdgeInsets.only(bottom: Responsive.height*4),
            child: CustomButton(text: 'Add Subjects', onPressed: (){
               context.pushNamed(AppRouteConst.AddSubjectPageRouteName);
            })
          ),
        ],
      ),
    ));
  }
  Widget _buildSubjects(){
   context.read<SubjectController>().getSubjects();
   return Consumer<SubjectController>
   (builder: (context, value, child) {
       if (value.isloading){
        return Center(
          child: CircularProgressIndicator(),
        );
       }
       return ListView.builder(
              itemCount: value.subjects.length,
              itemBuilder: (context, index) {
                final subject = value.subjects[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: Responsive.width *4, vertical:  Responsive.height *1),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.book_sharp, color: Colors.white),
                    ),
                    title: Text(subject.subject??"",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text(subject.description??""),
                    trailing: TextButton(
                      onPressed: () {
                        context.pushNamed(AppRouteConst.EditSubjectPageRouteName, extra: subject);
                      },
                      child: Text('Edit',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                );
              },
            );
   },);

  }
}
