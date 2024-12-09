import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:school_app/base/utils/responsive.dart';

class Loading extends StatelessWidget {
  final Color? color;
  final double sizeMultiplier;

  const Loading({
    super.key,
    this.color = Colors.white,
    this.sizeMultiplier = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Responsive.height * sizeMultiplier,
        height: Responsive.height * 3,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          colors: [color!],
          strokeWidth: 1,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
