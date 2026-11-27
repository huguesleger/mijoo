import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/stores_failure.dart';

final class PositionDataSource {
  static const LocationSettings settings = LocationSettings(
    accuracy: LocationAccuracy.medium,
    timeLimit: Duration(seconds: 15),
  );

  TaskEither<AppFailure, Coordinates> current() => _attempt(Geolocator.isLocationServiceEnabled)
      .flatMap(
        (bool enabled) =>
            enabled ? _permission() : TaskEither<AppFailure, LocationPermission>.left(const StoresLocationOff()),
      )
      .flatMap(
        (LocationPermission permission) => switch (permission) {
          LocationPermission.whileInUse || LocationPermission.always => _attempt(
            () => Geolocator.getCurrentPosition(locationSettings: settings),
          ),
          LocationPermission.denied ||
          LocationPermission.deniedForever ||
          LocationPermission.unableToDetermine => TaskEither<AppFailure, Position>.left(const StoresLocationDenied()),
        },
      )
      .map((Position position) => Coordinates(latitude: position.latitude, longitude: position.longitude));

  TaskEither<AppFailure, LocationPermission> _permission() => _attempt(Geolocator.checkPermission).flatMap(
    (LocationPermission permission) => permission == LocationPermission.denied
        ? _attempt(Geolocator.requestPermission)
        : TaskEither<AppFailure, LocationPermission>.right(permission),
  );

  TaskEither<AppFailure, T> _attempt<T>(Future<T> Function() run) => TaskEither<AppFailure, T>.tryCatch(run, (
    Object error,
    StackTrace stack,
  ) {
    log('position ${error.runtimeType}', name: 'mijoo.stores', stackTrace: stack);
    return switch (error) {
      PermissionDeniedException() => const StoresLocationDenied(),
      _ => const StoresLocationOff(),
    };
  });
}
