import 'package:fpdart/fpdart.dart';

import 'package:mijoo/features/household/domain/entities/food_preferences.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/rules/household_inputs.dart';

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

const SetupDraft initialSetupDraft = (
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

extension SetupDraftChange on SetupDraft {
  SetupDraft copyWith({
    Option<int> adults = const None(),
    Option<int> children = const None(),
    Option<int> maxPrepMinutes = const None(),
    Option<Set<FoodLike>> likes = const None(),
    Option<Set<FoodExclusion>> exclusions = const None(),
    Option<Set<Allergen>> allergies = const None(),
    Option<String> budget = const None(),
    Option<String> postalCode = const None(),
    Option<String> city = const None(),
  }) => (
    adults: adults.getOrElse(() => this.adults),
    children: children.getOrElse(() => this.children),
    maxPrepMinutes: maxPrepMinutes.getOrElse(() => this.maxPrepMinutes),
    likes: likes.getOrElse(() => this.likes),
    exclusions: exclusions.getOrElse(() => this.exclusions),
    allergies: allergies.getOrElse(() => this.allergies),
    budget: budget.getOrElse(() => this.budget),
    postalCode: postalCode.getOrElse(() => this.postalCode),
    city: city.getOrElse(() => this.city),
  );
}

bool isCompleteSetupDraft(SetupDraft draft) =>
    parseWeeklyBudgetCents(draft.budget).isSome() && isValidPostalCode(draft.postalCode);

HouseholdProfile setupDraftToProfile(SetupDraft draft) => HouseholdProfile(
  adults: draft.adults,
  children: draft.children,
  likes: draft.likes.map((FoodLike like) => like.name).toList(),
  exclusions: draft.exclusions.map((FoodExclusion exclusion) => exclusion.name).toList(),
  allergies: draft.allergies.map((Allergen allergen) => allergen.name).toList(),
  maxPrepMinutes: draft.maxPrepMinutes,
  weeklyBudgetCents: parseWeeklyBudgetCents(draft.budget).flatMap((Option<int> budget) => budget),
  location: draft.postalCode.trim().isEmpty
      ? none()
      : some(HouseholdLocation(postalCode: draft.postalCode.trim(), city: draft.city.trim())),
);

SetupDraft profileToSetupDraft(HouseholdProfile profile) => (
  adults: profile.adults,
  children: profile.children,
  maxPrepMinutes: profile.maxPrepMinutes,
  likes: _known(FoodLike.values, profile.likes),
  exclusions: _known(FoodExclusion.values, profile.exclusions),
  allergies: _known(Allergen.values, profile.allergies),
  budget: profile.weeklyBudgetCents.match(() => '', formatWeeklyBudget),
  postalCode: profile.location.match(() => '', (HouseholdLocation location) => location.postalCode),
  city: profile.location.match(() => '', (HouseholdLocation location) => location.city),
);

String formatWeeklyBudget(int cents) => switch (cents % 100) {
  0 => '${cents ~/ 100}',
  final int rest => '${cents ~/ 100},${rest.toString().padLeft(2, '0')}',
};

Set<T> _known<T extends Enum>(List<T> values, List<String> names) =>
    values.where((T value) => names.contains(value.name)).toSet();
