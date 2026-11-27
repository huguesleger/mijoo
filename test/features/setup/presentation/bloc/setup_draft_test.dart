import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/food_preferences.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';

void main() {
  const profile = HouseholdProfile(
    adults: 2,
    children: 1,
    likes: ['pasta', 'inconnu'],
    exclusions: ['pork'],
    allergies: ['peanuts'],
    maxPrepMinutes: 45,
    weeklyBudgetCents: Some(8550),
    location: Some(HouseholdLocation(postalCode: '69001', city: 'Lyon')),
  );

  test('prefills the draft from the saved profile', () {
    final draft = profileToSetupDraft(profile);
    expect(draft.adults, 2);
    expect(draft.children, 1);
    expect(draft.maxPrepMinutes, 45);
    expect(draft.likes, {FoodLike.pasta});
    expect(draft.exclusions, {FoodExclusion.pork});
    expect(draft.allergies, {Allergen.peanuts});
    expect(draft.budget, '85,50');
    expect(draft.postalCode, '69001');
    expect(draft.city, 'Lyon');
  });

  test('gives back the same profile once saved', () {
    final saved = setupDraftToProfile(profileToSetupDraft(profile));
    expect(saved.people, 3);
    expect(saved.likes, ['pasta']);
    expect(saved.weeklyBudgetCents, const Some(8550));
    expect(saved.location.map((it) => it.city), const Some('Lyon'));
  });

  test('leaves the budget and the town empty when the profile has none', () {
    final draft = profileToSetupDraft(
      const HouseholdProfile(
        adults: 1,
        children: 0,
        likes: [],
        exclusions: [],
        allergies: [],
        maxPrepMinutes: 30,
        weeklyBudgetCents: None(),
        location: None(),
      ),
    );
    expect(draft.budget, '');
    expect(draft.postalCode, '');
    expect(setupDraftToProfile(draft).weeklyBudgetCents, const None());
  });

  test('writes a whole budget without cents', () {
    expect(formatWeeklyBudget(12000), '120');
    expect(formatWeeklyBudget(12005), '120,05');
  });
}
