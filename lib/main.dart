import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/controller/dropdown_controller.dart';
import 'package:school_app/sample/controller/student_controller.dart';
import 'package:school_app/teacher/attendance/controller/attendance_controller.dart';
import 'package:school_app/teacher/navbar/controller/navbar_provider.dart';
import 'package:school_app/teacher/routes/app_route_config.dart';
import 'package:school_app/theme/app_theme.dart';
import 'package:school_app/utils/responsive.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(const MyApp());
// }
void main() {
  Approuter appRouter = Approuter();
  runApp(MyApp(
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  final Approuter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          Responsive().init(constraints, orientation);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => BottomNavProvider()),
              ChangeNotifierProvider(create: (_) => DropdownProvider()),
              ChangeNotifierProvider(create: (_) => AttendanceController()),
              ChangeNotifierProvider(create: (_) => SampleController()),
            ],
            child: MaterialApp.router(
              themeMode: ThemeMode.light,
              title: '',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme(context),
              routeInformationParser: appRouter.router.routeInformationParser,
              routerDelegate: appRouter.router.routerDelegate,
              routeInformationProvider:
                  appRouter.router.routeInformationProvider,
              // home: SplashScreen(),
            ),
          );
        },
      );
    });
  }
}
