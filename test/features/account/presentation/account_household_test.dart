import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';
import 'package:mijoo/features/account/presentation/widgets/account_household.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

void main() {
  testWidgets('offers to edit the household', (WidgetTester tester) async {
    const account = AccountId('camille');
    final auth = MockAuthRepository();
    final households = MockHouseholdRepository();
    when(auth.watchSession).thenAnswer(
      (_) => Stream<Option<Account>>.value(some(const Account(id: account, email: 'camille@exemple.fr', name: None()))),
    );
    when(() => households.watchMembers(const HouseholdId('h1'))).thenAnswer(
      (_) => Stream.value(right(const [HouseholdMember(id: account, name: 'Camille')])),
    );
    when(() => households.watchHousehold(account)).thenAnswer(
      (_) => Stream<Option<Household>>.value(
        some(
          const Household(
            id: HouseholdId('h1'),
            memberIds: <AccountId>[account],
            profile: Some(
              HouseholdProfile(
                adults: 2,
                children: 0,
                likes: <String>[],
                exclusions: <String>[],
                allergies: <String>[],
                maxPrepMinutes: 30,
                weeklyBudgetCents: None(),
                location: None(),
              ),
            ),
          ),
        ),
      ),
    );

    await pumpScreen(
      tester,
      MultiBlocProvider(
        providers: [
          BlocProvider<SessionCubit>(
            create: (_) => SessionCubit(authRepository: auth, householdRepository: households),
          ),
          BlocProvider<HouseholdMembersCubit>(
            create: (_) => HouseholdMembersCubit(
              household: const HouseholdId('h1'),
              me: const HouseholdMember(id: account, name: 'Camille'),
              repository: households,
              minimalLoading: Duration.zero,
            )..watch(),
          ),
        ],
        child: const Scaffold(
          body: SingleChildScrollView(padding: EdgeInsets.all(20), child: AccountHousehold()),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Mon foyer'), findsOneWidget);
    expect(find.text('Modifier'), findsOneWidget);
    expect(find.text('Membres'), findsOneWidget);
    expect(find.text('Toi'), findsOneWidget);
    expect(find.text('Personne d’autre pour l’instant'), findsOneWidget);
    expect(find.text('Inviter quelqu’un'), findsOneWidget);
    expect(find.text('Quitter ce foyer'), findsOneWidget);
  });
}
