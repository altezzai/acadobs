import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/providers/providers.dart';
import 'package:school_app/base/routes/app_route_config.dart';
import 'package:school_app/base/theme/app_theme.dart';
import 'package:school_app/base/utils/responsive.dart';

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
            providers: getProviders(),
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
