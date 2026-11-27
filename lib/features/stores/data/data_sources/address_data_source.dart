import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/data/mappers/store_mapper.dart';
import 'package:mijoo/features/stores/domain/entities/coordinates.dart';
import 'package:mijoo/features/stores/domain/stores_failure.dart';

final class AddressDataSource {
  AddressDataSource({http.Client? client}) : _client = client ?? http.Client();

  static const String host = 'api-adresse.data.gouv.fr';
  static const Duration timeout = Duration(seconds: 8);

  final http.Client _client;
  final Map<String, Coordinates> _cache = <String, Coordinates>{};

  TaskEither<AppFailure, Coordinates> locate(HouseholdLocation town) {
    final String key = '${town.postalCode}|${town.city}';
    return switch (_cache[key]) {
      final Coordinates cached => TaskEither<AppFailure, Coordinates>.right(cached),
      null =>
        TaskEither<AppFailure, http.Response>.tryCatch(
              () => _client
                  .get(
                    Uri.https(host, '/search/', <String, String>{
                      'q': town.city.trim().isEmpty ? town.postalCode : town.city,
                      'postcode': town.postalCode,
                      'type': 'municipality',
                      'limit': '1',
                    }),
                  )
                  .timeout(timeout),
              (Object error, StackTrace stack) {
                log('address ${error.runtimeType}', name: 'mijoo.stores', stackTrace: stack);
                return const StoresNetworkFailure();
              },
            )
            .flatMap(
              (http.Response response) => TaskEither<AppFailure, Coordinates>.fromOption(
                response.statusCode == 200 ? banToCoordinates(response.body) : none(),
                () => response.statusCode == 200 ? const StoresTownNotFound() : const StoresNetworkFailure(),
              ),
            )
            .map((Coordinates center) => _cache[key] = center),
    };
  }
}
