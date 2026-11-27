import 'dart:math' as math;

import 'package:mijoo/features/stores/domain/entities/coordinates.dart';

const double earthRadiusMeters = 6371000;

int distanceMeters(Coordinates from, Coordinates to) {
  double radians(double degrees) => degrees * math.pi / 180;
  final double latitudeDelta = radians(to.latitude - from.latitude);
  final double longitudeDelta = radians(to.longitude - from.longitude);
  final double haversine =
      math.pow(math.sin(latitudeDelta / 2), 2) +
      math.cos(radians(from.latitude)) * math.cos(radians(to.latitude)) * math.pow(math.sin(longitudeDelta / 2), 2);
  return (2 * earthRadiusMeters * math.asin(math.min(1, math.sqrt(haversine)))).round();
}
