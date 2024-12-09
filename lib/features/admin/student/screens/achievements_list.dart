import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/widgets/date_group_function.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class AchievementsList extends StatelessWidget {
  const AchievementsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRouteConst.AddAchivementsRouteName);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<AchievementController>(
        builder: (context, value, child) {
          if (value.isloading) {
            return const Center(child: CircularProgressIndicator());
          }

          final groupedAchievements = groupItemsByDate(
            value.achievements,
            (achievement) =>
                DateTime.parse(achievement.dateOfAchievement.toString()),
          );

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            itemCount: groupedAchievements.length,
            itemBuilder: (context, index) {
              final entry = groupedAchievements.entries.elementAt(index);
              final dateGroup = entry.key;
              final achievements = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Responsive.height * 4),
                  Text(
                    dateGroup,
                    style: textThemeData.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  ...achievements.map((achievement) => WorkContainer(
                        sub: achievement.awardingBody ?? "",
                        work: achievement.category ?? "",
                        icon: Icons.military_tech,
                        icolor: Colors.green,
                        bcolor: Colors.green.withOpacity(0.2),
                        onTap: () {
                          context.pushNamed(
                            AppRouteConst.AchivementDetailRouteName,
                            extra: achievement,
                          );
                        },
                      )),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
