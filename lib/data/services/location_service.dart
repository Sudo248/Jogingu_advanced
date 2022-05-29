import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class LocationService {
  final Location _location = Location();

  StreamSubscription? streamSubscription;

  final channelNotification = "NOTIFICATION_CHANNEL";
  final title = "Jogingu";
  final description = "run service";

  void notificatrion() async {
    final data = await _location.changeNotificationOptions(
      channelName: channelNotification,
      title: title,
      iconName: "launcher_icon",
      subtitle: "running",
      description: description,
    );
	
  }

  void subcriptionUpdateLocation() {
    _location.enableBackgroundMode(enable: true);
  }

  Future<void> pauseUpdateLocation() async{
	  final data = await _location.changeNotificationOptions(
      channelName: channelNotification,
      title: title,
      iconName: "launcher_icon",
      subtitle: "pause",
      description: description,
    );
    streamSubscription?.pause();
  }

  Future<void> resumeUpdateLocation() async{
    if (streamSubscription?.isPaused ?? false) {
      streamSubscription?.resume();
    }
	final data = await _location.changeNotificationOptions(
      channelName: channelNotification,
      title: title,
      iconName: "launcher_icon",
      subtitle: "running",
      description: description,
    );
  }

  Future<void> unSubcriptionUpdateLocation() async {
    await streamSubscription?.cancel();
    _location.enableBackgroundMode(enable: false);
  }

  Future<bool> checkAndRequestLocationService() async {
    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  Future<bool> checkAndRequestPermissionForUpdateLocation() async {
    var permissionGranted = await _location.hasPermission();
    _location.requestPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  Future<LocationData> getCurrentPosition() => _location.getLocation();

  Future<LatLng> getLatLngCurrentPosition() async {
    var locationData = await _location.getLocation();
    return Future.value(LatLng(
      locationData.latitude!,
      locationData.longitude!,
    ));
  }

  void onChangedLocation(void Function(LocationData location) onData) {
    streamSubscription = _location.onLocationChanged.listen((event) {
      onData(event);
      //   _location.changeNotificationOptions();
    });
  }

  void onChangedLatLngLocation(void Function(LatLng) onData) {
    streamSubscription = _location.onLocationChanged
        .map(
          (event) => LatLng(
            event.latitude!,
            event.longitude!,
          ),
        )
        .listen((event) => onData(event));
  }
}
