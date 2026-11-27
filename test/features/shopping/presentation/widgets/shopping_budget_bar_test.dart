import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mijoo/features/shopping/domain/entities/basket_estimate.dart';
import 'package:mijoo/features/shopping/domain/entities/week_budget.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';
import 'package:mijoo/features/shopping/presentation/widgets/shopping_budget_bar.dart';

import '../../../../helpers/pump_screen.dart';

void main() {
  setUpAll(() => initializeDateFormatting('fr'));

  testWidgets('fills the bar with what is spent and planned', (WidgetTester tester) async {
    await pumpScreen(
      tester,
      Scaffold(
        body: SizedBox(
          width: 300,
          child: ShoppingBudgetBar(
            budget: WeekBudget(
              start: DateTime(2026, 11, 23),
              budgetCents: some(4000),
              spentCents: 1200,
              basket: const BasketEstimate(cents: 800, lowCents: 600, highCents: 1000, costs: {}, unpriced: {}),
            ),
          ),
        ),
      ),
    );
    final Size spent = tester.getSize(find.byType(ColoredBox).last);
    expect(spent.height, 12);
    expect(spent.width, closeTo(90, 1));
  });

  test('shows cents unless the amount is in whole euros', () {
    String plain(String text) => text.replaceAll(RegExp(r'\s'), ' ');
    expect(plain(euros(2451)), '24,51 €');
    expect(plain(euros(4000)), '40 €');
    expect(plain(euros(99)), '0,99 €');
  });
}
