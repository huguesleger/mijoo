import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/food_preferences.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/rules/household_inputs.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_step.dart';

part 'package:mijoo/features/setup/presentation/bloc/setup_state.dart';

final class SetupCubit extends SafeCubit<SetupState> {
  SetupCubit({
    required AccountId account,
    required Option<HouseholdId> household,
    HouseholdRepository? repository,
  }) : _account = account,
       _household = household,
       _repository = repository ?? getIt.get<HouseholdRepository>(),
       super(const SetupEditing(initialDraft, SetupStep.household));

  static const initialDraft = (
    adults: 2,
    children: 0,
    maxPrepMinutes: 30,
    likes: <FoodLike>{},
    exclusions: <FoodExclusion>{},
    allergies: <Allergen>{},
    budget: '',
    postalCode: '',
    city: '',
  );

  final AccountId _account;
  final HouseholdRepository _repository;
  Option<HouseholdId> _household;

  void update({
    Option<int> adults = const None(),
    Option<int> children = const None(),
    Option<int> maxPrepMinutes = const None(),
    Option<Set<FoodLike>> likes = const None(),
    Option<Set<FoodExclusion>> exclusions = const None(),
    Option<Set<Allergen>> allergies = const None(),
    Option<String> budget = const None(),
    Option<String> postalCode = const None(),
    Option<String> city = const None(),
  }) {
    SetupDraft change(SetupDraft draft) => (
      adults: adults.getOrElse(() => draft.adults),
      children: children.getOrElse(() => draft.children),
      maxPrepMinutes: maxPrepMinutes.getOrElse(() => draft.maxPrepMinutes),
      likes: likes.getOrElse(() => draft.likes),
      exclusions: exclusions.getOrElse(() => draft.exclusions),
      allergies: allergies.getOrElse(() => draft.allergies),
      budget: budget.getOrElse(() => draft.budget),
      postalCode: postalCode.getOrElse(() => draft.postalCode),
      city: city.getOrElse(() => draft.city),
    );
    switch (state) {
      case SetupEditing(:final draft, :final step):
        emit(SetupEditing(change(draft), step));
      case SetupFailed(:final draft):
        emit(SetupEditing(change(draft), SetupStep.budget));
      case SetupSaving() || SetupDone():
        break;
    }
  }

  void back() => switch (state) {
    SetupEditing(:final draft, :final step) when step.index > 0 => emit(
      SetupEditing(draft, SetupStep.values[step.index - 1]),
    ),
    SetupFailed(:final draft) => emit(
      SetupEditing(draft, SetupStep.preferences),
    ),
    SetupEditing() || SetupSaving() || SetupDone() => null,
  };

  bool canContinue(SetupDraft draft, SetupStep step) => switch (step) {
    SetupStep.household || SetupStep.preferences => true,
    SetupStep.budget => parseWeeklyBudgetCents(draft.budget).isSome() && isValidPostalCode(draft.postalCode),
  };

  Future<void> next() => switch (state) {
    SetupEditing(:final draft, :final step) when step != SetupStep.budget => Future.sync(
      () => emit(SetupEditing(draft, SetupStep.values[step.index + 1])),
    ),
    SetupEditing(:final draft) || SetupFailed(:final draft) => _save(draft),
    SetupSaving() || SetupDone() => Future.value(),
  };

  Future<void> _save(SetupDraft draft) {
    if (!canContinue(draft, SetupStep.budget)) return Future.value();
    emit(SetupSaving(draft));
    final profile = _profile(draft);
    return _household
        .match(
          () => _repository.createHousehold(_account).map((id) {
            _household = some(id);
            return id;
          }),
          TaskEither<AppFailure, HouseholdId>.right,
        )
        .flatMap((id) => _repository.saveProfile(id, profile))
        .match<SetupState>(
          (failure) => SetupFailed(draft, failure),
          (_) => const SetupDone(),
        )
        .map(emit)
        .run();
  }

  HouseholdProfile _profile(SetupDraft draft) => HouseholdProfile(
    adults: draft.adults,
    children: draft.children,
    likes: draft.likes.map((like) => like.name).toList(),
    exclusions: draft.exclusions.map((exclusion) => exclusion.name).toList(),
    allergies: draft.allergies.map((allergen) => allergen.name).toList(),
    maxPrepMinutes: draft.maxPrepMinutes,
    weeklyBudgetCents: parseWeeklyBudgetCents(
      draft.budget,
    ).flatMap((budget) => budget),
    location: draft.postalCode.trim().isEmpty
        ? none()
        : some(
            HouseholdLocation(
              postalCode: draft.postalCode.trim(),
              city: draft.city.trim(),
            ),
          ),
  );
}
