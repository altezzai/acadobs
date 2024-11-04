import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/controller/duty_controller.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';

class DutiesHomeScreen extends StatefulWidget {
  @override
  State<DutiesHomeScreen> createState() => _DutiesHomeScreenState();
}

class _DutiesHomeScreenState extends State<DutiesHomeScreen> {
  @override
  void initState() {
    context.read<DutyController>().getDuties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            CustomAppbar(
              title: "Duties",
              isBackButton: false,
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.03,
                      horizontal: screenWidth * 0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.pushReplacementNamed(
                      AppRouteConst.AdminAddDutyRouteName);
                },
                icon: Icon(Icons.event_note_outlined, color: Colors.white),
                label: Text(
                  'Add Duty',
                  style: TextStyle(
                      color: Colors.white, fontSize: screenWidth * 0.05),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.05,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            DutyCard(
              title: "PTA meeting class XII",
              date: "15-06-24",
              time: "09:00 am",
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Yesterday',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.05,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Consumer<DutyController>(
                builder: (context, value, child) {
                  if (value.isloading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: value.duties.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: DutyCard(
                          title: value.duties[index].dutyTitle ?? "",
                          date: DateFormatter.formatDateString(
                              value.duties[index].createdAt.toString()),
                          time: TimeFormatter.formatTimeFromString(
                              value.duties[index].createdAt.toString()),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
