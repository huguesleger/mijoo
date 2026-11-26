part of 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';

typedef SetupDraft = ({
  int adults,
  int children,
  int maxPrepMinutes,
  Set<FoodLike> likes,
  Set<FoodExclusion> exclusions,
  Set<Allergen> allergies,
  String budget,
  String postalCode,
  String city,
});

@immutable
sealed class SetupState {
  const SetupState();
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
