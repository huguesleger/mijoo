import 'package:flutter/foundation.dart';
import 'package:mijoo/config/setup_get_it.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';

part 'package:mijoo/features/setup/presentation/bloc/household_edit_state.dart';

final class HouseholdEditCubit extends SafeCubit<HouseholdEditState> {
  HouseholdEditCubit({
    required HouseholdId household,
    required HouseholdProfile profile,
    HouseholdRepository? repository,
    Duration? minimalLoading,
  }) : _household = household,
       _repository = repository ?? getIt.get<HouseholdRepository>(),
       _minimalLoading = minimalLoading ?? MjLoader.minDuration,
       super(HouseholdEditEditing(profileToSetupDraft(profile)));

  final HouseholdId _household;
  final HouseholdRepository _repository;
  final Duration _minimalLoading;

  void change(SetupDraft draft) => switch (state) {
    HouseholdEditEditing() || HouseholdEditFailed() => emit(HouseholdEditEditing(draft)),
    HouseholdEditSaving() || HouseholdEditSaved() => null,
  };

  Future<void> save() => switch (state) {
    HouseholdEditEditing(:final draft) || HouseholdEditFailed(:final draft) when isCompleteSetupDraft(draft) => _save(
      draft,
    ),
    HouseholdEditEditing() || HouseholdEditFailed() || HouseholdEditSaving() || HouseholdEditSaved() => Future.value(),
  };

  Future<void> _save(SetupDraft draft) {
    emit(HouseholdEditSaving(draft));
    return _repository
        .saveProfile(_household, setupDraftToProfile(draft))
        .withMinimalDelay(_minimalLoading)
        .match<HouseholdEditState>(
          (AppFailure failure) => HouseholdEditFailed(draft, failure),
          (_) => HouseholdEditSaved(draft),
        )
        .map(emit)
        .run();
  }
}
