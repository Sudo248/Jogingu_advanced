import 'dart:async';
import 'dart:math';

import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  final Location _location = Location();

  StreamSubscription? streamSubscription;

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

  void unSubcriptionUpdateLocation() {
    streamSubscription?.cancel();
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

  void onChangedLocation(void Function(LocationData) onData) {
    streamSubscription =
        _location.onLocationChanged.listen((event) => onData(event));
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
