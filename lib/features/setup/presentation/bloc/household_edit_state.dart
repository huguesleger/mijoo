part of 'package:mijoo/features/setup/presentation/bloc/household_edit_cubit.dart';

@immutable
sealed class HouseholdEditState {
  const HouseholdEditState(this.draft);
  final SetupDraft draft;
}

final class HouseholdEditEditing extends HouseholdEditState {
  const HouseholdEditEditing(super.draft);
}

final class HouseholdEditSaving extends HouseholdEditState {
  const HouseholdEditSaving(super.draft);
}

final class HouseholdEditFailed extends HouseholdEditState {
  const HouseholdEditFailed(super.draft, this.failure);
  final AppFailure failure;
}

final class HouseholdEditSaved extends HouseholdEditState {
  const HouseholdEditSaved(super.draft);
}
