import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/run/views/run_action_button.dart';
import 'package:jogingu_advanced/app/pages/run/views/run_bottom_bar.dart';
import 'package:jogingu_advanced/app/pages/run/bloc/run_bloc.dart';
import 'package:jogingu_advanced/domain/common/constants.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:jogingu_advanced/domain/common/run_state.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:rxdart/rxdart.dart';

class RunPage extends PageBase<RunBloc> {
  RunPage({Key? key}) : super(key: key);
  late final Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double heightScreen = size.height;
    return WillPopScope(
      onWillPop: () => onBackPress(context),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              FutureBuilder<bool>(
                future: bloc.isLocationPermission(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<bool> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MapboxMap(
                      accessToken: Constants.accessToken,
                      styleString: Constants.mapStyle,
                      initialCameraPosition: CameraPosition(
                          target: bloc.defaultLocation,
                          zoom: Constants.defaultZoom),
                      minMaxZoomPreference: const MinMaxZoomPreference(
                        Constants.minZoom,
                        Constants.maxZoom,
                      ),
                      onMapCreated: (controller) async {
                        bloc.mapController = controller;
                        Logger.success(message: "on Map Created");
                      },
                      onStyleLoadedCallback: () {
                        bloc.onMapStyleLoadedCallback();
                        Logger.success(message: "on Style Loaded Callback");
                      },
                      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                      trackCameraPosition: true,
                      attributionButtonPosition:
                          AttributionButtonPosition.BottomRight,
                      compassViewPosition: CompassViewPosition.TopLeft,
                      onUserLocationUpdated: (location) {
                        //   Logger.debug(
                        //       key: "current position from mapbox",
                        //       message: "${location.position}");
                        //   bloc.onLocationChanged(location);
                      },
                      myLocationEnabled: true //snapshot.data!,
                      );
                },
              ),
              StreamBuilder<bool>(
                stream: bloc.onMapStyleLoaded.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || !snapshot.data!) {
                    return const SizedBox.shrink();
                  }
                  return Positioned(
                    top: 5,
                    right: 5,
                    child: FloatingActionButton.small(
                      onPressed: bloc.onMyLocationPress,
                      child: const Icon(
                        Icons.my_location_outlined,
                        size: 25,
                        color: Colors.black54,
                      ),
                      backgroundColor: Colors.white70,
                    ),
                  );
                },
              ),
              RunBottomBar(
                onInit: (controller) =>
                    bloc.runBottomBarController = controller,
                height: heightScreen * 0.3,
                actionButton: RunActionButton(
                  runStateStream: bloc.runStateStream,
                  disctanceStream: bloc.distanceStream,
                  onStartClick: bloc.onStartClick,
                  onFinishClick: () {
                    _showDialog(context);
                  },
                  onPauseOrResumeClick: bloc.onPauseOrResumeClick,
                ),
                duration: const Duration(milliseconds: 500),
                speedStream: bloc.speedStream,
                timeStream: bloc.timeStream,
                stepStream: bloc.stepStream,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress(BuildContext context) async {
    if (bloc.runState.value != RunState.start) {
      _showDialog(context);
    } else {
      bloc.navigateToMainPage();
    }
    return Future.value(false);
  }

  Future<void> _showDialog(BuildContext context) async {
    bloc.getUrlMap(Size(size.width, size.height * 0.3));
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StreamBuilder<Status<String>>(
        stream: bloc.canSaveRunStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          return snapshot.data!.when<Widget>(
            onIdle: () => const SizedBox.shrink(),
            onLoading: () => AlertDialog(
              content: SizedBox.square(
                dimension: size.width * 0.8,
                child: const SizedBox.square(
                  dimension: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            onSuccess: (url) => AlertDialog(
              title: const FittedBox(
                child: Text(
                  'Do you want to save this activity?',
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              content: SizedBox(
                width: size.width * 0.8,
                child: Image.network(
                  url,
                  //   loadingBuilder: (BuildContext context, Widget child,
                  //       ImageChunkEvent? loadingProgress) {
                  //     if (loadingProgress == null) return child;
                  //     return const Center(
                  //       child: SizedBox.square(
                  //         dimension: 50,
                  //         child: CircularProgressIndicator(),
                  //       ),
                  //     );
                  //   },
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  },
                  errorBuilder: (context, object, _) => Text(
                    "No internet access",
                    style: AppStyles.h5.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    bloc.navigator.back();
                  },
                  child: const Text(
                    "Continute",
                  ),
                ),
                TextButton(
                  child: const Text('Discard'),
                  onPressed: () {
                    bloc.navigateToMainPage();
                  },
                ),
                TextButton(
                  onPressed: () {
                    bloc.onSave();
                  },
                  child: const Text("Save"),
                )
              ],
            ),
            onError: (error) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: Center(
                child: Text(
                  "Error",
                  style: AppStyles.h4.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
              content: SizedBox(
                width: size.width * 0.8,
                child: Text(
                  error.message,
                  maxLines: 3,
                  style: AppStyles.h5.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    bloc.navigator.back();
                  },
                  child: const Text(
                    "Continute",
                  ),
                ),
                TextButton(
                  child: const Text('Discard'),
                  onPressed: () {
                    bloc.navigateToMainPage();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
