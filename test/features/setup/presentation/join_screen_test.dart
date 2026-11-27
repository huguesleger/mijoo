import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';
import 'package:mijoo/features/account/presentation/widgets/account_invite_sheet.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/join_cubit.dart';
import 'package:mijoo/features/setup/presentation/bloc/setup_cubit.dart';
import 'package:mijoo/features/setup/presentation/join_screen.dart';
import 'package:mijoo/features/setup/presentation/setup_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_screen.dart';

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

void main() {
  const me = HouseholdMember(id: AccountId('camille'), name: 'Camille');
  const household = HouseholdId('h1');

  testWidgets('offers to create or join a household', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      BlocProvider<SetupCubit>(
        create: (_) => SetupCubit(account: me.id, household: none(), repository: MockHouseholdRepository()),
        child: const SetupScreen(),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Créer mon foyer'), findsOneWidget);
    expect(find.text('Rejoindre un foyer'), findsOneWidget);
  });

  testWidgets('asks for the invitation code', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      BlocProvider<JoinCubit>(
        create: (_) => JoinCubit(me: me, repository: MockHouseholdRepository(), minimalLoading: Duration.zero),
        child: const JoinScreen(),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Code d’invitation'), findsOneWidget);
    expect(find.byType(MjCodeBox), findsNWidgets(6));
    expect(find.text('Rejoindre le foyer'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'mj-4k7q');
    await tester.pump();
    for (final character in ['M', 'J', '4', 'K', '7', 'Q']) {
      expect(find.descendant(of: find.byType(MjCodeBox), matching: find.text(character)), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the invitation code to share', (WidgetTester tester) async {
    final repository = MockHouseholdRepository();
    when(() => repository.watchMembers(household)).thenAnswer((_) => Stream.value(right(const [me])));
    when(() => repository.createInvite(household, me.id)).thenReturn(TaskEither.right(const InviteCode('MJ4K7Q')));
    final cubit = HouseholdMembersCubit(
      household: household,
      me: me,
      repository: repository,
      minimalLoading: Duration.zero,
    );
    addTearDown(cubit.close);
    await pumpScreen(
      tester,
      BlocProvider<HouseholdMembersCubit>.value(
        value: cubit,
        child: const Scaffold(body: SingleChildScrollView(child: AccountInviteSheet())),
      ),
    );
    cubit.watch();
    await tester.pump();
    unawaited(cubit.createInvite());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));

    expect(tester.takeException(), isNull);
    expect(find.text('Valable 48 h'), findsOneWidget);
    expect(find.text('Partager le code'), findsOneWidget);
    expect(find.byType(MjCodeDisplay), findsOneWidget);
  });
}
