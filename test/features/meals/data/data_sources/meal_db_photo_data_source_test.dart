import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mijoo/features/meals/data/data_sources/meal_db_photo_data_source.dart';

void main() {
  http.Response meals(List<String> thumbs) => http.Response(
    jsonEncode({
      'meals': thumbs.isEmpty
          ? null
          : [
              for (final String thumb in thumbs) {'strMealThumb': thumb},
            ],
    }),
    200,
  );

  test('tries the precise dish, then the broader ones, then the main ingredient', () async {
    final asked = <String>[];
    final source = MealDbPhotoDataSource(
      client: MockClient((request) async {
        asked.add('${request.url.path.split('/').last} ${request.url.queryParameters.values.single}');
        return switch (request.url.queryParameters) {
          {'i': 'spinach'} => meals(['https://www.themealdb.com/spinach.jpg']),
          _ => meals([]),
        };
      }),
    );

    expect(
      await source.findThumb(['spinach gratin', 'gratin', 'spinach']).run(),
      some('https://www.themealdb.com/spinach.jpg'),
    );
    expect(asked, ['search.php spinach gratin', 'search.php gratin', 'search.php spinach', 'filter.php spinach']);
  });

  test('stops at the first photo found', () async {
    var calls = 0;
    final source = MealDbPhotoDataSource(
      client: MockClient((_) async {
        calls++;
        return meals(['https://www.themealdb.com/omelette.jpg']);
      }),
    );
    expect(await source.findThumb(['omelette', 'egg']).run(), some('https://www.themealdb.com/omelette.jpg'));
    expect(calls, 1);
  });

  test('gives no photo when the service fails', () async {
    final source = MealDbPhotoDataSource(client: MockClient((_) async => throw Exception('offline')));
    expect(await source.findThumb(['omelette']).run(), isA<None>());
  });
}
