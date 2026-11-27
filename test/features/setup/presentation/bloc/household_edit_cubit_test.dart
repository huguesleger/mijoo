import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/household_edit_cubit.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_draft.dart';
import 'package:mocktail/mocktail.dart';

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

void main() {
  const householdId = HouseholdId('h1');
  const profile = HouseholdProfile(
    adults: 2,
    children: 0,
    likes: ['pasta'],
    exclusions: [],
    allergies: [],
    maxPrepMinutes: 30,
    weeklyBudgetCents: Some(12000),
    location: None(),
  );
  late MockHouseholdRepository repository;

  setUpAll(() {
    registerFallbackValue(profile);
    registerFallbackValue(householdId);
  });
  setUp(() => repository = MockHouseholdRepository());

  HouseholdEditCubit build() => HouseholdEditCubit(
    household: householdId,
    profile: profile,
    repository: repository,
    minimalLoading: Duration.zero,
  );

  test('starts from the saved profile', () {
    final draft = build().state.draft;
    expect(draft.adults, 2);
    expect(draft.budget, '120');
  });

  blocTest<HouseholdEditCubit, HouseholdEditState>(
    'saves the changed profile of the same household',
    build: () {
      when(() => repository.saveProfile(householdId, any())).thenReturn(TaskEither.right(unit));
      return build();
    },
    act: (cubit) async {
      cubit.change(cubit.state.draft.copyWith(children: some(2), budget: some('95')));
      await cubit.save();
    },
    expect: () => [isA<HouseholdEditEditing>(), isA<HouseholdEditSaving>(), isA<HouseholdEditSaved>()],
    verify: (_) {
      final saved = verify(() => repository.saveProfile(householdId, captureAny())).captured.single as HouseholdProfile;
      expect(saved.children, 2);
      expect(saved.weeklyBudgetCents, const Some(9500));
      expect(saved.likes, ['pasta']);
    },
  );

  blocTest<HouseholdEditCubit, HouseholdEditState>(
    'keeps the draft when the save fails',
    build: () {
      when(
        () => repository.saveProfile(householdId, any()),
      ).thenReturn(TaskEither.left(const HouseholdNetworkFailure()));
      return build();
    },
    act: (cubit) => cubit.save(),
    expect: () => [
      isA<HouseholdEditSaving>(),
      isA<HouseholdEditFailed>()
          .having((state) => state.failure, 'failure', const HouseholdNetworkFailure())
          .having((state) => state.draft.budget, 'budget', '120'),
    ],
  );

  blocTest<HouseholdEditCubit, HouseholdEditState>(
    'does not save an invalid postal code',
    build: build,
    act: (cubit) async {
      cubit.change(cubit.state.draft.copyWith(postalCode: some('690')));
      await cubit.save();
    },
    expect: () => [isA<HouseholdEditEditing>()],
    verify: (_) => verifyNever(() => repository.saveProfile(any(), any())),
  );
}
