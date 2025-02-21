// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:school_app/base/utils/capitalize_first_letter.dart';
// import 'package:school_app/base/utils/custom_popup_menu.dart';
// import 'package:school_app/base/utils/responsive.dart';
// import 'package:school_app/base/utils/show_confirmation_dialog.dart';
// import 'package:school_app/base/utils/urls.dart';
// import 'package:school_app/core/shared_widgets/profile_container.dart';
// import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
// import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
// import 'package:school_app/features/admin/teacher_section/widgets/tab_section.dart';

// class TeacherDetailsPage extends StatelessWidget {
//   // final String name;
//   // final String studentClass;
//   // final String image;
//   final Teacher teacher;

//   TeacherDetailsPage({
//     // required this.name,
//     // required this.studentClass,
//     // required this.image,
//     required this.teacher,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SliverToBoxAdapter(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: Responsive.height * 4,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const CircleAvatar(
//                       radius: 16,
//                       backgroundColor: Color(0xFFD9D9D9),
//                       child: Icon(
//                         Icons.arrow_back_ios_new,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     textAlign: TextAlign.center,
//                     "Teacher",
//                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 22,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                   ),
//                   Consumer<TeacherController>(builder: (context, value, child) {
//                     return CustomPopupMenu(
//                         onEdit: () {},
//                         onDelete: () {
//                           showConfirmationDialog(
//                               context: context,
//                               title: "Delete Teacher?",
//                               content:
//                                   "Are you sure you want to delete this teacher?",
//                               onConfirm: () {
//                                 value.deleteTeacher(context,
//                                     teacherId: teacher.id ?? 0);
//                               });
//                         });
//                   })
//                 ],
//               ),
//               SizedBox(
//                 height: Responsive.height * 1,
//               ),
//               ProfileContainer(
//                 imagePath:
//                     "${baseUrl}${Urls.teacherPhotos}${teacher.profilePhoto}",
//                 name: capitalizeFirstLetter(teacher.fullName ?? ""),
//                 present: '27',
//                 absent: '7',
//                 late: '3',
//                 description: teacher.classGradeHandling,
//               ),
//               SizedBox(
//                 height: Responsive.height * 2,
//               ),
//               Expanded(
//                 child: TabSection(
//                   teacherId: teacher.id ?? 0,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/profile_container.dart';
import 'package:school_app/features/admin/teacher_section/controller/teacher_controller.dart';
import 'package:school_app/features/admin/teacher_section/model/teacher_model.dart';
import 'package:school_app/features/admin/teacher_section/widgets/activity_tab.dart';
import 'package:school_app/features/admin/teacher_section/widgets/dashboard_tab.dart';
import 'package:school_app/features/admin/teacher_section/widgets/duties_tab.dart';

class TeacherDetailsPage extends StatelessWidget {
  final Teacher teacher;

  TeacherDetailsPage({
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Adjust the number of tabs as needed
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: Responsive.height * 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFFD9D9D9),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                              ),
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Teacher",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          ),
                          Consumer<TeacherController>(
                            builder: (context, value, child) {
                              return CustomPopupMenu(
                                onEdit: () {},
                                onDelete: () {
                                  showConfirmationDialog(
                                    context: context,
                                    title: "Delete Teacher?",
                                    content:
                                        "Are you sure you want to delete this teacher?",
                                    onConfirm: () {
                                      value.deleteTeacher(
                                        context,
                                        teacherId: teacher.id ?? 0,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.height * 3),
                      ProfileContainer(
                        imagePath:
                            "${baseUrl}${Urls.teacherPhotos}${teacher.profilePhoto}",
                        name: capitalizeFirstLetter(teacher.fullName ?? ""),
                        present: '27',
                        absent: '7',
                        late: '3',
                        description: teacher.classGradeHandling,
                      ),
                    ],
                  ),
                ),
              ),
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.grey.shade200,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(text: "Dashboard"),
                          Tab(text: "Activity"),
                          Tab(text: "Duty"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
            child: TabBarView(
              children: [
                DashboardTab(),
                ActivityTab(
                  teacherId: teacher.id ?? 0,
                ),
                DutiesTab(
                  teacherId: teacher.id ?? 0,
                ),
                // Builder(
                //   builder: (BuildContext context) {
                //     return CustomScrollView(
                //       slivers: <Widget>[
                //         SliverOverlapInjector(
                //           handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                //               context),
                //         ),
                //         SliverToBoxAdapter(
                //           child: TabSection(teacherId: teacher.id ?? 0),
                //         ),
                //       ],
                //     );
                //   },
                // ),
                // Add other tab contents here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
