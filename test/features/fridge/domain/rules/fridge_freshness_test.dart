import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_freshness.dart';

FridgeItem item(String name, Option<DateTime> bestBefore) => FridgeItem(
  id: FridgeItemId(name),
  name: name,
  quantity: 1,
  unit: FridgeUnit.piece,
  category: FridgeCategory.dairy,
  bestBefore: bestBefore,
);

void main() {
  final DateTime today = DateTime(2026, 11, 27, 18, 30);
  final FridgeItem expired = item('Lait', some(DateTime(2026, 11, 26)));
  final FridgeItem tomorrow = item('Yaourts', some(DateTime(2026, 11, 28)));
  final FridgeItem inThreeDays = item('Beurre', some(DateTime(2026, 11, 30)));
  final FridgeItem later = item('Fromage', some(DateTime(2026, 12, 15)));
  final FridgeItem undated = item('Riz', none());

  test('counts whole days whatever the hour', () {
    expect(daysLeft(tomorrow, today), some(1));
    expect(daysLeft(undated, today), isA<None>());
  });

  test('sorts items by how fresh they are', () {
    expect(fridgeFreshness(expired, today), FridgeFreshness.expired);
    expect(fridgeFreshness(tomorrow, today), FridgeFreshness.urgent);
    expect(fridgeFreshness(inThreeDays, today), FridgeFreshness.soon);
    expect(fridgeFreshness(later, today), FridgeFreshness.fresh);
    expect(fridgeFreshness(undated, today), FridgeFreshness.fresh);
  });

  test('summarizes the fridge', () {
    final FridgeFreshnessSummary summary = fridgeFreshnessSummary(
      <FridgeItem>[expired, tomorrow, inThreeDays, later, undated],
      today,
    );
    expect(summary, (total: 5, toFinish: 2, expired: 1));
  });

  test('lists what to finish first, the oldest first', () {
    expect(
      itemsToFinishFirst(<FridgeItem>[later, inThreeDays, undated, expired, tomorrow], today).map(
        (FridgeItem item) => item.name,
      ),
      <String>['Lait', 'Yaourts', 'Beurre'],
    );
  });
}
