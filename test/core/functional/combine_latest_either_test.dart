import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/functional/combine_latest_either.dart';

void main() {
  test('pairs the latest values and forwards failures', () async {
    final first = StreamController<Either<String, int>>();
    final second = StreamController<Either<String, String>>();
    final results = <Either<String, (int, String)>>[];
    final subscription = combineLatestEither(first.stream, second.stream).listen(results.add);

    first.add(right(1));
    await pumpEventQueue();
    expect(results, isEmpty);

    second.add(right('a'));
    first.add(right(2));
    second.add(left('panne'));
    await pumpEventQueue();
    expect(results, <Either<String, (int, String)>>[right((1, 'a')), right((2, 'a')), left('panne')]);

    await subscription.cancel();
    await first.close();
    await second.close();
  });
}
