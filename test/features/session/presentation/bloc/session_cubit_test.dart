import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

void main() {
  const account = Account(
    id: AccountId('camille'),
    email: 'camille@example.test',
    name: Some('Camille'),
  );
  const household = Household(
    id: HouseholdId('h1'),
    memberIds: [AccountId('camille')],
    profile: None(),
  );
  late MockAuthRepository auth;
  late MockHouseholdRepository households;

  setUp(() {
    auth = MockAuthRepository();
    households = MockHouseholdRepository();
  });

  blocTest<SessionCubit, SessionState>(
    'follows the account and then its household',
    build: () {
      when(
        () => auth.watchSession(),
      ).thenAnswer((_) => Stream.fromIterable([none(), some(account)]));
      when(
        () => households.watchHousehold(account.id),
      ).thenAnswer((_) => Stream.fromIterable([none(), some(household)]));
      return SessionCubit(
        authRepository: auth,
        householdRepository: households,
      );
    },
    expect: () => [
      isA<SignedOut>(),
      isA<SignedIn>().having(
        (state) => state.household,
        'household',
        isA<HouseholdLoading>(),
      ),
      isA<SignedIn>().having(
        (state) => state.household,
        'household',
        isA<HouseholdMissing>(),
      ),
      isA<SignedIn>().having(
        (state) => state.household,
        'household',
        isA<HouseholdFound>(),
      ),
    ],
  );
}
