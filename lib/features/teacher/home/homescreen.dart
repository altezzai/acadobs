import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_name_container.dart';

class TeacherScreen extends StatefulWidget {
  TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  String? _teacherName;
  String? _profilePhoto;

  @override
  void initState() {
    super.initState();
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
                height: Responsive.height * 15,
              ),
              _customContainer(
                color: Colors.green,
                text: 'Homework',
                icon: Icons.note_alt,
                ontap: () {
                  context.pushNamed(AppRouteConst.homeworkRouteName);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              _customContainer(
                  color: Colors.red,
                  text: 'Leave Request',
                  icon: Icons.assignment_add,
                  ontap: () {
                    context.pushNamed(
                        AppRouteConst.TeacherLeaveRequestScreenRouteName);
                  }),
              SizedBox(
                height: Responsive.height * 2,
              ),
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
                  CustomNameContainer(
                    // horizontalWidth: 14.2,
                    text: "Parents",
                    onPressed: () {
                      context.pushNamed(AppRouteConst.parentRouteName);
                    },
                  ),
                ],
              ),
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
