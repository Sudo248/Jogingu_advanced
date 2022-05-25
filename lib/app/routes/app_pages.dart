import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/base_fragment.dart';
import 'package:jogingu_advanced/app/base/base_fragment_route.dart';
import 'package:jogingu_advanced/app/base/base_page_route.dart';
import 'package:jogingu_advanced/app/di/edit_target_dependency.dart';
import 'package:jogingu_advanced/app/di/home_dependency.dart';
import 'package:jogingu_advanced/app/di/main_dependency.dart';
import 'package:jogingu_advanced/app/di/profile_dependency.dart';
import 'package:jogingu_advanced/app/di/run_dependency.dart';
import 'package:jogingu_advanced/app/di/statistic_dependency.dart';
import 'package:jogingu_advanced/app/di/target_dependency.dart';
import 'package:jogingu_advanced/app/pages/about/view/about_page.dart';
import 'package:jogingu_advanced/app/pages/main/views/main_page.dart';
import 'package:jogingu_advanced/app/pages/profile/views/profile_page.dart';
import 'package:jogingu_advanced/app/pages/run/views/run_page.dart';
import 'package:jogingu_advanced/app/pages/main/fragments/statistic/views/statistic_fragment.dart';
import 'package:jogingu_advanced/app/pages/main/fragments/target/views/target_fragment.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';

import '../pages/main/fragments/home/views/home_fragment.dart';
import '../pages/main/fragments/target/views/edit_target_tab.dart';

abstract class AppPages {
  static Route<dynamic> getPages(RouteSettings route) {
    switch (route.name) {
      case AppRoutes.main:
        return BasePageRoute(builder: (ctx) => MainPage(), dependency: MainDependency());
      case AppRoutes.run:
        return BasePageRoute(builder: (ctx) => RunPage(), dependency: RunDependency());
      case AppRoutes.profile:
        return BasePageRoute(builder: (ctx) => ProfilePage(argument: route.arguments as String?,), dependency: ProfileDependency());
      case AppRoutes.about:
        return BasePageRoute(builder: (ctx) => AboutPage());
      case AppRoutes.editTarget:
        return BasePageRoute(builder: (ctx) => EditTargetPage(), dependency: EditTargetDependency());
      default:
        return BasePageRoute(builder: (ctx) => Container());
    }
  }

  static BaseFragmentRoute getFragments(String fragmentName) {
    switch(fragmentName){
      case AppRoutes.home:
        return BaseFragmentRoute(builder: (ctx) => HomeFragment(), dependency: HomeDependency(), nameFragment: AppRoutes.home);
      case AppRoutes.target:
        return BaseFragmentRoute(builder: (ctx) => TargetFragment(), dependency: TargetDependency(), nameFragment: AppRoutes.target);
      default:
        return BaseFragmentRoute(builder: (ctx) => StatisticFragment(), dependency: StatisticDependency(), nameFragment: AppRoutes.statistic);
    }
  }

  static BaseFragmentRoute getFragmentsByIndex(int index) {
    switch(index){
      case 0:
        return BaseFragmentRoute(builder: (ctx) => HomeFragment(), dependency: HomeDependency(), nameFragment: AppRoutes.home);
      case 1:
        return BaseFragmentRoute(builder: (ctx) => TargetFragment(), dependency: TargetDependency(), nameFragment: AppRoutes.target);
      default:
        return BaseFragmentRoute(builder: (ctx) => StatisticFragment(), dependency: StatisticDependency(), nameFragment: AppRoutes.statistic);
    }
  }

}
