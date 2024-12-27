import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/controller/dropdown_provider.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_dropdown.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';

class ParentsScreen extends StatefulWidget {
  @override
  _ParentsScreenState createState() => _ParentsScreenState();
}

class _ParentsScreenState extends State<ParentsScreen> {
  // String searchQuery = "";
  // String selectedClass = "All";

  late DropdownProvider dropdownprovider;

  @override
  void initState() {
    dropdownprovider = context.read<DropdownProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropdownprovider.clearSelectedItem('class');
      dropdownprovider.clearSelectedItem('division');

       context.read<StudentController>().resetFilter();

      context.read<StudentController>().clearParentList();
    });
    super.initState();

    context.read<StudentController>().getParentDetails();
  }

  // void _filterStudents(String query) {
  //   setState(() {
  //     searchQuery = query;
  //   });
  // }

  // void _filterByClass(String? newClass) {
  //   if (newClass != null) {
  //     setState(() {
  //       selectedClass = newClass;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomAppbar(
                    title: "         Parents",
                    isProfileIcon: false,
                    onTap: () {
                      context.pushNamed(AppRouteConst.bottomNavRouteName,
                          extra: UserType.teacher);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.draw_sharp),
                  onPressed: () {
                    context.pushNamed(AppRouteConst.NotesRouteName);
                  },
                  // Optional tooltip
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  // Expanded(
                  //   flex: 3,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: 'Search for Parents',
                  //       prefixIcon: Icon(Icons.search, color: Colors.grey),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //         borderSide: BorderSide(color: Colors.grey.shade300),
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.grey.shade100,
                  //       contentPadding: EdgeInsets.symmetric(vertical: 12),
                  //     ),
                  //     style: TextStyle(
                  //         fontSize: 16, fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                  // SizedBox(width: 8),
                  // Flexible(
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 12),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey.shade100,
                  //       borderRadius: BorderRadius.circular(30),
                  //       border: Border.all(color: Colors.grey.shade300),
                  //     ),
                  //     child: DropdownButton<String>(
                  //       value: selectedClass,
                  //       underline: SizedBox(),
                  //       isExpanded: true,
                  //       items: <String>[
                  //         'All',
                  //         'V',
                  //         'VI',
                  //         'VII',
                  //         'VIII',
                  //         'IX',
                  //         'X',
                  //       ].map((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(
                  //             value,
                  //             overflow: TextOverflow.ellipsis,
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (newValue) {
                  //         if (newValue != null) {
                  //           _filterByClass(newValue);
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
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
                      // final selectedDivision = context
                      //     .read<DropdownProvider>()
                      //     .getSelectedItem(
                      //         'division'); // Get the currently selected class
                      // context
                      //     .read<StudentController>()
                      //     .getParentByClassAndDivision(
                      //         classname: selectedClass,
                      //         section: selectedDivision);
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
                      context
                          .read<StudentController>()
                          .getParentByClassAndDivision(
                              classname: selectedClass,
                              section: selectedDivision);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Expanded(
              child: Consumer<StudentController>(
                builder: (context, value, child) {
                  if (value.isloading) {
                    return const Center(
                      child: Loading(
                        color: Colors.grey,
                      ),
                    );
                  }  else if (!value.isFiltered) {
                // Show image before filtering
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/empty.png',
                        height: Responsive.height * 45,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No filter applied. Please select a class and division.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }else  if (value.isFiltered&&value.filteredparents.isEmpty) {
                // Show message after filtering with no results
                return Center(
                  child: Text(
                    'No Parents Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }else{
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
                          itemCount: value.filteredparents.length,
                          itemBuilder: (context, index) {
                            final parent = value.filteredparents[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: ProfileTile(
                                imageUrl:
                                    "${baseUrl}${Urls.parentPhotos}${parent.fatherMotherPhoto}",
                                name: capitalizeFirstLetter(
                                    parent.guardianFullName ??
                                        parent.fatherFullName ??
                                        ""),
                                description:
                                    "${parent.fullName} ${parent.studentClass} ${parent.section}",
                                onPressed: () {
                                  // context.pushNamed(
                                  //     AppRouteConst.NoteDetailsRouteName,
                                  //     extra: parent);
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: Responsive.height * 7.5,
                        ),
                      ],
                    ),
                  );}
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: CommonButton(
      //       onPressed: () {
      //         context.pushNamed(AppRouteConst.AddNoteRouteName);
      //       },
      //       widget: Text("Add  Note")),
      // ),
    );
  }
}
