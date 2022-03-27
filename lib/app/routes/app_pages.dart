import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/pages/profile/view/profile_page.dart';
import 'package:jogingu_advanced/app/pages/run/view/run_page.dart';
import 'package:jogingu_advanced/app/pages/statistic/view/statistic_page.dart';
import 'package:jogingu_advanced/app/pages/target/views/target_page.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';

import '../pages/home/view/home_page.dart';

abstract class AppPages {
  static Route<dynamic> getPages(RouteSettings route) {
    switch (route.name) {
      case AppRoutes.run:
        return MaterialPageRoute(builder: (ctx) => RunPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (ctx) => ProfilePage());

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
