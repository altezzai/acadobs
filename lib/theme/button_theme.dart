import 'package:flutter/material.dart';

import '../utils/constants.dart';

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    backgroundColor: blackColor,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 32),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(defaultBorderRadius),
      ),
    ),
  ),
);

OutlinedButtonThemeData outlinedButtonTheme(
    {Color borderColor = primaryColor}) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(defaultPadding),
      // minimumSize: const Size(double.infinity, 32),
      side: BorderSide(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

final textButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(foregroundColor: primaryColor),
);
