import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogingu_advanced/app/base/setup_service_locator.dart';
import 'package:jogingu_advanced/app/pages/splash/views/splash_page.dart';
import 'package:jogingu_advanced/app/routes/app_pages.dart';
import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:get_it/get_it.dart';
import 'package:jogingu_advanced/app/service/notification_service.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';
import 'package:jogingu_advanced/resources/app_themes.dart';

import 'app/base/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await Di.get<NotificationService>().initNotification(initScheduled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );

    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Di.get<NavigatorService>().navigatorKey,
      theme: appTheme,
      onGenerateRoute: (routeSettings) => AppPages.getPages(routeSettings),
      home: const SplashPage(),
    );
  }
}
