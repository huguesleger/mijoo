import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';
import 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_cooked_sheet.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_detail_content.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_detail_footer.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_photo.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_loaded_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_screen.dart';
import '../meals_fixtures.dart';

class MockMealsRepository extends Mock implements MealsRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

void main() {
  final spinach = fridgeItem('Épinards', unit: FridgeUnit.pack, bestBefore: some(today.add(const Duration(days: 1))));
  final eggs = fridgeItem('Oeufs', quantity: 6);
  final idea = mealIdea();

  testWidgets('lists the ideas with what the fridge covers', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      BlocProvider<MealsCubit>(
        create: (_) => MealsCubit(
          household: const HouseholdId('h1'),
          profile: profile,
          meals: MockMealsRepository(),
          fridge: MockFridgeRepository(),
        ),
        child: MjPage(
          child: MealsLoadedView(
            state: MealsLoaded(
              plan: some(MealPlan(ideas: [idea], craving: MealCraving.any, createdAt: today)),
              week: [WeekMeal(idea: idea, status: WeekMealStatus.cooked, addedAt: today)],
              items: [spinach, eggs],
              profile: profile,
              today: today,
              craving: MealCraving.any,
              generation: const MealsIdle(),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Ma semaine'), findsOneWidget);
    expect(find.text('Cuisiné'), findsOneWidget);
    expect(find.text('Dans ma semaine'), findsOneWidget);
    expect(find.text('Pour 4 · 30 min max'), findsOneWidget);
    expect(find.text('sans porc · sans arachides · 1 à finir vite'), findsOneWidget);
    expect(find.text('Gratin d’épinards'), findsWidgets);
    expect(find.text('2 sur 3 ingrédients du frigo'), findsOneWidget);
  });

  Future<void> pumpDetail(WidgetTester tester, MealDetailReady ready) => pumpScreen(
    tester,
    BlocProvider<MealDetailCubit>(
      create: (_) => MealDetailCubit(
        household: const HouseholdId('h1'),
        profile: profile,
        idea: idea.id,
        meals: MockMealsRepository(),
        fridge: MockFridgeRepository(),
      ),
      child: MjPhotoPage(
        photo: MealPhoto(idea: ready.idea),
        onBack: () {},
        footer: some(MealDetailFooter(ready: ready)),
        child: MealDetailContent(ready: ready),
      ),
    ),
  );

  MealDetailReady ready({required int servings, required MealDetailTab tab}) => MealDetailReady(
    idea: idea,
    items: [spinach, eggs],
    profile: profile,
    today: today,
    servings: servings,
    week: none(),
    tab: tab,
    cooking: const MealCookingIdle(),
    writeFailure: none(),
  );

  testWidgets('shows the ingredients for the chosen number of people', (WidgetTester tester) async {
    await pumpDetail(tester, ready(servings: 6, tab: MealDetailTab.ingredients));

    expect(tester.takeException(), isNull);
    expect(find.text('Gratin d’épinards'), findsOneWidget);
    expect(find.text('Facile'), findsOneWidget);
    expect(find.text('Épinards à finir'), findsOneWidget);
    expect(find.text('Pour 6 personnes'), findsOneWidget);
    expect(find.text('Recette prévue pour 4'), findsOneWidget);
    expect(find.text('6 pièces'), findsOneWidget);
    expect(find.text('150 g'), findsOneWidget);
    expect(find.textContaining('Il en manque'), findsOneWidget);
    expect(find.text('À acheter'), findsOneWidget);
    expect(find.text('J’ai cuisiné ce repas'), findsOneWidget);
  });

  testWidgets('shows the steps with their duration and equipment', (WidgetTester tester) async {
    await pumpDetail(tester, ready(servings: 4, tab: MealDetailTab.steps));

    expect(tester.takeException(), isNull);
    expect(find.text('Étape 1'), findsOneWidget);
    expect(find.text('Fais revenir les épinards.'), findsOneWidget);
    expect(find.text('Poêle'), findsOneWidget);
    expect(find.text('3 min'), findsOneWidget);
  });

  testWidgets('lets the parent adjust what leaves the fridge', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      Scaffold(
        body: SingleChildScrollView(
          child: MealCookedSheet(proposed: [MealDeduction(item: eggs, quantity: 4)]),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Il en reste 6 pièces'), findsOneWidget);
    expect(find.text('4 pièces'), findsOneWidget);
    await tester.tap(find.byTooltip('Retirer moins de Oeufs'));
    await tester.pump();
    expect(find.text('3 pièces'), findsOneWidget);
    expect(find.text('Mettre à jour le frigo'), findsOneWidget);
  });
}
