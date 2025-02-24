import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/common_floating_action_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/teacher/homework/controller/homework_controller.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class WorkScreen extends StatefulWidget {
  WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  @override
  void initState() {
    context.read<HomeworkController>().getHomeworkByTeacherId();
    super.initState();
  }

  /// Group homework items by date.
  Map<String, List<T>> groupItemsByDate<T>(
    List<T> items,
    DateTime Function(T) getDate, // Function to extract the date from the item
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    Map<String, List<T>> groupedItems = {};

    for (var item in items) {
      final itemDate = getDate(item);
      String formattedDate;
      if (itemDate.isAtSameMomentAs(today)) {
        formattedDate = "Today";
      } else if (itemDate.isAtSameMomentAs(yesterday)) {
        formattedDate = "Yesterday";
      } else {
        formattedDate = DateFormat.yMMMMd().format(itemDate);
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
      }
      groupedItems[formattedDate]!.add(item);
    }

    // Sort grouped dates with "Today" and "Yesterday" on top.
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey('Today')) {
      sortedEntries.add(MapEntry('Today', groupedItems['Today']!));
      groupedItems.remove('Today');
    }
    if (groupedItems.containsKey('Yesterday')) {
      sortedEntries.add(MapEntry('Yesterday', groupedItems['Yesterday']!));
      groupedItems.remove('Yesterday');
    }

    sortedEntries.addAll(
        groupedItems.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));

    return Map.fromEntries(sortedEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Responsive.height * 2,
                ),
                CustomAppbar(
                  title: 'Home Works',
                  isProfileIcon: false,
                  onTap: () {
                    context.pushNamed(
                      AppRouteConst.bottomNavRouteName,
                      extra: UserType.teacher,
                    );
                  },
                ),
                Consumer<HomeworkController>(builder: (context, value, child) {
                  if (value.isloading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: Responsive.height * 38,
                        ),
                        Loading(
                          color: Colors.grey,
                        ),
                      ],
                    );
                  }

                  // Group homework by date
                  final groupedHomework = groupItemsByDate(
                    value.teacherHomework,
                    (homework) =>
                        DateTime.tryParse(homework.assignedDate.toString()) ??
                        DateTime.now(),
                  );

                  return value.teacherHomework.isEmpty
                      ? Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Responsive.height * 37,
                              ),
                              Text("No Homeworks Found!"),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: groupedHomework.entries.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text(
                                    entry.key,
                                    style: textThemeData.bodyMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.height * 1,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: entry.value.length,
                                  itemBuilder: (context, index) {
                                    final homework = entry.value[index];
                                    return WorkContainer(
                                      icon: Icons.home_work_outlined,
                                      work: homework.assignmentTitle ??
                                          "Untitled",
                                      sub: homework.subject ?? "No Subject",
                                      onTap: () {
                                        context.pushNamed(
                                          AppRouteConst.workviewRouteName,
                                          extra: homework,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        );
                }),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CommonFloatingActionButton(
            onPressed: () {
              context.pushNamed(AppRouteConst.addworkRouteName);
            },
            text: "Add Homework"));
  }
}
