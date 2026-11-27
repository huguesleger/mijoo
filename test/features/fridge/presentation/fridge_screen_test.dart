import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/fridge/presentation/bloc/fridge_cubit.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_loaded_view.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_add_choice_sheet.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_screen.dart';

class MockFridgeRepository extends Mock implements FridgeRepository {}

FridgeItem item(String name, FridgeCategory category, Option<DateTime> bestBefore) => FridgeItem(
  id: FridgeItemId(name),
  name: name,
  quantity: 4,
  unit: FridgeUnit.piece,
  category: category,
  bestBefore: bestBefore,
);

void main() {
  const HouseholdId household = HouseholdId('h1');

  testWidgets('shows the fridge with its freshness', (WidgetTester tester) async {
    final FridgeCubit cubit = FridgeCubit(household: household, repository: MockFridgeRepository());
    addTearDown(cubit.close);

    await pumpScreen(
      tester,
      BlocProvider<FridgeCubit>.value(
        value: cubit,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: FridgeLoadedView(
              state: FridgeLoaded(
                items: <FridgeItem>[
                  item('Épinards', FridgeCategory.fruitsVegetables, some(DateTime(2026, 11, 28))),
                  item('Tomates', FridgeCategory.fruitsVegetables, some(DateTime(2026, 11, 29))),
                  item('Yaourts nature', FridgeCategory.dairy, some(DateTime(2026, 11, 25))),
                  item('Riz', FridgeCategory.grocery, none()),
                ],
                query: '',
                category: none(),
                today: DateTime(2026, 11, 27),
                writeFailure: none(),
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Épinards'), findsOneWidget);
    expect(find.text(t.fridge.freshness.tomorrow), findsOneWidget);
    expect(find.text(t.fridge.freshness.inDays(count: 2)), findsOneWidget);
    expect(find.text(t.fridge.freshness.expired), findsOneWidget);
  });

  testWidgets('offers the four ways to add', (WidgetTester tester) async {
    await pumpScreen(tester, const Scaffold(body: FridgeAddChoiceSheet()));

    expect(tester.takeException(), isNull);
    expect(find.text(t.fridge.addPhoto), findsOneWidget);
    expect(find.text(t.fridge.addManual), findsOneWidget);
  });
}
