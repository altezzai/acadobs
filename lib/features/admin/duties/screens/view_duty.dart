import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/custom_popup_menu.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_confirmation_dialog.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class DutyView extends StatefulWidget {
  final DutyClass duty;
  final UserType userType;

  const DutyView({
    super.key,
    required this.duty,
    required this.userType,
  });

  @override
  State<DutyView> createState() => _DutyViewState();
}

class _DutyViewState extends State<DutyView> {
  @override
  void initState() {
    context
        .read<DutyController>()
        .getAssignedDuties(dutyid: widget.duty.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: capitalizeEachWord(widget.duty.dutyTitle ?? ""),
        isBackButton: true,
        actions: [
          // CustomPopupMenu(onEdit: () {}, onDelete: () {})
          if (widget.userType == UserType.admin) // Show for admin only
            Consumer<DutyController>(
              builder: (context, dutyController, child) {
                return CustomPopupMenu(
                    onEdit: () {},
                    onDelete: () {
                      showConfirmationDialog(
                          context: context,
                          title: "Delete Duty?",
                          content: "Are you sure you want to delete this duty?",
                          onConfirm: () {
                            dutyController.deleteDuties(context,
                                dutyId: widget.duty.id!);
                          });
                    });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height * .09,
              ),
              const ViewContainer(
                bcolor: Color(0xffCEFFD3),
                icolor: Color(0xff5DD168),
                icon: Icons.workspace_premium,
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                widget.duty.dutyTitle ?? "",
                style: textThemeData.headlineLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: Responsive.height * 1,
              ),
              Text(
                widget.duty.description ?? "",
                style: textThemeData.bodySmall!.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: Responsive.height * 3,
              ),
              Text(
                'Teachers Assigned: ',
                style: textThemeData.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: Responsive.height * 2,
              ),
              Consumer<DutyController>(builder: (context, value, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: value.assignedteachers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: ProfileTile(
                          name: value.assignedteachers[index].fullName ?? "",
                          description: value
                                  .assignedteachers[index].classGradeHandling ??
                              "",
                          imageUrl:
                              "${baseUrl}${Urls.teacherPhotos}${value.assignedteachers[index].profilePhoto}",
                          suffixText:
                              value.assignedteachers[index].dutyStatus ?? "",

                          // margin: const EdgeInsets.symmetric(
                          //     horizontal: 1, vertical: 5),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(15)),
                          // child: ListTile(
                          //   leading: CircleAvatar(
                          //     // backgroundImage: value
                          //     //             .assignedteachers[index].profilePhoto !=
                          //     //         null
                          //     //     ? NetworkImage(
                          //     //         value.assignedteachers[index].profilePhoto!)
                          //     //     : AssetImage('assets/student5.png')
                          //     //         as ImageProvider,
                          //     backgroundImage: NetworkImage("${baseUrl}${Urls.teacherPhotos}${value.assignedteachers[index].profilePhoto}"
                          //    ),
                          //   ),
                          //   title: Text(
                          //       value.assignedteachers[index].fullName ?? "",
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.normal, fontSize: 16)),
                          //   subtitle: Text(
                          //       value.assignedteachers[index]
                          //               .administrativeRoles ??
                          //           "",
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.normal, fontSize: 15)),
                          //    trailing: Text(value.assignedteachers[index].dutyStatus?? "")
                          // ),
                        ),
                      );
                    });
              }),
              SizedBox(
                height: Responsive.height * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
