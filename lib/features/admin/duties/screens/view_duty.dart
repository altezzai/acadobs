import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/duties/model/duty_model.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class DutyView extends StatefulWidget {
  final DutyClass duties;

  const DutyView({
    super.key,
    required this.duties,
  });

  @override
  State<DutyView> createState() => _DutyViewState();
}

class _DutyViewState extends State<DutyView> {
  @override
  void initState() {
    context
        .read<DutyController>()
        .getAssignedDuties(dutyid: widget.duties.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 6),
        child: Column(
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomAppbar(
              title: widget.duties.dutyTitle ?? "",
              isProfileIcon: false,
            ),
            SizedBox(
              height: Responsive.height * .5,
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
              widget.duties.dutyTitle ?? "",
              style: textThemeData.headlineLarge!.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            Text(
              widget.duties.description ?? "",
              style: textThemeData.bodySmall!.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: Responsive.height * 3,
            ),
            Consumer<DutyController>(builder: (context, value, child) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.assignedteachers.length,
                  itemBuilder: (context, index) {
                    return Text(value.assignedteachers[index].fullName ?? "");
                  });
            })
          ],
        ),
      ),
    );
  }
}
