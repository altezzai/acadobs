import 'package:flutter/material.dart';
import 'package:school_app/admin/theme/button_theme.dart';
import 'package:school_app/admin/theme/input_decoration.dart';
import 'package:school_app/admin/theme/text_theme.dart';
import 'package:school_app/admin/theme/theme_data.dart';

import '../utils/constants.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Inter",
      primarySwatch: primaryMaterialColor,
      primaryColor: blackColor,
      scaffoldBackgroundColor: Colors.grey.shade200,
      iconTheme: const IconThemeData(color: blackColor),
      textTheme: textThemeData,
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: lightInputDecorationTheme,
      appBarTheme: appBarLightTheme,
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableLightThemeData,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Plus Jakarta",
      primarySwatch: primaryMaterialColor,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: blackColor),
      textTheme: textThemeData,
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: lightInputDecorationTheme,
      appBarTheme: appBarLightTheme,
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableLightThemeData,
    );
  }
}
