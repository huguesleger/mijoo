import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/account/presentation/widgets/account_household_tiles.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';

import '../../../helpers/pump_screen.dart';

void main() {
  testWidgets('summarizes the household', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: AccountHouseholdTiles(
            profile: HouseholdProfile(
              adults: 2,
              children: 1,
              likes: const <String>[],
              exclusions: const <String>[],
              allergies: const <String>['peanuts'],
              maxPrepMinutes: 30,
              weeklyBudgetCents: some(12000),
              location: some(const HouseholdLocation(postalCode: '69001', city: 'Lyon')),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('3 personnes'), findsOneWidget);
    expect(find.text('2 adultes, 1 enfant'), findsOneWidget);
    expect(find.text('1 allergie'), findsOneWidget);
  });
}
