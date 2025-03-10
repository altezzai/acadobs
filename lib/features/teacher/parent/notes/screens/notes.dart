// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:school_app/base/routes/app_route_const.dart';
// import 'package:school_app/base/utils/responsive.dart';
// import 'package:school_app/core/shared_widgets/common_button.dart';

// import 'package:school_app/core/shared_widgets/custom_appbar.dart';
// import 'package:school_app/core/shared_widgets/custom_textfield.dart';

// // ignore: must_be_immutable
// class NotesScreen extends StatelessWidget {
//   NotesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             CustomAppbar(
//               title: "Notes",
//               isProfileIcon: false,
//               onTap: () {
//                 context.goNamed(
//                   AppRouteConst.parentRouteName,
//                 );
//               },
//             ),
//             CustomTextfield(
//               hintText: "Search for parents",
//               iconData: Icon(Icons.search),
//             ),
//             SizedBox(
//               height: Responsive.height * 1,
//             ),
//             // Row(
//             //   children: [
//             //     Expanded(
//             //       child: CustomDropdown(
//             //           icon: Icons.school,
//             //           label: "Select Class",
//             //           items: ["1", "2", "3", "4", "5"]),
//             //     ),
//             //     // SizedBox(width: Responsive.width * 6),
//             //     Expanded(
//             //       child: CustomDropdown(
//             //           icon: Icons.school,
//             //           label: "Select Period",
//             //           items: ["A", "B", "C", "D", "E"]),
//             //     ),
//             //   ],
//             // ),
//             SizedBox(
//               height: Responsive.height * 2,
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   // Teacher 1
//                   _buildParentTile(
//                     context,
//                     name: 'April Curtis',
//                     subject: 'Maths',
//                     imageUrl: 'assets/april.png',
//                     notificationCount: 2,
//                   ),
//                   // Teacher 2
//                   _buildParentTile(
//                     context,
//                     name: 'Dori Doreau',
//                     subject: 'Science',
//                     imageUrl: 'assets/dori.png',
//                     notificationCount: 1,
//                   ),
//                   // Teacher 3
//                   _buildParentTile(
//                     context,
//                     name: 'Angus MacGyver',
//                     subject: 'English',
//                     imageUrl: 'assets/angus.png',
//                     notificationCount: 0,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: Responsive.height * 1,
//             ),
//             CommonButton(
//               onPressed: () {
//                 context.goNamed(AppRouteConst.AddNoteRouteName);
//               },
//               widget: Text('Add New Note'),
//             ),
//             //            CustomButton(
//             //             onPressed: () {
//             //   context.goNamed(AppRouteConst.AddNoteRouteName);
//             // },
//             //             text: "Add New Note",
//             //           ),
//             SizedBox(
//               height: Responsive.height * 2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildParentTile(BuildContext context,
//       {required String name,
//       required String subject,
//       required String imageUrl,
//       int notificationCount = 0}) {
//     return ListTile(
//       contentPadding: EdgeInsets.symmetric(vertical: 8.0),
//       leading: CircleAvatar(
//         backgroundImage: AssetImage(imageUrl),
//         radius: 24,
//       ),
//       title: Text(
//         name,
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(subject),
//       trailing: notificationCount > 0
//           ? CircleAvatar(
//               radius: 12,
//               backgroundColor: Colors.red,
//               child: Text(
//                 '$notificationCount',
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             )
//           : null,
//       onTap: () {
//         context.pushNamed(
//           AppRouteConst.NoteDetailsRouteName,
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
//import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_floating_action_button.dart';
//import 'package:school_app/core/shared_widgets/common_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
//import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/teacher/parent/controller/notes_controller.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesController>().getNotesByTeacherId();
    });
    super.initState();
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
                title: "Notes",
                isProfileIcon: false,
                onTap: () {
                  context.pushNamed(AppRouteConst.bottomNavRouteName, extra: UserType.teacher);
                  // Navigator.pop(context);
                },
              ),
              Expanded(
                child: Consumer<NotesController>(
                  builder: (context, value, child) {
                    if (value.isloading) {
                      return const Center(
                        child: Loading(
                          color: Colors.grey,
                        ),
                      );
                    } else if (value.notesByTeacher.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/empty.png',
                              height: Responsive.height * 45,
                            ),
                          ],
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      padding: EdgeInsets.zero, // Removes any default padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets
                                .zero, // Removes any extra padding at the top
                            itemCount: value.notesByTeacher.length,
                            itemBuilder: (context, index) {
                              final note = value.notesByTeacher[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteConst.NoteDetailsRouteName,
                                      extra: note['id'],
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        // Add an icon or avatar for a visual element
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.black26,
                                          child: Icon(
                                            Icons.notes,
                                            color: Colors.black54,
                                            size: 24,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                note['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Note Id: ${note['id']}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.grey,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.grey.shade400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: Responsive.height * 12,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(
              //   height: Responsive.height * 4,
              // ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CommonFloatingActionButton(
            onPressed: () {
              context.pushNamed(AppRouteConst.AddNoteRouteName);
            },
            text: "Add New Note"));
  }

  Widget _buildParentTile(BuildContext context, {int notificationCount = 0}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDropdown(
                dropdownKey: 'class',
                label: 'Class',
                items: ['8', '9', '10'],
                icon: Icons.school,
                onChanged: (selectedClass) {
                  // Automatically fetch students when division is selected
                  final selectedDivision = context
                      .read<DropdownProvider>()
                      .getSelectedItem(
                          'division'); // Get the currently selected class
                  context.read<StudentController>().getParentByClassAndDivision(
                      classname: selectedClass, section: selectedDivision);
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CustomDropdown(
                dropdownKey: 'division',
                label: 'Division',
                items: ['A', 'B', 'C'],
                icon: Icons.group,
                onChanged: (selectedDivision) {
                  // Automatically fetch students when division is selected
                  final selectedClass = context
                      .read<DropdownProvider>()
                      .getSelectedItem(
                          'class'); // Get the currently selected class
                  context.read<StudentController>().getParentByClassAndDivision(
                      classname: selectedClass, section: selectedDivision);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
