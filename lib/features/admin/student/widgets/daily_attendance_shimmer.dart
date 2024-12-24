import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DailyAttendanceShimmer extends StatelessWidget {
  const DailyAttendanceShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: 100,
                  color: Colors.grey,
                ),
                Container(
                  height: 20,
                  width: 50,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 40,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Period Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                10, // Number of periods
                (index) => Container(
                  height: 60,
                  width: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
