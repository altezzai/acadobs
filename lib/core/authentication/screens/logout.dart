import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';

class LogoutScreen extends StatelessWidget {
  final UserType userType; // UserType passed as a parameter

  const LogoutScreen({super.key, required this.userType}); // Receive userType

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigate based on the userType
                    if (userType == UserType.parent) {
                      context.pushReplacementNamed(
                        AppRouteConst.ParentHomeRouteName, // Navigate to ParentHomeRoute
                      );
                    } else {
                      // Navigate back to BottomNavScreen with the respective userType
                      context.goNamed(
                        AppRouteConst.bottomNavRouteName,
                        extra: userType, // Pass the userType as extra
                      );
                    }
                  },
                ),
                // Edit profile button
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            // Profile Picture, Name, and Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/admin.png'),
                ),
                SizedBox(width: Responsive.width * 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vincent',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildListItem(Icons.task, 'Duties'),
                  _buildListItem(Icons.payment, 'Payments'),
                  _buildListItem(Icons.settings, 'Settings'),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Log out', style: TextStyle(color: Colors.red)),
                    onTap: () {
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
