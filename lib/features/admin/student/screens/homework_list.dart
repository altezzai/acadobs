import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/admin/student/widgets/date_group_function.dart';
import 'package:school_app/features/teacher/homework/widgets/work_container.dart';

class HomeworkList extends StatelessWidget {
  const HomeworkList({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          
          children: [
            SizedBox(height: Responsive.height * 4),
            Consumer<StudentController>(builder: (context, value, child) {
              if (value.isloading) {
                return const Center(
                    child: Loading(
                  color: Colors.grey,
                ));
              }
            
              final groupedHomework = groupItemsByDate(
                value.homeworks,
                (homework) => DateTime.parse(homework.assignedDate.toString()),
              );
            
              return value.homeworks.isEmpty ? Center(child: Text("No Homeworks Found!"),): _buildGroupedList(groupedHomework,
                        (homework, index, total){
               
                // itemCount: groupedHomework.length,
                
                  final entry = groupedHomework.entries.elementAt(index);
                  // final dateGroup = entry.key;
                  // final homeworks = entry.value;
              final isFirst = index == 0;
                      final isLast = index == total- 1;
                      final topRadius = isFirst ? 16.0 : 0.0;
                      final bottomRadius = isLast ? 16.0 : 0.0;
            
                  return 
                      
                       Padding(
                          padding: const EdgeInsets.only(
                  bottom: 1.5,
                ),
                         child: WorkContainer(
                         bottomRadius: bottomRadius.toDouble(),
                                            topRadius: topRadius.toDouble(),
                              sub: homework.subject ?? "",
                              work: homework.assignmentTitle ?? "",
                              iconPath: 'assets/icons/homework.png',
                              
                              onTap: () {
                                context.pushNamed(
                                  AppRouteConst.AdminhomeworkDetailRouteName,
                                  extra: homework,
                                );
                              },
                            ),
                       );
                       });
                      
                    
                  
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
