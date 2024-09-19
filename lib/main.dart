import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/admin/screens/splashscreen.dart';
import 'package:school_app/teacher/navbar/controller/navbar_provider.dart';
import 'package:school_app/theme/app_theme.dart';
import 'package:school_app/utils/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          Responsive().init(constraints, orientation);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_)=>BottomNavProvider())
            ],
            child: MaterialApp(
              themeMode: ThemeMode.light,
              title: '',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme(context),
              home: SplashScreen(), // Set LoginPage as the home
            ),
          );
        },
      );
    });
  }
}
