import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/home/view/home_page.dart';
import 'package:jogingu_advanced/app/routes/app_pages.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BlocBase {
  final fragments = AppPages.getFragments();

  late final BehaviorSubject<Map<String, dynamic>> currentFragment;

  Sink<Map<String, dynamic>> get currentFragmentSink => currentFragment.sink;
  Stream<Map<String, dynamic>> get currentFragmentStream =>
      currentFragment.stream;

  MainBloc() {
    currentFragment = BehaviorSubject.seeded(fragments[0]);
  }

  void navigateToPage(String route) {
    navigator.navigateTo(route);
  }

  void navigateToFragment(int index) {
    if (index == 3) {
      navigator.navigateTo(AppRoutes.profile);
    } else {
      currentFragmentSink.add(fragments[index]);
    }
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }

  @override
  void onInit() {
    // TODO: implement onInit
  }
}
