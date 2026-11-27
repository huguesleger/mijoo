part of 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';

@immutable
sealed class SetupState {
  const SetupState();
}

final class SetupChoosing extends SetupState {
  const SetupChoosing();
}

final class SetupEditing extends SetupState {
  const SetupEditing(this.draft, this.step);
  final SetupDraft draft;
  final SetupStep step;
}

final class SetupSaving extends SetupState {
  const SetupSaving(this.draft);
  final SetupDraft draft;
}

final class SetupFailed extends SetupState {
  const SetupFailed(this.draft, this.failure);
  final SetupDraft draft;
  final AppFailure failure;
}

final class SetupDone extends SetupState {
  const SetupDone();
}
