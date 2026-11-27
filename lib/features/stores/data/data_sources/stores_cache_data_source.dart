import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/stores/data/mappers/store_mapper.dart';
import 'package:mijoo/features/stores/domain/entities/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef CachedStores = ({List<Store> stores, DateTime at});

class StoresCacheDataSource {
  StoresCacheDataSource({SharedPreferencesAsync? preferences}) : _preferences = preferences ?? SharedPreferencesAsync();

  static const String prefix = 'stores.';

  final SharedPreferencesAsync _preferences;

  Task<Option<CachedStores>> read(String key) => TaskEither<Object, Option<CachedStores>>.tryCatch(
    () => _preferences
        .getString('$prefix$key')
        .then((String? body) => Option<String>.fromNullable(body).flatMap(jsonToCachedStores)),
    (Object error, StackTrace stack) => _logged(error, stack),
  ).match((_) => none<CachedStores>(), (Option<CachedStores> cached) => cached);

  Task<Unit> write(String key, List<Store> stores, DateTime at) => TaskEither<Object, Unit>.tryCatch(
    () => _preferences.setString('$prefix$key', cachedStoresToJson(stores, at)).then((_) => unit),
    (Object error, StackTrace stack) => _logged(error, stack),
  ).match((_) => unit, (Unit done) => done);

  Object _logged(Object error, StackTrace stack) {
    log('stores cache ${error.runtimeType}', name: 'mijoo.stores', stackTrace: stack);
    return error;
  }
}
