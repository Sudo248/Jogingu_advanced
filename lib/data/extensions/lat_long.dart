import 'dart:math';

import 'package:mapbox_gl/mapbox_gl.dart';

const int R = 6371;

extension Radians on double {
  double toRadians() {
    return this * (pi / 180);
  }
}
// Distance km
extension Distance on LatLng {
  Future<double> distance(LatLng other) async{
    final rLat1 = latitude.toRadians();
    final rLng1 = longitude.toRadians();
    final rLat2 = other.latitude.toRadians();
    final rLng2 = other.longitude.toRadians();

    final deltaLong = rLng2 - rLng1;
    final deltaLat = rLat2 - rLat1;

    final ans = pow(sin(deltaLat / 2), 2) +
        cos(rLat1) * cos(rLat2) * pow(sin(deltaLong / 2), 2);

    return 2 * asin(sqrt(ans)) * R;
  }
}
