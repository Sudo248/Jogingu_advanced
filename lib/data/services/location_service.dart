import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class LocationService {
  final Location _location = Location();

  StreamSubscription? streamSubscription;

  final channelNotification = "NOTIFICSTION_CHANNEL";
  final title = "Jogingu";
  final description = "description for notification";

  void notificatrion() async {
    final data = await _location.changeNotificationOptions(
        channelName: channelNotification,
        title: title,
        iconName: "iconName",
        subtitle: "subtitle",
        description: description,
        color: Colors.red);
  }

  void subcriptionUpdateLocation() {
    _location.enableBackgroundMode(enable: true);
  }

  void pauseUpdateLocation() {
    streamSubscription?.pause();
  }

  void resumeUpdateLocation() {
    if (streamSubscription?.isPaused ?? false) {
      streamSubscription?.resume();
    }
  }

  Future<void> unSubcriptionUpdateLocation() async{
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
