import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/services/secure_storage_services.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showExtraButton = false; // State to toggle extra button visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Responsive.height * 2,
            ),
            CustomAppbar(
              title: 'Profile',
              isProfileIcon: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 45,
                  child: Icon(
                    Icons.person_outline_sharp,
                    size: 50,
                  ),
                ),
                SizedBox(
                  width: Responsive.width * 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String?>(
                      future: SecureStorageService.getUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...',
                              style: textThemeData.bodyLarge);
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Text('Unknown',
                              style: textThemeData.bodyLarge);
                        }
                        return Text(snapshot.data!,
                            style: textThemeData.bodyLarge);
                      },
                    ),
                    FutureBuilder<String?>(
                      future: SecureStorageService.getUserEmail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...',
                              style: textThemeData.labelMedium);
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Text('Unknown',
                              style: textThemeData.labelMedium);
                        }
                        return Text(snapshot.data!,
                            style: textThemeData.labelMedium);
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: Responsive.height * 4,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.width * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Responsive.height * 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   _showExtraButton =
                        //       !_showExtraButton; // Toggle visibility
                        // });
                      },
                      child: Text(
                        'Account Settings',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff7C7C7C),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Responsive.height * 2,
                    ),
                    if (_showExtraButton) // Show extra button if state is true
                      GestureDetector(
                        onTap: () {
                          // context
                          //     .pushNamed(AppRouteConst.personalinfoRouteName);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: Responsive.height * 2,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor: Color(0xffF4F4F4),
                                  child: Icon(Icons.person_2_outlined)),
                              SizedBox(
                                width: Responsive.width * 4,
                              ),
                              Text(
                                'Personal Informations',
                                style: textThemeData.bodyMedium,
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xffAFAFAF),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () async {
                        // context.read<AuthController>().logout(context: context);
                        await SecureStorageService.clearSecureStorage();
                        context.goNamed(AppRouteConst.loginRouteName);
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE13E3E),
                      ),
                    ),
                    SizedBox(
                      height: Responsive.height * 2,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
