import 'package:fpdart/fpdart.dart';

/// Makes an operation last at least a given duration.
///
/// A loader that appears and disappears in a flash looks like a glitch: waiting for a
/// minimal duration lets it play at least one full animation.
extension TaskEitherMinimalDelay<L, R> on TaskEither<L, R> {
  /// Completes with the same result, but never before [duration] has elapsed.
  TaskEither<L, R> withMinimalDelay(Duration duration) => TaskEither<L, R>(() {
    final Future<void> delay = Future<void>.delayed(duration);
    return run().then((Either<L, R> result) => delay.then((_) => result));
  });

  /// Like [withMinimalDelay], but a failure completes right away.
  TaskEither<L, R> withMinimalDelayOnRight(Duration duration) => TaskEither<L, R>(() {
    final Future<void> delay = Future<void>.delayed(duration);
    return run().then(
      (Either<L, R> result) => result.isRight() ? delay.then((_) => result) : Future<Either<L, R>>.value(result),
    );
  });
}
