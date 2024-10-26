import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/duties/widgets/duty_card.dart';

class DutiesHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              CustomAppbar(
                title: "Duties",
                isBackButton: false,
              ),
              // Add Duty Button
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
              // Today Section
              Text(
                'Today',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Duty Card (Today)
              DutyCard(
                title: "PTA meeting class XII",
                date: "15-06-24",
                time: "09:00 am",
              ),
              SizedBox(height: screenHeight * 0.03),
              // Yesterday Section
              Text(
                'Yesterday',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Duty Cards (Yesterday)
              DutyCard(
                title: "PTA meeting class 09",
                date: "15-06-24",
                time: "09:00 am",
              ),
              SizedBox(height: screenHeight * 0.01),
              DutyCard(
                title: "PTA meeting class 02",
                date: "15-06-24",
                time: "09:00 am",
              ),
              SizedBox(height: screenHeight * 0.01),
              DutyCard(
                title: "PTA meeting class VII",
                date: "15-06-24",
                time: "09:00 am",
              ),
              SizedBox(height: screenHeight * 0.01),
              DutyCard(
                title: "PTA meeting class XII",
                date: "15-06-24",
                time: "09:00 am",
              ),
              SizedBox(height: screenHeight * 0.01),
              DutyCard(
                title: "PTA meeting class XII",
                date: "15-06-24",
                time: "09:00 am",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
