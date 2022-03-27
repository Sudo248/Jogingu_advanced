import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/setup_service_locator.dart';
import 'package:jogingu_advanced/app/pages/main/view/main_page.dart';
import 'package:jogingu_advanced/app/routes/app_pages.dart';
import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.I.get<NavigatorService>().navigatorKey,
      onGenerateRoute: (routeSettings) => AppPages.getPages(routeSettings),
      home: MainPage(),
    );
  }
}
