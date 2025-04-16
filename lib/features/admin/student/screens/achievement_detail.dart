import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/student/model/achievement_model.dart';
import 'package:school_app/features/teacher/homework/widgets/view_container.dart';

class AchievementDetail extends StatefulWidget {
  final Achievement achievement;
  AchievementDetail({required this.achievement});

  @override
  State<AchievementDetail> createState() => _AchievementDetailState();
}

class _AchievementDetailState extends State<AchievementDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(
              title: widget.achievement.category ?? "",
              isProfileIcon: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ViewContainer(
              bcolor: Colors.green.withValues(alpha: 51),
              icolor: Colors.green,
              icon: Icons.military_tech,
            ),
            SizedBox(
              height: Responsive.height * 3,
            ),
            Text(
              widget.achievement.achievementTitle ?? "",
              style: textThemeData.headlineLarge!.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            Text(
              widget.achievement.awardingBody ?? "",
              style: textThemeData.bodySmall!.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: Responsive.height * 3,
            )
          ],
        ),
      ),
    );
  }
}
