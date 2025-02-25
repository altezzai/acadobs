import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:school_app/core/shared_widgets/custom_name_container.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';
import 'package:school_app/features/admin/notices/controller/notice_controller.dart';
import 'package:school_app/features/parent/events/widget/eventcard.dart';

class TeacherScreen extends StatefulWidget {
  TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  String? _teacherName;
  String? _profilePhoto;
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
    final photo = await SecureStorageService.getTeacherProfilePhoto();
    setState(() {
      _teacherName = name ?? 'Teacher'; // Fallback if name is null
      _profilePhoto =
          photo != null ? '$baseUrl${Urls.teacherPhotos}$photo' : null;
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
                      context.pushNamed(AppRouteConst.logoutRouteName,
                          extra: UserType.teacher);
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
                ],
              ),
              SizedBox(
                height: Responsive.height * 10,
              ),
              _customContainer(
                color: Colors.green,
                text: 'Homework',
                icon: Icons.note_alt,
                ontap: () {
                  context.pushNamed(AppRouteConst.homeworkRouteName);
                },
              ),
              SizedBox(height: Responsive.height * 1),
              _customContainer(
                  color: Colors.red,
                  text: 'Leave Request',
                  icon: Icons.assignment_add,
                  ontap: () {
                    context.pushNamed(
                        AppRouteConst.TeacherLeaveRequestScreenRouteName);
                  }),
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
                    text: "Parents",
                    onPressed: () {
                      context.pushNamed(AppRouteConst.parentRouteName);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height * 1,
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
    );
  }

  Widget _customContainer({
    required Color color,
    required String text,
    IconData icon = Icons.dashboard_customize_outlined,
    required VoidCallback ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Responsive.height * 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width * 3),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
