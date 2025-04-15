import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
import 'package:school_app/features/parent/events/widget/eventcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String? _parentName;
  // String? _profilePhoto;
  late NoticeController noticeController;
  late StudentController studentController;
  @override
  void initState() {
    noticeController = context.read<NoticeController>();
    studentController = context.read<StudentController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      noticeController.getEvents();
      noticeController.getNotices();
      // context.read<StudentController>().getIndividualStudentDetails();
      context.read<StudentController>().getStudentsByParentEmail();
      // _fetchStudentData();
    });
    super.initState();
  }

  // Future<void> _fetchStudentData() async {
  //   final name = await SecureStorageService.getParentName();
  //   final photo = await SecureStorageService.getParentProfilePhoto();
  //   setState(() {
  //     _parentName = name ?? 'Parent'; // Fallback if name is null
  //     _profilePhoto =
  //         photo != null ? '$baseUrl${Urls.parentPhotos}$photo' : null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Hi, \nParent",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        // context.pushNamed(AppRouteConst.logoutRouteName,
                        //     extra: UserType.parent);
                        context.pushNamed(AppRouteConst.profileRouteName);
                      },
                      child: Icon(
                        Icons.settings,
                        color: Color(0xFFEDEDED),
                      )),
                ),
                SizedBox(
                  width: Responsive.width * 2,
                )
              ],
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/school.png', // Placeholder for the school image
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.green.withOpacity(1)],
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.business_outlined,
                        color: Colors.white,
                      ),
                      Center(
                        child: Text(
                          "   Shamsul Huda\n Islamic Academy",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Consumer<StudentController>(builder: (context, value, child) {
                return value.isloading
                    ? Column(
                        children: [
                          SizedBox(
                            height: Responsive.height * 22,
                          ),
                          Loading(
                            color: Colors.grey,
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Responsive.height * 1),
                            const Text(
                              "My Children",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Consumer<StudentController>(
                                builder: (context, value, child) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.studentsByParents.length,
                                itemBuilder: (context, index) {
                                  final student =
                                      value.studentsByParents[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ProfileTile(
                                      name: capitalizeEachWord(
                                          student.fullName ?? ""),
                                      description: student.studentClass ?? "",
                                      imageUrl:
                                          "${baseUrl}${Urls.studentPhotos}${student.studentPhoto}",
                                      onPressed: () {
                                        context.pushNamed(
                                            AppRouteConst
                                                .AdminstudentdetailsRouteName,
                                            extra: StudentDetailArguments(
                                                studentId: student.id ?? 0,
                                                userType: UserType.parent));
                                      },
                                    ),
                                  );
                                },
                              );
                            }),
                            SizedBox(height: Responsive.height * 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Notices",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pushNamed(
                                        AppRouteConst.ParentNoticePageRouteName,
                                        extra: true);
                                  },
                                  child: const Text(
                                    "View",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Consumer<NoticeController>(
                                builder: (context, value, child) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.notices.take(2).length,
                                itemBuilder: (context, index) {
                                  final isFirst = index == 0;
                                  final isLast =
                                      index == value.notices.take(2).length - 1;
                                  final topRadius = isFirst ? 16 : 0;
                                  final bottomRadius = isLast ? 16 : 0;
                                  final notice = value.notices[index];
                                  return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 1.5),
                                      child: DutyCard(
                                        bottomRadius: bottomRadius.toDouble(),
                                        topRadius: topRadius.toDouble(),
                                        title: notice.title ?? "",
                                        date: DateFormatter.formatDateString(
                                            notice.date.toString()),
                                        time:
                                            TimeFormatter.formatTimeFromString(
                                                notice.createdAt.toString()),
                                        onTap: () {
                                          context.pushNamed(
                                            AppRouteConst
                                                .NoticeDetailedPageRouteName,
                                            extra: NoticeDetailArguments(
                                                notice: notice,
                                                userType: UserType.parent),
                                          );
                                        },
                                        description: notice.description ?? "",
                                        // fileUpload: notice.fileUpload ?? "",
                                      ));
                                },
                              );
                            }),
                            SizedBox(height: Responsive.height * 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Events",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pushNamed(
                                        AppRouteConst.EventsPageRouteName,
                                        extra: true);
                                  },
                                  child: const Text(
                                    "View",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Consumer<NoticeController>(
                                builder: (context, value, child) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.events.take(2).length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: EventCard(
                                      onTap: () {
                                        context.pushNamed(
                                            AppRouteConst
                                                .EventDetailedPageRouteName,
                                            extra: EventDetailArguments(
                                              event: value.events[index],
                                              userType: UserType.parent,
                                            ));
                                      },
                                      bottomRadius: 16,
                                      topRadius: 16,
                                      eventDescription:
                                          value.events[index].description ?? "",
                                      eventTitle:
                                          value.events[index].title ?? "",
                                      date: DateFormatter.formatDateString(value
                                          .events[index].eventDate
                                          .toString()),
                                      time: TimeFormatter.formatTimeFromString(
                                          value.events[index].createdAt
                                              .toString()),
                                      imageProvider:
                                          "${baseUrl}${Urls.eventPhotos}${value.events[index].images![0].imagePath}",
                                    ),
                                  );
                                },
                              );
                            }),
                          ],
                        ),
                      );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
