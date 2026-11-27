import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/stores/data/data_sources/stores_cache_data_source.dart';
import 'package:mijoo/features/stores/data/mappers/store_mapper.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/stores_failure.dart';

final class OverpassDataSource {
  OverpassDataSource({
    StoresCacheDataSource? cache,
    http.Client? client,
    DateTime Function()? clock,
    Duration retryDelay = const Duration(seconds: 5),
  }) : _retryDelay = retryDelay,
       _deviceCache = cache ?? StoresCacheDataSource(),
       _client = client ?? http.Client(),
       _clock = clock ?? DateTime.now;

  static final Uri endpoint = Uri.https('overpass-api.de', '/api/interpreter');
  static const Duration timeout = Duration(seconds: 60);
  static const Duration cacheLifetime = Duration(minutes: 15);
  static const Duration deviceCacheLifetime = Duration(days: 7);
  static const int maxResults = 400;

  final Duration _retryDelay;
  final StoresCacheDataSource _deviceCache;
  final http.Client _client;
  final DateTime Function() _clock;
  final Map<String, CachedStores> _cache = <String, CachedStores>{};

  TaskEither<AppFailure, List<Store>> storesAround(Coordinates center, StoreRadius radius, {required bool remember}) {
    final String key = '${center.latitude.toStringAsFixed(3)},${center.longitude.toStringAsFixed(3)},${radius.meters}';
    return switch (_cache[key]) {
      final CachedStores cached when _clock().difference(cached.at) < cacheLifetime =>
        TaskEither<AppFailure, List<Store>>.right(cached.stores),
      _ when remember => _fromDevice(key, center, radius),
      _ => _fetch(center, radius, retry: true).map((List<Store> stores) => _keep(key, stores)),
    };
  }

  TaskEither<AppFailure, List<Store>> _fromDevice(String key, Coordinates center, StoreRadius radius) =>
      TaskEither<AppFailure, Option<CachedStores>>.fromTask(_deviceCache.read(key)).flatMap(
        (Option<CachedStores> saved) => switch (saved) {
          Some(value: final CachedStores cached) when _clock().difference(cached.at) < deviceCacheLifetime =>
            TaskEither<AppFailure, List<Store>>.right(_keep(key, cached.stores)),
          _ =>
            _fetch(center, radius, retry: true)
                .flatMap(
                  (List<Store> stores) => TaskEither<AppFailure, Unit>.fromTask(
                    _deviceCache.write(key, stores, _clock()),
                  ).map((_) => _keep(key, stores)),
                )
                .orElse(
                  (AppFailure failure) => saved.match(
                    () => TaskEither<AppFailure, List<Store>>.left(failure),
                    (CachedStores stale) => TaskEither<AppFailure, List<Store>>.right(stale.stores),
                  ),
                ),
        },
      );

  List<Store> _keep(String key, List<Store> stores) {
    _cache[key] = (stores: stores, at: _clock());
    return stores;
  }

  TaskEither<AppFailure, List<Store>> _fetch(Coordinates center, StoreRadius radius, {required bool retry}) =>
      TaskEither<AppFailure, http.Response>.tryCatch(
        () => _client
            .post(
              endpoint,
              headers: <String, String>{'User-Agent': 'Mijoo (application familiale)'},
              body: <String, String>{'data': overpassQuery(center, radius)},
            )
            .timeout(timeout),
        (Object error, StackTrace stack) {
          log('overpass ${error.runtimeType}', name: 'mijoo.stores', stackTrace: stack);
          return const StoresNetworkFailure();
        },
      ).flatMap(
        (http.Response response) => switch (response.statusCode) {
          200 => TaskEither<AppFailure, List<Store>>.right(overpassToStores(response.body)),
          429 || 502 || 504 when retry => TaskEither<AppFailure, Unit>(
            () => Future<Either<AppFailure, Unit>>.delayed(_retryDelay, () => right(unit)),
          ).flatMap((_) => _fetch(center, radius, retry: false)),
          429 || 502 || 503 || 504 => TaskEither<AppFailure, List<Store>>.left(const StoresBusy()),
          _ => TaskEither<AppFailure, List<Store>>.left(const StoresNetworkFailure()),
        },
      );

  static String overpassQuery(Coordinates center, StoreRadius radius) {
    final String around = '(around:${radius.meters},${center.latitude},${center.longitude})';
    return '[out:json][timeout:50];('
        'nwr["shop"~"^(supermarket|convenience|greengrocer|butcher|bakery|organic|cheese|frozen_food)\$"]$around;'
        'nwr["amenity"="marketplace"]$around;'
        ');out center tags $maxResults;';
  }
}
