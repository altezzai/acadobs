import 'package:flutter/material.dart';
import 'package:school_app/admin/screens/splashscreen.dart';
import 'package:school_app/admin/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      
      title: '',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      home: SplashScreen(), // Set LoginPage as the home
    );
  }
}
