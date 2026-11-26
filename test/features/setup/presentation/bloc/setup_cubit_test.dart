import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/food_preferences.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_step.dart';
import 'package:mocktail/mocktail.dart';

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

void main() {
  const account = AccountId('camille');
  const householdId = HouseholdId('h1');
  late MockHouseholdRepository repository;

  setUpAll(() {
    registerFallbackValue(
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
    registerFallbackValue(householdId);
  });
  setUp(() => repository = MockHouseholdRepository());

  SetupCubit build(Option<HouseholdId> household) => SetupCubit(
    account: account,
    household: household,
    repository: repository,
  );

  Future<void> fillAndFinish(SetupCubit cubit) async {
    cubit
      ..update(adults: some(2), children: some(2))
      ..update(exclusions: some({FoodExclusion.pork}));
    await cubit.next();
    await cubit.next();
    cubit.update(
      budget: some('120,50'),
      postalCode: some('69001'),
      city: some('Lyon'),
    );
    await cubit.next();
  }

  blocTest<SetupCubit, SetupState>(
    'creates the household and saves the profile',
    build: () {
      when(
        () => repository.createHousehold(account),
      ).thenReturn(TaskEither.right(householdId));
      when(
        () => repository.saveProfile(householdId, any()),
      ).thenReturn(TaskEither.right(unit));
      return build(none());
    },
    act: fillAndFinish,
    skip: 5,
    expect: () => [isA<SetupSaving>(), isA<SetupDone>()],
    verify: (_) {
      final profile =
          verify(
                () => repository.saveProfile(householdId, captureAny()),
              ).captured.single
              as HouseholdProfile;
      expect(profile.people, 4);
      expect(profile.exclusions, ['pork']);
      expect(profile.weeklyBudgetCents, const Some(12050));
      expect(profile.location.map((it) => it.postalCode), const Some('69001'));
    },
  );

  blocTest<SetupCubit, SetupState>(
    'reuses an existing household',
    build: () {
      when(
        () => repository.saveProfile(householdId, any()),
      ).thenReturn(TaskEither.right(unit));
      return build(some(householdId));
    },
    act: fillAndFinish,
    verify: (_) => verifyNever(() => repository.createHousehold(any())),
  );

  blocTest<SetupCubit, SetupState>(
    'does not create a second household when retrying a failed save',
    build: () {
      when(
        () => repository.createHousehold(account),
      ).thenReturn(TaskEither.right(householdId));
      when(
        () => repository.saveProfile(householdId, any()),
      ).thenReturn(TaskEither.left(const HouseholdNetworkFailure()));
      return build(none());
    },
    act: (cubit) async {
      await fillAndFinish(cubit);
      await cubit.next();
    },
    verify: (_) {
      verify(() => repository.createHousehold(account)).called(1);
      verify(() => repository.saveProfile(householdId, any())).called(2);
    },
  );

  test('blocks the last step on an invalid budget or postal code', () {
    final cubit = build(none());
    const draft = SetupCubit.initialDraft;
    expect(cubit.canContinue(draft, SetupStep.budget), isTrue);
    expect(
      cubit.canContinue((
        adults: draft.adults,
        children: draft.children,
        maxPrepMinutes: draft.maxPrepMinutes,
        likes: draft.likes,
        exclusions: draft.exclusions,
        allergies: draft.allergies,
        budget: 'abc',
        postalCode: '',
        city: '',
      ), SetupStep.budget),
      isFalse,
    );
    expect(
      cubit.canContinue((
        adults: draft.adults,
        children: draft.children,
        maxPrepMinutes: draft.maxPrepMinutes,
        likes: draft.likes,
        exclusions: draft.exclusions,
        allergies: draft.allergies,
        budget: '',
        postalCode: '690',
        city: '',
      ), SetupStep.budget),
      isFalse,
    );
  });
}
