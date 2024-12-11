import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';
// import 'package:school_app/features/admin/student/model/student_data.dart';
import 'package:school_app/features/parent/chat/screen/parentchatscreen.dart';
import 'package:school_app/features/parent/events/screen/eventscreen.dart';
import 'package:school_app/features/parent/events/widget/eventcard.dart';
import 'package:school_app/features/parent/notices/screen/noticescreen.dart';
import 'package:school_app/features/parent/notices/widget/noticecard.dart';
import 'package:school_app/features/parent/payment/screen/PaymentScreen.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  @override
  void initState() {
    context.read<NoticeController>().getEvents();
    context.read<NoticeController>().getNotices();
    context.read<StudentController>().getIndividualStudentDetails();
    super.initState();
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    // const Text("Reports Page"),
    const EventsPage(),
    const NoticePage(),
    const PaymentPage(),
    ParentChatPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.article),
          //   label: 'Reports',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chat',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

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
                    "Hi, \nVincent",
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
                    context.goNamed(AppRouteConst.logoutRouteName,
                        extra: UserType.parent);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/child1.png'),
                    ),
                  ),
                ),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRouteConst.StudentLeaveRequestViewRouteName,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.25, //
                              vertical:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: const Text(
                          'Leave Request',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "My Children",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Consumer<StudentController>(
                    //     builder: (context, value, child) {
                    //   return ListView.builder(
                    //     padding: EdgeInsets.zero,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: value.students.take(2).length,
                    //     itemBuilder: (context, index) {
                    //       return ChildCard(
                    //         childName: value.students[index].fullName ?? "",
                    //         className: value.students[index].studentClass ?? "",
                    //         imageProvider: AssetImage('assets/child2.png'),
                    //       );
                    //     },
                    //   );
                    // }),
                    Consumer<StudentController>(
                        builder: (context, value, child) {
                      return value.isloading
                          ? Loading(
                              color: Colors.grey,
                            )
                          : ProfileTile(
                              name: capitalizeEachWord(
                                  value.individualStudent!.fullName ?? ""),
                              description:
                                  value.individualStudent!.studentClass ?? "",
                              imageUrl:
                                  "${baseUrl}${Urls.studentPhotos}${value.individualStudent!.studentPhoto}",
                              onPressed: () {
                                context.pushNamed(
                                    AppRouteConst.AdminstudentdetailsRouteName,
                                    extra: StudentDetailArguments(
                                        student: value.individualStudent!,
                                        userType: UserType.parent));
                              },
                            );
                    }),
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
                    const SizedBox(height: 20),
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
                          return NoticeCard(
                              description:
                                  value.notices[index].description ?? "",
                              noticeTitle: value.notices[index].title ?? "",
                              date: DateFormatter.formatDateString(
                                  value.notices[index].date.toString()),
                              time: TimeFormatter.formatTimeFromString(
                                  value.notices[index].createdAt.toString()),
                              fileUpload:
                                  value.notices[index].fileUpload ?? "");
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
                    const SizedBox(height: 20),
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
                          return EventCard(
                            eventDescription:
                                value.events[index].description ?? "",
                            eventTitle: value.events[index].title ?? "",
                            date: DateFormatter.formatDateString(
                                value.events[index].eventDate.toString()),
                            time: TimeFormatter.formatTimeFromString(
                                value.events[index].createdAt.toString()),
                            imageProvider: AssetImage("assets/event2.png"),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
