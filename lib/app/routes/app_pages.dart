import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/pages/about/view/about_page.dart';
import 'package:jogingu_advanced/app/pages/main/views/main_page.dart';
import 'package:jogingu_advanced/app/pages/profile/views/profile_page.dart';
import 'package:jogingu_advanced/app/pages/run/views/run_page.dart';
import 'package:jogingu_advanced/app/pages/statistic/views/statistic_page.dart';
import 'package:jogingu_advanced/app/pages/target/views/target_page.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';

import '../pages/home/views/home_page.dart';
import '../pages/target/views/edit_target_tab.dart';

abstract class AppPages {
  static Route<dynamic> getPages(RouteSettings route) {
    switch (route.name) {
      case AppRoutes.main:
        return MaterialPageRoute(builder: (ctx) => MainPage());
      case AppRoutes.run:
        return MaterialPageRoute(builder: (ctx) => RunPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (ctx) => ProfilePage());
      case AppRoutes.about:
        return MaterialPageRoute(builder: (ctx) => const AboutPage());
      case AppRoutes.editTarget:
        return MaterialPageRoute(builder: (ctx) => EditTargetPage());
      default:
        return MaterialPageRoute(builder: (ctx) => Container());
    }
  }

  static List<Map<String, dynamic>> getFragments() {
    return [
      {
        "name": AppRoutes.home,
        "page": HomePage(),
      },
      {
        "name": AppRoutes.target,
        "page": TargetPage(),
      },
      {
        "name": AppRoutes.statistic,
        "page": StatisticPage(),
      },
    ];
  }
}
