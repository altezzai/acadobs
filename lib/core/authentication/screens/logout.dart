import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';

class LogoutScreen extends StatefulWidget {
  final UserType userType;

  const LogoutScreen({super.key, required this.userType});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  String? _teacherName;
  String? _parentName;
  String? _profilePhoto;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (widget.userType == UserType.teacher) {
      await _fetchTeacherData();
    } else if (widget.userType == UserType.parent) {
      await _fetchStudentData();
    }
  }

  Future<void> _fetchTeacherData() async {
    final name = await SecureStorageService.getTeacherName();
    final photo = await SecureStorageService.getTeacherProfilePhoto();
    setState(() {
      _teacherName = name ?? 'Teacher'; // Default to "Teacher"
      _profilePhoto =
          photo != null ? '$baseUrl${Urls.teacherPhotos}$photo' : null;
    });
  }

  Future<void> _fetchStudentData() async {
    final name = await SecureStorageService.getParentName();
    final photo = await SecureStorageService.getParentProfilePhoto();
    setState(() {
      _parentName = name ?? 'Parent'; // Default to "Parent"
      _profilePhoto =
          photo != null ? '$baseUrl${Urls.parentPhotos}$photo' : null;
    });
  }

  File? _imageFile;

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _imageFile = File(result.files.first.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List<Widget> _getListItemsByUserType() {
    if (widget.userType == UserType.admin) {
      return [
        _buildListItem(Icons.task, 'Duties'),
        _buildListItem(Icons.list, 'Report'),
        _buildListItem(Icons.notifications_active, 'Notice'),
        _buildListItem(Icons.currency_rupee, 'Payment'),
      ];
    } else if (widget.userType == UserType.teacher) {
      return [
        _buildListItem(Icons.people, 'Attendance'),
        _buildListItem(Icons.assignment, 'Marks'),
        _buildListItem(Icons.task, 'Duties'),
        _buildListItem(Icons.currency_rupee, 'Payments'),
      ];
    } else if (widget.userType == UserType.parent) {
      return [
        _buildListItem(Icons.list, 'Report'),
        _buildListItem(Icons.event, 'Event'),
        _buildListItem(Icons.notifications_active, 'Notice'),
        _buildListItem(Icons.currency_rupee, 'Payment'),
        _buildListItem(Icons.chat, 'Chat'),
      ];
    }
    return []; // Return empty list for other user types
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        widget.userType == UserType.teacher ? _teacherName : _parentName;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(
              AppRouteConst.bottomNavRouteName,
              extra: widget.userType,
            );
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: Responsive.height * 2),
            // Profile Picture and Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : (_profilePhoto != null
                                  ? NetworkImage(_profilePhoto!)
                                  : const AssetImage('assets/icons/avatar.png'))
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 51),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Responsive.width * 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  ..._getListItemsByUserType(), // Spread the role-specific list items
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Log out',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () async {
                      // context.read<AuthController>().logout(context: context);
                      await SecureStorageService.clearSecureStorage();
                      context.goNamed(AppRouteConst.loginRouteName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        // Add respective action here
      },
    );
  }
}
