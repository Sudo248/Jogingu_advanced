import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogingu_advanced/app/base/setup_service_locator.dart';
import 'package:jogingu_advanced/app/pages/splash/views/splash_page.dart';
import 'package:jogingu_advanced/app/pages/target/views/edit_target_tab.dart';
import 'package:jogingu_advanced/app/routes/app_pages.dart';
import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:get_it/get_it.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: [],
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.I.get<NavigatorService>().navigatorKey,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primaryColorLight: AppColors.primaryColorLight,
        primaryColorDark: AppColors.primaryColorDark,
        focusColor: AppColors.primaryColor,
        fontFamily: FontFamily.raleway,
      ),
      onGenerateRoute: (routeSettings) => AppPages.getPages(routeSettings),
      home: const SplashPage(),
    );
  }
}
