import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_floating_action_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/subjects/controller/subject_controller.dart';
import 'package:school_app/features/admin/subjects/widgets/subject_tile.dart';

class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Orientation orientation = MediaQuery.of(context).orientation;
      Responsive().init(constraints, orientation);

      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        SizedBox(height: Responsive.height * 2),
                        CustomAppbar(
                          title: 'Subjects',
                          isProfileIcon: false,
                          onTap: () {
                            context.pushNamed(AppRouteConst.bottomNavRouteName,
                                extra: UserType.admin);
                          },
                        ),
                        SizedBox(height: Responsive.height * 2)
                      ]))),
            ];
          },
          // Wrap ListView.builder in Expanded to constrain its height
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width * 4),
            child: Column(children: [
              Expanded(
                // Wrap with Expanded to avoid constraint issues
                child: _buildSubjects(),
              ),
            ]),
          ),
        ),
        floatingActionButton: CommonFloatingActionButton(
          onPressed: () {
            context.pushNamed(AppRouteConst.AddSubjectPageRouteName);
          },
          text: 'Add Subjects',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget _buildSubjects() {
    context.read<SubjectController>().getSubjects();
    return Consumer<SubjectController>(
      builder: (context, value, child) {
        if (value.isloading) {
          return Loading(
            color: Colors.grey,
          );
        }
        List<Color> subjectColors = [
          Colors.green,
          Colors.blue,
          Colors.red,
          Colors.orange,
          Colors.purple,
          Colors.teal,
          Colors.pink,
        ];
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: value.subjects.length,
          itemBuilder: (context, index) {
            final isFirst = index == 0;
            final isLast = index == value.subjects.length - 1;

            final topRadius = isFirst ? 16 : 0;
            final bottomRadius = isLast ? 16 : 0;
            final subject = value.subjects[index];
            final color = subjectColors[
                index % subjectColors.length]; // Assign color dynamically
            return Padding(
              padding: EdgeInsets.only(
                bottom: 1.5,
              ),
              child: SubjectTile(
                bottomRadius: bottomRadius.toDouble(),
                topRadius: topRadius.toDouble(),
                subjectName: subject.subject ?? "",
                description: subject.description ?? "",
                iconPath: ('assets/icons/subject_tile_icon.png'),
                iconColor: color,
                onEdit: () {
                  context.pushNamed(AppRouteConst.EditSubjectPageRouteName,
                      extra: subject);
                },
                // onDelete: () {
                // value.deleteSubjects(context, subjectid: subject.id);
                // }
              ),
            );
          },
        );
      },
    );
  }
}
