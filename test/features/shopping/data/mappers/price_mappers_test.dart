import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/shopping/data/mappers/open_price_mapper.dart';
import 'package:mijoo/features/shopping/data/mappers/price_expense_mapper.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';

void main() {
  test('summarizes Open Prices observations in euros and per kilogram', () {
    final body = jsonEncode({
      'items': [
        for (final (double price, String date) in [
          (0.55, '2026-11-16'),
          (1.69, '2026-10-29'),
          (2.49, '2026-11-16'),
          (1.2, '2026-11-02'),
          (2.9, '2026-10-30'),
        ])
          {'price': price, 'currency': 'EUR', 'price_per': 'KILOGRAM', 'date': date},
        {'price': 4.5, 'currency': 'SGD', 'price_per': 'KILOGRAM', 'date': '2026-11-23'},
        {'price': 2.88, 'currency': 'EUR', 'price_per': 'UNIT', 'date': '2026-11-21'},
      ],
    });
    final stats = openPricesToStats('en:carrots', PriceBasis.kilogram, body).toNullable()!;
    expect(stats.observations, 5);
    expect(stats.cents, closeTo(169, 0.001));
    expect(stats.lowCents, closeTo(55, 0.001));
    expect(stats.highCents, closeTo(290, 0.001));
    expect(stats.lastSeen, DateTime(2026, 11, 16));
    expect(openPricesToStats('en:carrots', PriceBasis.piece, body).map((it) => it.observations), some(1));
    expect(openPricesToStats('en:carrots', PriceBasis.kilogram, 'erreur'), isA<None>());
  });

  test('stores and reads back a household price and an expense', () {
    const price = HouseholdPrice(key: 'carotte', name: 'Carottes', cents: 115, basis: PriceBasis.kilogram);
    expect(firestoreToHouseholdPrice(householdPriceToFirestore(price)).map((it) => it.cents), some(115.0));
    expect(householdPriceDocument('pomme terre'), 'price-pomme-terre');
    expect(firestoreToHouseholdPrice({'key': 'x', 'name': 'X', 'cents': 0, 'basis': 'kilogram'}), isA<None>());

    final input = ExpenseInput(amountCents: 3870, date: DateTime(2026, 11, 27), store: some(' Lidl '), addedBy: none());
    final data = expenseToFirestore(input);
    expect(data['store'], 'Lidl');
    final read = firestoreToExpense('e1', {...data, 'date': Timestamp.fromDate(DateTime(2026, 11, 27))});
    expect(read.map((it) => it.input.amountCents), some(3870));
    expect(read.flatMap((it) => it.input.store), some('Lidl'));
  });
}
