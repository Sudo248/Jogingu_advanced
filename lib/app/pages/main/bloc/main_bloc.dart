import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/home/views/home_page.dart';
import 'package:jogingu_advanced/app/routes/app_pages.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:jogingu_advanced/domain/common/constants.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BlocBase {
  final fragments = AppPages.getFragments();

  late final BehaviorSubject<Map<String, dynamic>> currentFragment;

  Sink<Map<String, dynamic>> get currentFragmentSink => currentFragment.sink;
  Stream<Map<String, dynamic>> get currentFragmentStream =>
      currentFragment.stream;

	  int currentFragmentIndex = 0;

  MainBloc() {
    currentFragment = BehaviorSubject.seeded(fragments[0]);
    installMap();
  }

  void installMap() async {
    try {
      //   downloadOfflineRegion(
      //       OfflineRegionDefinition(
      //         bounds: LatLngBounds(
      //           northeast: LatLng(23.577369, 107.883067),
      //           southwest: LatLng(8.574989, 103.491424),
      //         ),
      //         mapStyleUrl: Constants.mapStyle,
      //         minZoom: Constants.minZoom,
      //         maxZoom: Constants.maxZoom,
      //       ),
      //       accessToken: Constants.accessToken, onEvent: (status) {
      //     if (status.runtimeType == Success) {
      //       Logger.success(message: "install map success");
      //     } else if (status.runtimeType == InProgress) {
      //       //   int progress = (status as InProgress).progress.round();
      //     } else if (status.runtimeType == Error) {
      //       Logger.error(message: "${(status as Error).cause}");
      //     }
      //   });

      //   await installOfflineMapTiles('assets/cache/cache.db');
      //   Logger.success(message: "installed map");
      //   setOffline(true, accessToken: Constants.accessToken);
    } catch (e) {
      Logger.error(key: "on download map", message: e.toString());
    }
  }

  void navigateToPage(String route) async {
    navigator.navigateTo(route);
  }

  void navigateOffToPage(String route) async {
    navigator.navigateOff(route);
  }

  void navigateToFragment(int index) async {
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
