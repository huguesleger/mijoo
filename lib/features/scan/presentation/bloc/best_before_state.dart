part of 'package:mijoo/features/scan/presentation/bloc/best_before_cubit.dart';

@immutable
sealed class BestBeforeState {
  const BestBeforeState();
}

final class BestBeforeIdle extends BestBeforeState {
  const BestBeforeIdle();
}

final class BestBeforeReading extends BestBeforeState {
  const BestBeforeReading();
}

final class BestBeforeRead extends BestBeforeState {
  const BestBeforeRead(this.date);

  final DateTime date;
}

final class BestBeforeNotFound extends BestBeforeState {
  const BestBeforeNotFound();
}

final class BestBeforeFailed extends BestBeforeState {
  const BestBeforeFailed(this.failure);

  final AppFailure failure;
}
