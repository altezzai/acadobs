import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
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

// import 'package:school_app/features/admin/student/model/student_data.dart';
// import 'package:school_app/features/parent/chat/screen/parentchatscreen.dart';
// import 'package:school_app/features/parent/events/screen/eventscreen.dart';
// import 'package:school_app/features/parent/events/widget/eventcard.dart';
// import 'package:school_app/features/parent/notices/screen/noticescreen.dart';
// import 'package:school_app/features/parent/notices/widget/noticecard.dart';
// import 'package:school_app/features/parent/payment/screen/payment_selection.dart';

// class ParentHomeScreen extends StatefulWidget {
//   const ParentHomeScreen({super.key});

//   @override
//   State<ParentHomeScreen> createState() => _ParentHomeScreenState();
// }

// class _ParentHomeScreenState extends State<ParentHomeScreen> {
//   @override
//   void initState() {
//     context.read<NoticeController>().getEvents();
//     context.read<NoticeController>().getNotices();
//     // context.read<StudentController>().getIndividualStudentDetails();
//     context.read<StudentController>().getStudentsByParentEmail();
//     super.initState();
//   }

//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const HomePage(),
//     // const Text("Reports Page"),
//     const EventsPage(),
//     const NoticePage(),
//     // const PaymentPage(),
//     const PaymentSelection(),
//     ParentChatPage()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.article),
//           //   label: 'Reports',
//           // ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.event),
//             label: 'Events',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notice',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.payment),
//             label: 'Payments',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'chat',
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _parentName;
  String? _profilePhoto;
  @override
  void initState() {
    context.read<NoticeController>().getEvents();
    context.read<NoticeController>().getNotices();
    // context.read<StudentController>().getIndividualStudentDetails();
    context.read<StudentController>().getStudentsByParentEmail();
    _fetchStudentData();
    super.initState();
  }

  Future<void> _fetchStudentData() async {
    final name = await SecureStorageService.getParentName();
    final photo = await SecureStorageService.getParentProfilePhoto();
    setState(() {
      _parentName = name ?? 'Parent'; // Fallback if name is null
      _profilePhoto =
          photo != null ? '$baseUrl${Urls.parentPhotos}$photo' : null;
    });
  }

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
                    "Hi, \n${_parentName}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Navigate to the desired page
                    context.pushNamed(AppRouteConst.logoutRouteName,
                        extra: UserType.parent);
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: _profilePhoto ?? "",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            "assets/icons/avatar.png",
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                            // Center(
                            //   child: Consumer<StudentController>(
                            //       builder: (context, value, child) {
                            //     return ElevatedButton(
                            //       onPressed: () {
                            //         context.pushNamed(
                            //             AppRouteConst.StudentLeaveRequestViewRouteName,
                            //             extra: value.studentIds);
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //           backgroundColor: Colors.black,
                            //           padding: EdgeInsets.symmetric(
                            //             horizontal:
                            //                 MediaQuery.of(context).size.width * 0.25, //
                            //             vertical:
                            //                 MediaQuery.of(context).size.height * 0.025,
                            //           ),
                            //           shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(12))),
                            //       child: const Text(
                            //         'Leave Request',
                            //         style: TextStyle(fontSize: 18, color: Colors.white),
                            //       ),
                            //     );
                            //   }),
                            // ),
                            // const SizedBox(height: Responsive.height*2),

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
                                                student: student,
                                                userType: UserType.parent));
                                      },
                                    ),
                                  );
                                },
                              );
                            }),
                            // Consumer<StudentController>(
                            //     builder: (context, value, child) {
                            //   return value.isloading
                            //       ? Loading(
                            //           color: Colors.grey,
                            //         )
                            //       : ProfileTile(
                            //           name: capitalizeEachWord(
                            //               value.individualStudent!.fullName ?? ""),
                            //           description:
                            //               value.individualStudent!.studentClass ?? "",
                            //           imageUrl:
                            //               "${baseUrl}${Urls.studentPhotos}${value.individualStudent!.studentPhoto}",
                            //           onPressed: () {
                            //             context.pushNamed(
                            //                 AppRouteConst.AdminstudentdetailsRouteName,
                            //                 extra: StudentDetailArguments(
                            //                     student: value.individualStudent!,
                            //                     userType: UserType.parent));
                            //           },
                            //         );
                            // }),
                            // const ChildCard(
                            //   childName: "Muhammed Rafsal N",
                            //   className: "XIII",
                            //   imageProvider: AssetImage('assets/child1.png'),
                            // ),
                            // const ChildCard(
                            //   childName: "Livia Kenter",
                            //   className: "XIII",
                            //   imageProvider: AssetImage('assets/child2.png'),
                            // ),
                           SizedBox(height: Responsive.height*2),
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
                                    );
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
        final isLast = index == value.notices.take(2).length - 1;
        final topRadius = isFirst ? 16 : 0;
        final bottomRadius = isLast ? 16 : 0;
                          final notice = value.notices[index];
                           return Padding(
          padding: const EdgeInsets.only(bottom: 1.5),child: DutyCard(
             bottomRadius: bottomRadius.toDouble(),
             topRadius: topRadius.toDouble(),
            title: notice.title ?? "",
            date: DateFormatter.formatDateString(notice.date.toString()),
            time:
                TimeFormatter.formatTimeFromString(notice.createdAt.toString()),
            onTap: () {
              context.pushNamed(
                AppRouteConst.NoticeDetailedPageRouteName,
                extra: NoticeDetailArguments(
                    notice: notice, userType: UserType.parent),
              );
            },
            description: notice.description ?? "",
            fileUpload: notice.fileUpload ?? "",
          ));
                                  // return NoticeCard(
                                  //   description:
                                  //       value.notices[index].description ?? "",
                                  //   noticeTitle:
                                  //       value.notices[index].title ?? "",
                                  //   date: DateFormatter.formatDateString(
                                  //       value.notices[index].date.toString()),
                                  //   time: TimeFormatter.formatTimeFromString(
                                  //       value.notices[index].createdAt
                                  //           .toString()),
                                  //   fileUpload:
                                  //       value.notices[index].fileUpload ?? "",
                                  //   onTap: () {
                                  //     context.pushNamed(
                                  //         AppRouteConst
                                  //             .NoticeDetailedPageRouteName,
                                  //         extra: NoticeDetailArguments(
                                  //           notice: value.notices[index],
                                  //           userType: UserType.parent,
                                  //         ));
                                  //   },
                                  // );
                                },
                              );
                            }),
                            // const NoticeCard(
                            //   noticeTitle: "PTA meeting class 09",
                            //   date: "15 - 06 - 24",
                            //   description: "",
                            //   time: "09:00 am",
                            // ),
                            // const NoticeCard(
                            //   noticeTitle: "PTA meeting class 02",
                            //   date: "15 - 06 - 24",
                            //   time: "09:00 am",
                            // ),
                           SizedBox(height: Responsive.height*2),
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
                                    );
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
                            // const event_card.EventCard(
                            //   eventTitle: "Sports day",
                            //   eventDescription:
                            //       "National sports day will be conducted\n in our school...",
                            //   date: "15 - 06 - 24",
                            //   imageProvider: AssetImage("assets/event.png"),
                            //   time: '',
                            // ),
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
