import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:jogingu_advanced/app/utils/util.dart';
import 'package:jogingu_advanced/data/services/location_service.dart';
import 'package:jogingu_advanced/data/services/step_counter_service.dart';
import 'package:jogingu_advanced/data/services/timer_service.dart';
import 'package:jogingu_advanced/domain/common/constants.dart';
import 'package:jogingu_advanced/domain/common/failure.dart';
import 'package:jogingu_advanced/domain/common/run_state.dart';
import 'package:jogingu_advanced/domain/common/status.dart' as Status;
import 'package:jogingu_advanced/domain/entities/run.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:math';
import '../../../../domain/common/logger.dart';

class RunBloc extends BlocBase {
  late final MapboxMapController mapController;
  late final AnimationController runBottomBarController;
  late final Line line;

  final LocationService locationService;
  final TimerService timerService;
  final StepCounterService stepCounterService;
  final RunRepository repository;

  final double R = 6371e3;

  BehaviorSubject<RunState> runState = BehaviorSubject.seeded(RunState.start);
  Stream<RunState> get runStateStream => runState.stream;
  Sink<RunState> get runStateSink => runState.sink;

  Stream<int> get timeStream => timerService.timerStream;

  Stream<int> get stepStream => stepCounterService.stepCounterStream;

  BehaviorSubject<double> speed = BehaviorSubject.seeded(0);
  Stream<double> get speedStream => speed.stream;
  Sink<double> get speedSink => speed.sink;

  BehaviorSubject<double> distance = BehaviorSubject.seeded(0);
  Stream<double> get distanceStream => distance.stream;
  Sink<double> get distanceSink => distance.sink;

  BehaviorSubject<Status.Status<String>> canSaveRun =
      BehaviorSubject.seeded(Status.Idle());
  Stream<Status.Status<String>> get canSaveRunStream => canSaveRun.stream;
  Sink<Status.Status<String>> get canSaveRunSink => canSaveRun.sink;

  final List<LatLng> listLocation = List.empty(growable: true);

  LatLng defaultLocation =
      const LatLng(Constants.haNoiLatitude, Constants.haNoiLongtitude);

  StreamController<bool> onMapStyleLoaded = StreamController();

  String urlMap = "";

  RunBloc({
    required this.locationService,
    required this.timerService,
    required this.stepCounterService,
    required this.repository,
  });

  @override
  void onInit() async {
    // installMap();
  }

  Future<bool> isLocationPermission() async {
    if (await locationService.checkAndRequestLocationService()) {
      if (await locationService.checkAndRequestPermissionForUpdateLocation()) {
        subcriptionUpdateLocation();
        stepCounterService.subscribeStepCounterService();
        return Future.value(true);
      } else {
        /// TODO: show dialog required permission for position.
      }
    } else {
      /// TODO: show dialog this device don't have position service or it busy.
    }
    return Future.value(false);
  }

  Future<void> drawStartPosition() async {
    final location = await locationService.getCurrentPosition();
    await mapController.addCircle(CircleOptions(
      circleRadius: 5,
      circleColor: "#0352fc",
      geometry: LatLng(location.latitude!, location.longitude!),
    ));
    Logger.success(message: "draw Start Position");
  }

  void subcriptionUpdateLocation() async {
    Logger.debug(message: "subcriptionUpdateLocation");
    locationService.subcriptionUpdateLocation();
    locationService.notificatrion();

    locationService.onChangedLocation((location) {
      listLocation.add(LatLng(location.latitude!, location.longitude!));
      if (runState.value == RunState.running) {
        updateLine();
        calculateDisctance();
      }
      speedSink.add(location.speed ?? 0.0);
    });
  }

  Future<void> calculateDisctance() async {
    final len = listLocation.length;
    if (len > 2) {
      distanceSink
          .add(distance.value + disctanceBetween(listLocation[len - 2], listLocation[len - 1]));
    }
  }

  double disctanceBetween(LatLng previous, LatLng next) {
    final phi1 = previous.latitude * pi/180;
    final phi2 = next.latitude * pi/180;
    final alphaPhi = (next.latitude - previous.latitude) * pi/180;
    final alphaGamma = (next.longitude - previous.longitude) * pi/180;
    final sinAlphaPhi = sin(alphaPhi / 2);
    final sinAlphaGamma = sin(alphaGamma / 2);
    final a = sinAlphaPhi * sinAlphaPhi + cos(phi1) * cos(phi2) + sinAlphaGamma * sinAlphaGamma;

    final c = 2 * atan2(sqrt(a), sqrt(1-a));

    return R * c / 1000;
  }

  Future<void> calculateSpeed() async {}

  void onLocationChanged(UserLocation location) async {
    listLocation.add(location.position);
    if (runState.value == RunState.running) {
      updateLine();
      calculateDisctance();
    }
    // speedSink.add(location.speed ?? 0.0);
  }

  void updateLine() async {
    mapController.updateLine(line, LineOptions(geometry: listLocation));
  }

  Future<void> unSubcriptionUpdateLocation() async {
    await locationService.unSubcriptionUpdateLocation();
    listLocation.clear();
  }

  void onMyLocationPress() async {
    mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.Tracking);
  }

  Future<void> onMapStyleLoadedCallback() async {
    Timer(const Duration(seconds: 1), () => onMapStyleLoaded.sink.add(true));
  }

  void onStartClick() async {
    line = await mapController.addLine(
      const LineOptions(
        geometry: [],
        lineColor: Constants.lineColor,
        lineWidth: Constants.lineWidth,
        draggable: false,
      ),
    );
    drawStartPosition();
    runStateSink.add(RunState.running);
    runBottomBarController.forward();
    listLocation.clear();
    timerService.start();
    stepCounterService.start();
  }

  void onPauseOrResumeClick() async {
    if (runState.value == RunState.running) {
      runStateSink.add(RunState.pause);
      locationService.pauseUpdateLocation();
      timerService.pause();
      stepCounterService.pause();
    } else {
      runStateSink.add(RunState.running);
      locationService.resumeUpdateLocation();
      timerService.resume();
      stepCounterService.resume();
    }
  }

  void navigateToMainPage() => navigator.navigateOffAll(AppRoutes.main);

  Future<void> onSave() async {
    //save run here
    final nameRun = getNameRunByTime();
    final totalDisctance = distance.value;
    final totalTime = timerService.timer.value;
    final avgSpeed = totalDisctance / totalTime;
    final stepCount = stepCounterService.stepCounter.value;
    final placeName = getPlaceName(listLocation.last);
    final startTime = DateTime.now().subtract(Duration(seconds: totalTime));

    await repository.add(
      Run(
        runId: "",
		key: -1,
        name: await nameRun,
        distance: totalDisctance,
        avgSpeed: avgSpeed,
        timeRunning: totalTime,
        caloBunred: 0,
        timeStart: startTime,
        stepCount: stepCount,
        location: await placeName,
		image: urlMap,
      ),
    );

    Logger.success(message: """
	nameRun: ${await nameRun},
	locationName: ${await formatTime(startTime)}-${await placeName},
	totalDisctance: $totalDisctance,
	totalTime: $totalTime,
	avgSpeed: $avgSpeed,
	url: $urlMap
""");

    navigator.navigateOffAll(AppRoutes.main);
  }

  Future<String> getUrlMap(Size size) async {
    canSaveRunSink.add(Status.Loading());
    double minLat = double.infinity,
        minLng = double.infinity,
        maxLng = -double.infinity,
        maxLat = -double.infinity;
    final polylines = encodePolyline(listLocation.map(
      (e) {
        double lat = e.latitude;
        double lng = e.longitude;
        if (maxLat < lat) maxLat = lat;
        if (minLat > lat) minLat = lat;
        if (maxLng < lng) maxLng = lng;
        if (minLng > lng) minLng = lng;
        return [e.latitude, e.longitude];
      },
    ).toList());
    if (minLat == maxLat || minLng == maxLng || listLocation.length < 5) {
      Logger.error(message: "Invalid url mapbox");
      canSaveRunSink.add(Status.Error(const DefaultError(
          "Not moving yet?\nJogingu needs along run to upload. Please continute or start over.")));
      return "Invalid URL";
    }
    final uri = Uri.encodeComponent(polylines);
    final url = getUrlStaticMapbox(
      minLat: minLat,
      minLng: minLng,
      maxLat: maxLat,
      maxLng: maxLng,
      size: size,
      path: uri,
    );
    Logger.success(message: "link: " + url);
    urlMap = url;
    canSaveRunSink.add(Status.Success(urlMap));
    return url;
  }

  @override
  void onDispose() async {
    await unSubcriptionUpdateLocation();
    runState.close();
    timerService.cancel();
    stepCounterService.cancel();
    speed.close();
    distance.close();
    onMapStyleLoaded.close();
  }
}
