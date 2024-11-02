import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';

class PaymentReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppbar(
                title: "Payment Report",
                isBackButton: true,
                onTap: () {
                  context.goNamed(
                    AppRouteConst.bottomNavRouteName,
                    extra: UserType.admin,
                  );
                })
          ],
        ),
      ),
    );
  }
}
