import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_list_rules.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mijoo/features/shopping/presentation/bloc/shopping_cubit.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_line_sheet.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_loaded_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_screen.dart';
import '../../meals/meals_fixtures.dart';
import '../shopping_fixtures.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

class MockMealsRepository extends Mock implements MealsRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

void main() {
  final facts = (
    week: [
      weekMeal('Omelette', [ingredient('Œufs', quantity: 4)]),
      weekMeal('Salade de pâtes', [
        ingredient('Oeufs', quantity: 3),
        ingredient('Carottes', quantity: 800, unit: FridgeUnit.gram),
      ], order: 1),
    ],
    items: [fridgeItem('Oeufs', quantity: 2)],
    entries: [entry('m1', key: 'sac poubelle', name: 'Sacs poubelle', quantity: some(1), manual: true)],
  );

  testWidgets('groups the list by aisle with packaging and reserved stock', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      BlocProvider<ShoppingCubit>(
        create: (_) => ShoppingCubit(
          household: const HouseholdId('h1'),
          author: 'Camille',
          shopping: MockShoppingRepository(),
          meals: MockMealsRepository(),
          fridge: MockFridgeRepository(),
        ),
        child: MjPage(
          child: ShoppingLoadedView(
            list: shoppingList(facts),
            state: ShoppingLoaded(facts: facts, writeFailure: none()),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('repas prévus'), findsOneWidget);
    expect(find.text('Œufs'), findsOneWidget);
    expect(find.text('1 × boîte de 6'), findsOneWidget);
    expect(find.text('il faut 5 pièces'), findsOneWidget);
    expect(find.text('Omelette · Salade de pâtes'), findsWidgets);
    expect(find.text('800 g'), findsOneWidget);
    expect(find.text('Ajouté à la main'), findsOneWidget);
    expect(find.text('Ajouté par Camille'), findsOneWidget);
    expect(find.text('Déjà dans le frigo'), findsOneWidget);
  });

  testWidgets('lets the parent adjust a line of the list', (WidgetTester tester) async {
    final eggs = shoppingList(facts).lines.first;
    await pumpScreen(
      tester,
      Scaffold(
        body: SingleChildScrollView(child: ShoppingLineSheet(line: eggs)),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Il faut 5 pièces. Arrondi au conditionnement : boîte de 6.'), findsOneWidget);
    await tester.tap(find.byTooltip('Plus'));
    await tester.pump();
    expect(find.text('2 × boîte de 6'), findsOneWidget);
    expect(find.text('Retirer de la liste'), findsOneWidget);
  });
}
