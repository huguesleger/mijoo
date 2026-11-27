import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/shopping/domain/entities/expense.dart';
import 'package:mijoo/features/shopping/domain/entities/household_price.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';

const int maxPriceCents = 10000000;

Option<HouseholdPrice> firestoreToHouseholdPrice(Map<String, Object?> data) => switch (data) {
  {'key': final String key, 'name': final String name, 'cents': final num cents, 'basis': final String basis}
      when cents > 0 && cents <= maxPriceCents =>
    Option<PriceBasis>.fromNullable(
      PriceBasis.values.where((PriceBasis value) => value.name == basis).firstOrNull,
    ).map((PriceBasis basis) => HouseholdPrice(key: key, name: name, cents: cents.toDouble(), basis: basis)),
  _ => none(),
};

String householdPriceDocument(String key) => 'price-${key.replaceAll(RegExp('[^a-z0-9]+'), '-')}';

Map<String, Object?> householdPriceToFirestore(HouseholdPrice price) => <String, Object?>{
  'key': price.key,
  'name': price.name,
  'cents': price.cents,
  'basis': price.basis.name,
};

Option<Expense> firestoreToExpense(String id, Map<String, Object?> data) => switch (data) {
  {'amountCents': final num amount, 'date': final Timestamp date} when amount > 0 => some(
    Expense(
      id: ExpenseId(id),
      input: ExpenseInput(
        amountCents: amount.round(),
        date: date.toDate(),
        store: switch (data['store']) {
          final String store when store.trim().isNotEmpty => some(store.trim()),
          _ => none(),
        },
        addedBy: switch (data['addedBy']) {
          final String name when name.isNotEmpty => some(name),
          _ => none(),
        },
      ),
    ),
  ),
  _ => none(),
};

Map<String, Object?> expenseToFirestore(ExpenseInput input) => <String, Object?>{
  'amountCents': input.amountCents,
  'date': Timestamp.fromDate(input.date),
  'store': input.store.map((String store) => store.trim()).toNullable(),
  'addedBy': input.addedBy.toNullable(),
};
