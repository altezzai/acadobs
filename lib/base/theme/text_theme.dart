import 'package:flutter/material.dart';
import 'package:school_app/base/utils/constants.dart';

TextTheme textThemeData = const TextTheme(
  bodyMedium: TextStyle(color: blackColor, fontSize: 16),  // Standard for body text
  bodyLarge: TextStyle(
    color: blackColor,
    fontSize: 18,  // Slightly larger for emphasis
    fontWeight: FontWeight.bold,
  ),
  bodySmall: TextStyle(
    color: greyColor,
    fontSize: 14,  // Smaller for secondary text
  ),
  headlineLarge: TextStyle(
    fontSize: 24,  // Standard headline size
    color: blackColor,
    fontWeight: FontWeight.w700,
  ),
  headlineMedium: TextStyle(
    fontSize: 20,  // Slightly smaller for sub-headlines
    color: blackColor,
    fontWeight: FontWeight.w600,
  ),
);
