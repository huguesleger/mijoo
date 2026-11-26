import 'package:equatable/equatable.dart';

/// A failure that occurred in the app.
///
/// Every `TaskEither` of the app fails with an [AppFailure], so operations can
/// be composed one after the other. Each feature defines its own failures.
abstract class AppFailure extends Equatable {
  const AppFailure();

  @override
  List<Object?> get props => <Object?>[];
}

/// A failure whose cause is not modelled by a dedicated [AppFailure].
class UnknownFailure extends AppFailure {
  const UnknownFailure();
}
