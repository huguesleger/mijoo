import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/meals/domain/meals_failure.dart';

final class MealDbPhotoDataSource {
  MealDbPhotoDataSource({http.Client? client}) : _client = client ?? http.Client();

  static const String host = 'www.themealdb.com';
  static const String basePath = '/api/json/v1/1';
  static const Duration timeout = Duration(seconds: 6);

  final http.Client _client;

  Task<Option<String>> findThumb(List<String> queries) =>
      <Task<Option<String>> Function()>[
        for (final String query in queries) () => _firstThumb('$basePath/search.php', <String, String>{'s': query}),
        if (queries.isNotEmpty)
          () => _firstThumb('$basePath/filter.php', <String, String>{'i': queries.last.replaceAll(' ', '_')}),
      ].fold<Task<Option<String>>>(
        Task<Option<String>>.of(none()),
        (Task<Option<String>> found, Task<Option<String>> Function() next) =>
            found.flatMap((Option<String> thumb) => thumb.isSome() ? Task<Option<String>>.of(thumb) : next()),
      );

  Task<Option<String>> _firstThumb(String path, Map<String, String> query) =>
      TaskEither<AppFailure, http.Response>.tryCatch(() => _client.get(Uri.https(host, path, query)).timeout(timeout), (
        Object error,
        StackTrace stack,
      ) {
        log('photo ${error.runtimeType}', name: 'mijoo.meals', stackTrace: stack);
        return const MealsNetworkFailure();
      }).match(
        (_) => none<String>(),
        (http.Response response) => response.statusCode == 200
            ? Option<Object?>.tryCatch(() => jsonDecode(response.body)).flatMap(
                (Object? data) => switch (data) {
                  {'meals': [{'strMealThumb': final String thumb}, ...]} => some(thumb),
                  _ => none<String>(),
                },
              )
            : none<String>(),
      );
}
