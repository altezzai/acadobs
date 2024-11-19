import 'package:flutter/material.dart';
import 'package:school_app/base/utils/responsive.dart';

class DailyAttendanceContainer extends StatelessWidget {
  // final Function(DateTime) onDateSelected;
  const DailyAttendanceContainer({
    super.key,
    //  required this.onDateSelected,
  });

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
                children: [
                  Text(
                    "Date",
                    style: TextStyle(color: Color(0xFF7C7C7C)),
                  ),
                  InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.keyboard_arrow_down_outlined)),
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

  Future<void> _selectDate(BuildContext context) async {
    // final DateTime? pickedDate = await
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              // Adjust the font size for the calendar picker
              bodyMedium: TextStyle(fontSize: 14), // Smaller font for dates
            ),
          ),
          child: child!,
        );
      },
    );
    // if (pickedDate != null) {
    //   onDateSelected(pickedDate); // Trigger callback
    //   dateController.text =
    //       DateFormat('yyyy-MM-dd').format(pickedDate); // Update controller text
    // }
  }
}
