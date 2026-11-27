import 'dart:async';

import 'package:fpdart/fpdart.dart';

/// Follows two streams of results and pairs their latest successes.
///
/// A failure of either stream is forwarded as soon as it arrives. A pair is emitted once both
/// streams have delivered a success, then each time one of them delivers a new one.
Stream<Either<L, (A, B)>> combineLatestEither<L, A, B>(Stream<Either<L, A>> first, Stream<Either<L, B>> second) =>
    Stream<Either<L, (A, B)>>.multi((MultiStreamController<Either<L, (A, B)>> controller) {
      Option<Either<L, A>> latestFirst = const None();
      Option<Either<L, B>> latestSecond = const None();
      void forward() => switch ((latestFirst, latestSecond)) {
        (Some(value: Left(value: final L failure)), _) ||
        (_, Some(value: Left(value: final L failure))) => controller.add(Either<L, (A, B)>.left(failure)),
        (Some(value: Right(value: final A a)), Some(value: Right(value: final B b))) => controller.add(
          Either<L, (A, B)>.right((a, b)),
        ),
        (None(), _) || (_, None()) => null,
      };
      final StreamSubscription<Either<L, A>> firstSubscription = first.listen((Either<L, A> value) {
        latestFirst = some(value);
        forward();
      }, onError: controller.addError);
      final StreamSubscription<Either<L, B>> secondSubscription = second.listen((Either<L, B> value) {
        latestSecond = some(value);
        forward();
      }, onError: controller.addError);
      controller.onCancel = () => Future.wait(<Future<void>>[firstSubscription.cancel(), secondSubscription.cancel()]);
    });
