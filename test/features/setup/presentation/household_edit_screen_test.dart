import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/household_edit_cubit.dart';
import 'package:mijoo/features/setup/presentation/household_edit_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_screen.dart';

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

Finder fieldWith(String value) =>
    find.byWidgetPredicate((Widget widget) => widget is EditableText && widget.controller.text == value);

void main() {
  testWidgets('shows the saved household ready to edit', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      BlocProvider<HouseholdEditCubit>(
        create: (_) => HouseholdEditCubit(
          household: const HouseholdId('h1'),
          profile: HouseholdProfile(
            adults: 2,
            children: 1,
            likes: const <String>['pasta'],
            exclusions: const <String>[],
            allergies: const <String>[],
            maxPrepMinutes: 45,
            weeklyBudgetCents: some(12000),
            location: some(const HouseholdLocation(postalCode: '69001', city: 'Lyon')),
          ),
          repository: MockHouseholdRepository(),
          minimalLoading: Duration.zero,
        ),
        child: const HouseholdEditScreen(),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Modifier mon foyer'), findsOneWidget);
    expect(find.text('Composition'), findsOneWidget);
    expect(fieldWith('120'), findsOneWidget);
    expect(fieldWith('69001'), findsOneWidget);
    expect(fieldWith('Lyon'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed, isNotNull);
  });
}
