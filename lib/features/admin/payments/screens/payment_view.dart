import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(
              title: "Payments",
              isProfileIcon: false,
              onTap: () {
                context.goNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin,
                );
              },
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('assets/child1.png'),
              radius: 25,
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Text(
              'From Abhijith',
              style: textThemeData.bodyMedium,
            ),
            Text('+91 987654321'),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green.shade100),
              child: Text(
                '\$1000',
                style: TextStyle(fontSize: 55),
              ),
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                SizedBox(
                  width: Responsive.width * 2,
                ),
                Text('Completed'),
              ],
            ),
            SizedBox(
              height: Responsive.height * 1,
            ),
            Container(
              height: Responsive.height * .1,
              width: Responsive.width * 60,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: Responsive.height * 2,
            ),
            Text('20 Nov 2024, 9:00 am')
          ],
        ),
      ),
    );
  }
}
