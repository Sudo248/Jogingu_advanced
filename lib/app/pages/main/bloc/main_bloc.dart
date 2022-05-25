import 'package:jogingu_advanced/app/base/base_fragment_route.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/base/base_fragment.dart';
import 'package:jogingu_advanced/app/routes/app_pages.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/shared_preference/app_pref.dart';

class MainBloc extends BlocBase {
  final AppPref pref;
  final onGenerateRoute = AppPages.getFragmentsByIndex;

  MainBloc({required this.pref}) {
    fragmentRoute = BehaviorSubject.seeded(onGenerateRoute(0));
    // installMap();
  }

  // final fragments = AppPages.getFragments();

  late final BehaviorSubject<BaseFragmentRoute> fragmentRoute;

  Sink<BaseFragmentRoute> get fragmentSink => fragmentRoute.sink;
  Stream<BaseFragmentRoute> get fragmentStream => fragmentRoute.stream;

  int currentFragmentIndex = 0;

  @override
  void onDispose() {
    // for (BaseFragment fragment in fragments) {
    //   fragment.bloc.onDispose();
    // }
  }

  @override
  void onInit() async {
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

  Future<bool> get canRun => pref.canRun;

  Future<T?> navigateToPage<T>(String route, {Object? arguments}) async {
    return navigator.navigateTo<T>(route, arguments: arguments);
  }

  void prepareToRun() async {
    final isSaved = await navigateToPage(AppRoutes.profile, arguments: "prepareToRun") ?? false;
    // print("prepareToRun $isSaved");
    if (isSaved) {
      await pref.setCanRun(true);
      navigateOffToPage(AppRoutes.run);
    }
  }

  Future<void> navigateOffToPage(String route, {Object? arguments}) async {
    navigator.navigateOff(route, arguments: arguments);
  }

  Future<void> navigateToFragment(int index) async {
    if (index == 3) {
      final isSaved = await navigateToPage(AppRoutes.profile);
      if (isSaved) {
        await pref.setCanRun(true);
      }
    } else {
      fragmentSink.add(onGenerateRoute(index));
    }
  }
}
