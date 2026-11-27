import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_step.dart';

export 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';

part 'package:mijoo/features/setup/presentation/bloc/setup_state.dart';

final class SetupCubit extends SafeCubit<SetupState> {
  SetupCubit({
    required AccountId account,
    required Option<HouseholdId> household,
    HouseholdRepository? repository,
  }) : _account = account,
       _household = household,
       _repository = repository ?? getIt.get<HouseholdRepository>(),
       super(household.isNone() ? const SetupChoosing() : const SetupEditing(initialSetupDraft, SetupStep.household));

  final AccountId _account;
  final HouseholdRepository _repository;
  Option<HouseholdId> _household;

  void create() => switch (state) {
    SetupChoosing() => emit(const SetupEditing(initialSetupDraft, SetupStep.household)),
    SetupEditing() || SetupSaving() || SetupFailed() || SetupDone() => null,
  };

  void change(SetupDraft draft) => switch (state) {
    SetupEditing(:final step) => emit(SetupEditing(draft, step)),
    SetupFailed() => emit(SetupEditing(draft, SetupStep.budget)),
    SetupChoosing() || SetupSaving() || SetupDone() => null,
  };

  void back() => switch (state) {
    SetupEditing(:final draft, :final step) when step.index > 0 => emit(
      SetupEditing(draft, SetupStep.values[step.index - 1]),
    ),
    SetupFailed(:final draft) => emit(
      SetupEditing(draft, SetupStep.preferences),
    ),
    SetupEditing() when _household.isNone() => emit(const SetupChoosing()),
    SetupChoosing() || SetupEditing() || SetupSaving() || SetupDone() => null,
  };

  bool canContinue(SetupDraft draft, SetupStep step) => switch (step) {
    SetupStep.household || SetupStep.preferences => true,
    SetupStep.budget => isCompleteSetupDraft(draft),
  };

  Future<void> next() => switch (state) {
    SetupEditing(:final draft, :final step) when step != SetupStep.budget => Future.sync(
      () => emit(SetupEditing(draft, SetupStep.values[step.index + 1])),
    ),
    SetupEditing(:final draft) || SetupFailed(:final draft) => _save(draft),
    SetupChoosing() || SetupSaving() || SetupDone() => Future.value(),
  };

  Future<void> _save(SetupDraft draft) {
    if (!isCompleteSetupDraft(draft)) return Future.value();
    emit(SetupSaving(draft));
    return _household
        .match(
          () => _repository.createHousehold(_account).map((id) {
            _household = some(id);
            return id;
          }),
          TaskEither<AppFailure, HouseholdId>.right,
        )
        .flatMap((id) => _repository.saveProfile(id, setupDraftToProfile(draft)))
        .match<SetupState>(
          (failure) => SetupFailed(draft, failure),
          (_) => const SetupDone(),
        )
        .map(emit)
        .run();
  }
}
