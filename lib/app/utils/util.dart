import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jogingu_advanced/domain/common/constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

String getUrlStaticMapbox({
  required double minLat,
  required double minLng,
  required double maxLat,
  required double maxLng,
  int padding = 20,
  required Size size,
  required String path,
}) {
  return "https://api.mapbox.com/styles/v1/mapbox/light-v10/static/path-3+37ff00($path)/[${minLng.toStringAsFixed(4)},${minLat.toStringAsFixed(4)},${maxLng.toStringAsFixed(4)},${maxLat.toStringAsFixed(4)}]/${size.width.toInt()}x${size.height.toInt()}?padding=$padding,$padding,$padding,$padding&access_token=${Constants.accessToken}";
}

Future<String> getNameRunByTime() {
  final hour = DateTime.now().hour;
  final String nameRunByTime;
  if (hour < 12) {
    nameRunByTime = 'Morning';
  } else if (hour < 17) {
    nameRunByTime = 'Afternoon';
  } else {
    nameRunByTime = 'Evening';
  }
  return Future.value(nameRunByTime);
}

Future<String> getPlaceName(LatLng location) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
    location.latitude,
    location.longitude,
    localeIdentifier: 'en',
  );
  if (placemarks.isEmpty) return Future.value("Invalid Location");
  final currentPlace = placemarks.first;
  String placeName = "";
  if (currentPlace.street != null) {
    placeName += "${currentPlace.street}, ";
  }
  if (currentPlace.subAdministrativeArea != null) {
    placeName += "${currentPlace.subAdministrativeArea}, ";
  }
  if (currentPlace.administrativeArea != null) {
    placeName += "${currentPlace.administrativeArea}.";
  }
  return Future.value(placeName);
}

String formatTime(DateTime time) {
  String formatTime = "";
  int differenceDay = time.difference(DateTime.now()).inDays;
  if (differenceDay == 0) {
    formatTime = "Today";
  } else if (differenceDay == 1) {
    formatTime = "Yesterday";
  } else {
    formatTime = DateFormat.yMMMMd('en_US').format(time);
  }

  formatTime += " at " + DateFormat.jm('en_US').format(time);

  return formatTime;
}

String simpleFormatTime(DateTime? time) {
  if (time == null) {
    return "";
  }
  return DateFormat.yMMMMd('en_US').format(time);
}

String formatTimeOfDay(dynamic timeOfDay) {
  if (timeOfDay is TimeOfDay) {
    final now = DateTime.now();

    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    return DateFormat.jm().format(dateTime);
  }
  if (timeOfDay is DateTime) {
    return DateFormat.jm().format(timeOfDay);
  }
  return "";
}
