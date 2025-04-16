import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_container.dart';
import 'package:school_app/core/shared_widgets/custom_name_container.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/parent/events/widget/eventcard.dart';
import 'package:school_app/features/teacher/attendance/widgets/attendance_bottomsheet.dart';

class TeacherScreen extends StatefulWidget {
  TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  String? _teacherName;
  // String? _profilePhoto;
  OverlayEntry? _popupEntry; // Store the overlay entry

  void _togglePopup(BuildContext context) {
    if (_popupEntry == null) {
      _popupEntry = _createPopupEntry(context);
      Overlay.of(context).insert(_popupEntry!);
    } else {
      _popupEntry?.remove();
      _popupEntry = null;
    }
  }

  OverlayEntry _createPopupEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Blurred Background
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _togglePopup(context);
                },
                behavior: HitTestBehavior.opaque,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    // Dim the background
                  ),
                ),
              ),
            ),
            // Positioned Popup Above FAB
            Positioned(
              right: 16, // Align with FAB
              bottom: Responsive.height * 20, // Adjust to appear above FAB
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _customContainer(
                        text: 'Leave Requests',
                        iconPath: 'assets/icons/leave_request.png',
                        iconSize: 26,
                        ontap: () {
                          _togglePopup(
                              context); // Close the overlay before navigating
                          context.pushNamed(
                              AppRouteConst.TeacherLeaveRequestScreenRouteName);
                        }),
                    SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  late NoticeController noticeController;

  @override
  void initState() {
    noticeController = context.read<NoticeController>();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      noticeController.getNotices();
      noticeController.getEvents();
    });
    _fetchTeacherData();
  }

  Future<void> _fetchTeacherData() async {
    final name = await SecureStorageService.getTeacherName();
    // final photo = await SecureStorageService.getTeacherProfilePhoto();
    setState(() {
      _teacherName = name ?? 'Teacher'; // Fallback if name is null
      // _profilePhoto =
      //     photo != null ? '$baseUrl${Urls.teacherPhotos}$photo' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Responsive.height * 7,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi ,',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 48),
                      ),
                      Text(
                        _teacherName ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: const Color(0xff555555)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRouteConst.profileRouteName);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 4, bottom: 4, left: 10, right: 4),
                      height: Responsive.height * 4.2,
                      width: Responsive.width * 22,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 219, 219),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Color(0xFF555555)),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Image.asset(
                              'assets/icons/profile_icon.png',
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Responsive.height * 10,
              ),
              CustomContainer(
                color: Colors.green,
                text: 'Homework',
                icon: Icons.note_alt,
                ontap: () {
                  context.pushNamed(AppRouteConst.homeworkRouteName);
                },
              ),
              SizedBox(height: Responsive.height * 1),
              CustomContainer(
                color: Colors.black,
                text: 'Attendance',
                icon: Icons.assignment_add,
                ontap: () {
                  showAttendanceBottomSheet(context);
                },
              ),
              SizedBox(height: Responsive.height * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomNameContainer(
                    // horizontalWidth: 14.2,
                    text: "Students",
                    onPressed: () {
                      context.pushNamed(AppRouteConst.studentRouteName,
                          extra: UserType.teacher);
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomNameContainer(
                    // horizontalWidth: 14.2,
                    text: "Notes",
                    onPressed: () {
                      context.pushNamed(AppRouteConst.NotesRouteName);
                      // context.pushNamed(AppRouteConst.parentRouteName);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * 1.6,
              ),
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
                      context.pushNamed(AppRouteConst.ParentNoticePageRouteName,
                          extra: true);
                    },
                    child: const Text(
                      "View",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * .5,
              ),
              Consumer<NoticeController>(builder: (context, value, child) {
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
                        padding: const EdgeInsets.only(bottom: 1.5),
                        child: DutyCard(
                          bottomRadius: bottomRadius.toDouble(),
                          topRadius: topRadius.toDouble(),
                          title: notice.title ?? "",
                          date: DateFormatter.formatDateString(
                              notice.date.toString()),
                          time: TimeFormatter.formatTimeFromString(
                              notice.createdAt.toString()),
                          onTap: () {
                            context.pushNamed(
                              AppRouteConst.NoticeDetailedPageRouteName,
                              extra: NoticeDetailArguments(
                                  notice: notice, userType: UserType.parent),
                            );
                          },
                          description: notice.description ?? "",
                          // fileUpload: notice.fileUpload ?? "",
                        ));
                  },
                );
              }),
              SizedBox(
                height: Responsive.height * 1,
              ),
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
                      context.pushNamed(AppRouteConst.EventsPageRouteName,
                          extra: true);
                    },
                    child: const Text(
                      "View",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * .5,
              ),
              Consumer<NoticeController>(builder: (context, value, child) {
                if (noticeController.isloading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.events.take(2).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: EventCard(
                        onTap: () {
                          context.pushNamed(
                              AppRouteConst.EventDetailedPageRouteName,
                              extra: EventDetailArguments(
                                event: value.events[index],
                                userType: UserType.parent,
                              ));
                        },
                        bottomRadius: 16,
                        topRadius: 16,
                        eventDescription: value.events[index].description ?? "",
                        eventTitle: value.events[index].title ?? "",
                        date: DateFormatter.formatDateString(
                            value.events[index].eventDate.toString()),
                        time: TimeFormatter.formatTimeFromString(
                            value.events[index].createdAt.toString()),
                        imageProvider:
                            "${baseUrl}${Urls.eventPhotos}${value.events[index].images![0].imagePath}",
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
          right: 16,
        ),
        child: FloatingActionButton(
          onPressed: () {
            _togglePopup(context);
          },
          backgroundColor: Colors.black, // Customize color
          shape: CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white), // Icon inside FAB
        ),
      ),
    );
  }

  Widget _customContainer({
    required String text,
    IconData? icon,
    String? iconPath,
    double iconSize = 35,
    required VoidCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Responsive.height * 3),
        width: Responsive.width * 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
              child: iconPath == null
                  ? Icon(
                      // Show Material icon if iconPath is null
                      icon ??
                          Icons.dashboard_customize_outlined, // Default icon
                      color: Colors.white,
                      size: iconSize,
                    )
                  : Image.asset(
                      // Show image if iconPath is provided
                      iconPath,
                      height: iconSize,
                      width: iconSize,
                    ),
            ),
            Text(
              text,
              style: const TextStyle(color: Color(0xFF444444), fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
