import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_floating_action_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';

class TeachersPage extends StatefulWidget {
  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  @override
  void initState() {
    super.initState();
    
    context.read<TeacherController>().getTeacherDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomAppbar(
              title: 'Teachers',
              isProfileIcon: false,
              onTap: () {
                context.pushNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin,
                );
              },
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            Expanded(
              child:
                  Consumer<TeacherController>(builder: (context, value, child) {
                if (value.isloading) {
                  return Center(
                    child: Loading(
                      color: Colors.grey,
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Responsive.height * 1,
                      ),
                      ListView.builder(
                        itemCount: value.teachers.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ProfileTile(
                              imageUrl:
                                  "${baseUrl}${Urls.teacherPhotos}${value.teachers[index].profilePhoto}",
                              name: capitalizeFirstLetter(
                                  value.teachers[index].fullName ?? ""),
                              description:
                                  value.teachers[index].classGradeHandling ??
                                      "",
                              onPressed: () {
                                context.pushNamed(
                                    AppRouteConst.AdminteacherdetailsRouteName,
                                    extra: value.teachers[index]);
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: Responsive.height * 11,
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: CommonFloatingActionButton(
              onPressed: () {
                context.pushNamed(AppRouteConst.AddTeacherRouteName);
              },
              text:
                'Add New Teacher',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
