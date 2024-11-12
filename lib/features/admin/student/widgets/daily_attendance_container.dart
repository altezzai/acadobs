import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class DailyAttendanceContainer extends StatelessWidget {
  const DailyAttendanceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("22 Fri"),
              const Text("7/10"),
              Row(
                children: const [
                  Text(
                    "Date",
                    style: TextStyle(color: Color(0xFF7C7C7C)),
                  ),
                  Icon(Icons.keyboard_arrow_down_outlined),
                  Text("Today"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: Responsive.height * 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              10, // Number of items
              (index) => _periodStatus(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _periodStatus() {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 60,
      width: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF07C3A2),
      ),
    );
  }
}
