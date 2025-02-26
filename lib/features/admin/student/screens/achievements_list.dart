import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/features/admin/student/controller/achievement_controller.dart';
import 'package:school_app/features/admin/student/widgets/date_group_function.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class AchievementsList extends StatelessWidget {
  final UserType userType;
  final VoidCallback onPressed;
  const AchievementsList(
      {super.key, required this.userType, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: userType == UserType.parent
          ? SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, right: 16), // Improved padding
              child: SizedBox(
                width: 65, // Increased size
                height: 65,
                child: FloatingActionButton(
                  onPressed: onPressed,
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ),
            ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.height * 5),
            Consumer<AchievementController>(
              builder: (context, value, child) {
                if (value.isloading) {
                  return const Center(
                      child: Loading(
                    color: Colors.grey,
                  ));
                }

                final groupedAchievements = groupItemsByDate(
                  value.achievements,
                  (achievement) =>
                      DateTime.parse(achievement.dateOfAchievement.toString()),
                );

                return value.achievements.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            "No Achievements Found!",
                            style: TextStyle(),
                          ),
                        ),
                      )
                    : _buildGroupedList(
                        groupedAchievements,
                        (achievement, index, total) {
                          // final entry = groupedAchievements.entries.elementAt(index);
                          // final entry = groupedAchievements.entries.elementAt(index);
                          // final dateGroup = entry.key;
                          // final achievements = entry.value;

                          final isFirst = index == 0;
                          final isLast = index == total - 1;
                          final topRadius = isFirst ? 16.0 : 0.0;
                          final bottomRadius = isLast ? 16.0 : 0.0;

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 1.5,
                            ),
                            child: WorkContainer(
                              bottomRadius: bottomRadius.toDouble(),
                              topRadius: topRadius.toDouble(),
                              sub: achievement.category ?? "",
                              work: achievement.achievementTitle ?? "",
                              iconPath: 'assets/icons/achievement.png',
                              icolor: Colors.green,
                              bcolor: Colors.green.withOpacity(0.2),
                              onTap: () {
                                context.pushNamed(
                                  AppRouteConst.AchivementDetailRouteName,
                                  extra: achievement,
                                );
                              },
                            ),
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupedList<T>(Map<String, List<T>> groupedItems,
      Widget Function(T, int, int) buildItem) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedItems.entries.map((entry) {
          final itemCount = entry.value.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(entry.key),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return buildItem(entry.value[index], index, itemCount);
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.only(
        top: Responsive.height * 2, // 20px equivalent
        bottom: Responsive.height * 1.5, // 10px equivalent
        // left: Responsive.width * 4
      ),
      child: Text(
        date,
        style: textThemeData.bodyMedium?.copyWith(
          fontSize: 16, // Responsive font size
        ),
      ),
    );
  }
}
